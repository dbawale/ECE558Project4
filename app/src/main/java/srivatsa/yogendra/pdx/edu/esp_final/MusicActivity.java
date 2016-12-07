package srivatsa.yogendra.pdx.edu.esp_final;


/**
 * DONE: Replace LineGraph by BarGraph
 * Done: On exit from app or MusicActivity Disconnect bluetooth
 * Done: When application exists, disconnect bluetooth connection between phone and board : OnDestroy()
 * DONE: When bluetooth is switched off, then the application should return to MusicActivity.
 * DONE: OnResume, check if the Bluetooth connection exists, if not then the first Acivity MusicActiviy should be launched and the user be asked to connect to bluetooth.
 * DONE: Check if microphone is switched on when the application starts.
 * DONE: OnResume, check if microphone is on.
 * DONE: UI Enhancement
 * DONE: Send double color to an LED.
 * DONE: Color of the graph changes according to the LED value
 * DONE: The graph is inverted
 */


import android.Manifest;
import android.app.ProgressDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.FragmentActivity;
import android.support.v4.content.ContextCompat;
import android.util.Log;
import android.widget.Toast;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Random;
import java.util.UUID;

import be.tarsos.dsp.AudioDispatcher;
import be.tarsos.dsp.AudioEvent;
import be.tarsos.dsp.io.android.AudioDispatcherFactory;
import be.tarsos.dsp.pitch.PitchDetectionHandler;
import be.tarsos.dsp.pitch.PitchDetectionResult;
import be.tarsos.dsp.pitch.PitchProcessor;

public class MusicActivity extends FragmentActivity implements ConnectFragment.OnConnectButtonPressedListener, MusicFragment.OnMusicButtonPressedListener {

    private int size = 512;
    private int sampleRate = 24000;
    private AudioDispatcher dispatcher;
    private Thread threadData, threadMusic;
    private ArrayList<Double> amplitudeBuffer, pitchBuffer;
    private double dbLevel, pitchValue;
    private TransmitData transmitData;


    //Threshold Constants
    private static final int MIN = 0;
    private static final int AVG_MIN = 1;
    private static final int AVG = 2;
    private static final int AVG_MAX = 3;
    private static final int MAX = 4;

    private static final int[] intensityRange = {0,64,128,192,255};
    private double[] threshold = new double[5];
    private double[] pitchThreshold = new double[5];
    private static final int[] sleepRange = {50,87,125,162,200};


    //Bluetooth related variables
    String address = null;
    private ProgressDialog progress;
    BluetoothAdapter myBluetooth = null;
    BluetoothSocket btSocket = null;
    private boolean isBtConnected = false;
    static final UUID myUUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");
    private final int REQUEST_CODE_CONNECT =1;

    private  MusicFragment musicFragment;
    private int[] mArrayOfRandomNumbers;    // random number array
    private static final int RECORD_REQUEST_CODE = 101;
    private int backPressedCount = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_music);
        backPressedCount = 0;
        isMicrophoneOn();

        if(findViewById(R.id.connect_frame_layout)==null){
            if(savedInstanceState !=null){
                return;
            }
            ConnectFragment connectFragment = new ConnectFragment();
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.music_frame_layout,connectFragment)
                    .commit();
        }
    }

    /**
     * Specified by OnConnectButtonPressedListener
     * Starts the BluetoothActivity
     */
    @Override
    public void onConnectButtonPressed() {
        backPressedCount = 0;
        Intent connect_bluetooth = new Intent(MusicActivity.this,BluetoothActivity.class);
        startActivityForResult(connect_bluetooth,REQUEST_CODE_CONNECT);
    }

    /**
     * Specified by OnMusicButtonPressedListener
     * Initializes the audio dispatcher and starts threads to listen to music and transmit data
     */
    @Override
    public void onStartButtonPressed() {
        backPressedCount = 0;
        amplitudeBuffer = new ArrayList<Double>();
        pitchBuffer = new ArrayList<Double>();

        //Initialize audio dispatcher to listen from microphone
        dispatcher = AudioDispatcherFactory.fromDefaultMicrophone(sampleRate,1024,size);

        transmitData = new TransmitData(true);   // initialize data transmission object

        // Calculate the decibel level in the detected audio stream
        CalculatePitchAndDecibel();

        // Keep listening to music and calculate the decibel level for data captured in buffer
        threadMusic = new Thread(dispatcher,"Audio Dispatcher");
        // Keep polling 'dbLevel' to transmit appropriate color as per the decibel value
        threadData = new Thread(transmitData, "Color Transmition");
        threadMusic.start();
        threadData.start();
        Log.d("threads","Threads started");
    }

    @Override
    public void onStopButtonPressed() {
        backPressedCount = 0;
        transmitData.setMusic(false);   // send a clear data to stop the effects of musical lights

        // Send clear data to LEDs when stopped to listen to music.
        try {
            String data = generateColorData(transmitData.isMusic()).toString();
            btSocket.getOutputStream().write(data.getBytes());
        } catch (IOException e) {
            msg("Error");
        }

        // Make Parent thread running 'MusicActivity' wait on completion of data transmission thread
        // (threadData). This is necessary because we want to make sure that transmission thread
        // has finished sending data and its execution when stop is pressed, and before the parent
        // thread interuupts threadData and nullifies it.
        try {
            threadData.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        threadMusic.interrupt();
        threadMusic = null;
        threadData = null;

        // Nullify music listener and data transmission objects
        try{
            if(dispatcher!=null)
            {
                dispatcher.stop();
            }
            transmitData = null;
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Get the decibel threshold value at the specified index
     * @param index - index for the required decibel threshold value
     * @return - return the decibel threshold value
     */
    public double getThreshold(int index) {
        return this.threshold[index];
    }

    /**
     * Set the decibel threshold value for the given index
     * @param thresholdValue - decibel threshold value to be set
     * @param index - index at which this threshold has to be set
     */
    public void setThreshold(double thresholdValue, int index) {
        this.threshold[index] = thresholdValue;
    }

    /**
     * @return - Return the decibel level calculated.
     */
    public double getDbLevel() {
        return dbLevel;
    }

    /**
     *  Set the decibel level
     * @param dbLevel
     */
    public void setDbLevel(double dbLevel) {
        this.dbLevel = dbLevel;
    }

    /**
     * @return - Return the pitch value calculated.
     */
    public double getPitchValue() {
        return pitchValue;
    }

    /**
     * Set the pitch Value
     * @param pitchValue
     */
    public void setPitchValue(double pitchValue) {
        this.pitchValue = pitchValue;
    }

    /**
     * Get the pitch threshold value for the specified index
     * @param index - index for the required pitch threshold
     * @return - return the pitch value
     */
    public double getPitchThreshold(int index) {
        return pitchThreshold[index];
    }

    /**
     * Set the pitch threshold at the specified index
     * @param pitchThreshold - pitch threshold value to be set
     * @param index - index for which pitch threshold has to be set.
     */
    public void setPitchThreshold(double pitchThreshold, int index) {
        this.pitchThreshold[index] = pitchThreshold;
    }

    /**
     * Listen to the audio stream and calculate the pitch and decibel for the data collected in
     * the buffer.
     *
     */
    public void CalculatePitchAndDecibel()
    {
        dispatcher.addAudioProcessor(
                new PitchProcessor(
                        PitchProcessor.PitchEstimationAlgorithm.FFT_YIN,
                        22050,
                        size*2,
                        new PitchDetectionHandler() {

            @Override
            public void handlePitch(PitchDetectionResult pitchDetectionResult,
                                    AudioEvent audioEvent) {

                setPitchValue(pitchDetectionResult.getPitch()); // Record the pitch value
                setDbLevel(soundPressureLevel(audioEvent.getFloatBuffer()));    // Record the decibel value
                // Train the microphone when it starts listening to music and
                // calculate the threshold ranges for decibel and pitch values.
                calculateThreshold(getDbLevel(), getPitchValue());
                // display the decibel values as obtained in graph.
                display(getDbLevel(), dispatcher.secondsProcessed());
            }
        }));

 //       Log.d("THRESHOLD", String.valueOf(getThreshold(AVG)));
    }

    /**
     * Calculates the decibel level for the amplitude data collected the buffer.
     * @param buffer - data collected by audio Event
     * @return - returns absolute decibel level for the collected data in the buffer.
     */
    private double soundPressureLevel(final float[] buffer) {
        double power = 0.0D;
        for (float element : buffer) {
            power += element * element;
        }
        double value = Math.pow(power, 0.5)/ buffer.length;;
        // Taking the absolute value of decibel value. The actual value is negative.
        return Math.abs(20.0 * Math.log10(value));

    }

    /**
     * Calculate the ranges for decibel levels and pitch values as found during the training session
     * Based on these range decide the threshold level for calibrating the microphone
     * @param dbValue - decibel level as calculated.
     * @param pitchValue - pitch Value as calculated.
     */
    private void calculateThreshold(double dbValue, double pitchValue) {
        double secondsProcessed = Math.abs(dispatcher.secondsProcessed());

        /* Use the first 2sec of audio stream as training data for the microphone.
         * Using this data set the threshold values for colors to be displayed.
         */
        if((secondsProcessed <= 2)) {
            amplitudeBuffer.add(dbValue);
            pitchBuffer.add(pitchValue);
        }
        else if((secondsProcessed<2.20) && ((secondsProcessed%2 >= 0) && (secondsProcessed%2 < 0.05))) {
            calculateRanges();  // Calculate the range for which the decibel level spans.
            calculatePitchRanges(); // Calculate the range of values for which Pitch scans.
        }
    }

    /**
     * Inorder to standardize the decibel values as perceived by different microphones,
     * Calculate the minimum, maximum, average value of the amplitude for a period of 2sec.
     * i.e. Train the application for the device's microphone
     */
    private void calculateRanges() {
        double min = Double.MAX_VALUE;
        double max = Double.MIN_VALUE;
        double avg = 0.0;

        for(int i=0; i<amplitudeBuffer.size(); i++) {
            if(min > amplitudeBuffer.get(i))
                min = amplitudeBuffer.get(i);
            if(max < amplitudeBuffer.get(i))
                max = amplitudeBuffer.get(i);
            avg += amplitudeBuffer.get(i);
        }
        avg = avg/amplitudeBuffer.size();

        /*
         * Since the actual dB value obtained is negative but for calculation purpose, its
         * absolute value is considered, while making a note of the minimum, avg and maximum values
         * reverse the order.
         * i.e. 40 > 60
         */
        setThreshold(max, MIN);
        setThreshold(min, MAX);
        setThreshold(avg, AVG);
        setThreshold((avg+min)/2, AVG_MAX);
        setThreshold((avg+max)/2, AVG_MIN);
    }
    /**
     * To standardize the pitch values as perceived by different microphones,
     * Calculate the minimum, maximum, average value of the amplitude for a period of 2sec.
     * i.e. Calibrate the application for the device's microphone
     */
    private void calculatePitchRanges()
    {
        double min = Double.MAX_VALUE;
        double max = Double.MIN_VALUE;
        double avg = 0.0;

        for(int i=0; i<pitchBuffer.size(); i++) {
            if(min > pitchBuffer.get(i))
                min = pitchBuffer.get(i);
            if(max < pitchBuffer.get(i))
                max = pitchBuffer.get(i);
            avg += pitchBuffer.get(i);
        }
        avg = avg/pitchBuffer.size();

        setPitchThreshold(max, MAX);
        setPitchThreshold(min, MIN);
        setPitchThreshold(avg, AVG);
        setPitchThreshold((avg+min)/2, AVG_MIN);
        setPitchThreshold((avg+max)/2, AVG_MAX);
    }

    /**
     * Display data on UI in a UI thread.
     * Display the graph on Music Fragment.
     * Update the Graph with decibel data as recorded above in threadMusic.
     */
    private void display(final double dBValue, final double seconds)
    {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                MusicFragment fragment= new MusicFragment();
                fragment.updateGraph((dBValue),(float)seconds);
                if (mArrayOfRandomNumbers != null)
                    fragment.changeColor(mArrayOfRandomNumbers[0],mArrayOfRandomNumbers[1],mArrayOfRandomNumbers[2]);
                //Comment above two lines and uncomment below lines if testing MusicFragment
                // without bluetooth connection
                //DO NOT DELETE ANY OF THESE LINES

//                pitchText.setText("" + pitchValue);
//                amplitudeText.setText("" + amplitudeValue);
//                durationText.setText(""+duration);
//                thresholdText.setText(""+getThreshold(AVG));
            }
        });
    }

    /**
     * Private class to transmit data over bluetooth
     */
    private class TransmitData implements Runnable{

        private boolean music;

        /**
         * Parametrized constructor for the transmission class
         * @param playMusic - boolean value to indicate whether application is listening to music
         *                  or not.
         * true - music is being played and the application is listening to it
         * false - application not listening to music
         */
        public TransmitData(boolean playMusic)
        {
            this.music = playMusic;
        }

        /**
         * Check if music is being played or not
         * true - music is being played and the application is listening to it
         * false - application not listening to music
         * @return - boolean value whether application is listening to music or not
         */
        public boolean isMusic() {
            return music;
        }

        /**
         * Set whether the application is listening to music or not.
         * true - application is listening to music
         * false - application not listening to music
         * @param music
         */
        public void setMusic(boolean music) {
            this.music = music;
        }

        /**
         * While bluetooth socket connection exists and application is listening to music,
         * keep generating color data for the decibel level value calculated and send it via bluetooth.
         * For colors and effect to be perceived by human eye sleep the Thread.
         * Decide the sleep time based on pitch.
         */
        public void run() {
            while (btSocket != null && musicFragment.getStopEnabled()) {
                try {
                    // generate color to be transmitted to the LED board
                    String data = generateColorData(isMusic()).toString();
                    btSocket.getOutputStream().write(data.getBytes()); // send data over bluetooth
                    // generate sleep time based on pitch value.
                    Thread.sleep(generatePitchData(pitchValue));
                } catch (IOException e) {
                    msg("Error");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    /**
     * Generate Sleep time based on pitch Value.
     * Eg: pitch value:            |---------|---------|-------|---------|
     *                            70        62.5      55      47.5      40
     * pitch Number line is:       |---------|---------|-------|---------|
     *                            MAX     AVG_MAX     AVG   AVG_MIN     MIN
     * sleep time Number Line is:  |---------|---------|-------|---------|
     *                            MIN     AVG_MIN     AVG   AVG_MAX     MAX
     *                             |--range1-|------range2-----|--range3-|
     * sleep range:                |---------|---------|-------|---------|
     *                             50       87        125     162       200
     * @param pitchValue - pitch value as found for the current audio data
     * @return - sleep time
     */
    private int generatePitchData(double pitchValue) {

        if (pitchValue < getPitchThreshold(MIN))
            return sleepRange[MAX];
        else if (pitchValue > getPitchThreshold(MIN) && pitchValue < getPitchThreshold(AVG_MIN))
            return new Random().nextInt(sleepRange[MAX]-sleepRange[AVG_MAX]+1)+sleepRange[AVG_MAX];
        else if (pitchValue > getPitchThreshold(AVG_MIN) && pitchValue < getPitchThreshold(AVG_MAX))
            return new Random().nextInt(sleepRange[AVG_MAX]-sleepRange[AVG_MIN]+1)+sleepRange[AVG_MIN];
        else if (pitchValue > getPitchThreshold(AVG_MAX) && pitchValue < getPitchThreshold(MAX))
            return new Random().nextInt(sleepRange[AVG_MIN]-sleepRange[MIN]+1)+sleepRange[MIN];
        return sleepRange[MIN];
    }

    /**
     * Generate color values to be sent based on the decibel values.
     * Generate data only if app is listening to music.
     * @param playMusic - true: app is listening to music
     *                    false: app is not listening to music
     * @return - an array of data to be sent to the LEDs for display.
     */
    private RandomNumberArray generateColorData(boolean playMusic)
    {
        /* 3 data sets have to generated
         * All 60 LEDs will have same RGB value
         *
         */
        RandomNumberArray arr = new RandomNumberArray(3);

        /*
         * Generate data only if music is being played. => playMusic = true
         * Values above 70 are silent values. For silence range, transmit  data
         *  Eg: decibel:                 |---------|---------|-------|---------|
         *                              70        62.5      55      47.5      40
         * decibel Number line is:       |---------|---------|-------|---------|
         *                              MIN     AVG_MIN     AVG   AVG_MAX     MAX
         * the intensity Number Line is: |---------|---------|-------|---------|
         *                              MIN     AVG_MIN     AVG   AVG_MAX   MAX
         *                               |--range1-|------range2-----|--range3-|
         *Eg intensity:                  |---------|---------|-------|---------|
         *                               0        64        128     192       255
         */
        if (playMusic) {
            if (getDbLevel() > getThreshold(MIN)){
                arr.generateClearArray();
                //Log.d("min","im here");
            }
            else if(getDbLevel() < getThreshold(MIN) && getDbLevel() > getThreshold(AVG_MIN)){
                arr.generateArray(new Random().nextInt(6), intensityRange[AVG_MIN], intensityRange[MIN]);
                //Log.d("avg_min - min","im here");
            }
            else if(getDbLevel() < getThreshold(AVG_MIN) && getDbLevel() > getThreshold(AVG_MAX)){
                arr.generateArray(new Random().nextInt(6), intensityRange[AVG_MAX], intensityRange[AVG_MIN]);
                //Log.d("avg_max - avg_min","im here");
            }
            else if(getDbLevel() < getThreshold(AVG_MAX) && getDbLevel() > getThreshold(MAX)){
                arr.generateArray(new Random().nextInt(6), intensityRange[MAX], intensityRange[AVG_MAX]);
                //Log.d("avg_max - max","im here");
            }
            else if(getDbLevel() < getThreshold(MAX)){
                arr.generateArray(new Random().nextInt(6), intensityRange[MAX], intensityRange[MAX]);
                //Log.d("max","im here");
            }
        }
        else    // Music is stopped, hence clear data.
            arr.generateClearArray();
        return arr;
    }

    // display toast
    private void msg(String s)
    {
        Toast.makeText(getApplicationContext(),s,Toast.LENGTH_SHORT).show();
    }


    /**
     * Class that generates an array of random integer numbers in the given range.
     */
    private class RandomNumberArray{
        private int mNumberOfRandomNumbers;     // size of array

        Random random;

        /**
         * Parametrised constructor which creates an array of size as specified by
         * 'numberOfRandomNumbers'
         * @param numberOfRandomNumbers
         */
        public RandomNumberArray(int numberOfRandomNumbers){
            mNumberOfRandomNumbers = numberOfRandomNumbers;
            mArrayOfRandomNumbers = new int[numberOfRandomNumbers];
            random = new Random();
        }

        /**
         * Fill the array with color having intensity in the range of
         * supplied min to max value.
         * @param color - Color for which the dataset is to be generated
         * @param max - Maximum color intensity
         * @param min - Minimum color intensity
         */
        public void generateArray(int color, int max, int min){
            if (color >= 3){
                mArrayOfRandomNumbers[new Random().nextInt(3)] = random.nextInt(max-min+1)+min;
                mArrayOfRandomNumbers[new Random().nextInt(3)] = random.nextInt(max-min+1)+min;
            }
            else {
                mArrayOfRandomNumbers[color] = random.nextInt(max - min + 1) + min;
            }
        }

        /**
         * Fill the array with 0 data, to clear the LEDs.
         */
        public void generateClearArray(){
            for(int i=0;i<mNumberOfRandomNumbers;i++){
                mArrayOfRandomNumbers[i] = 0;
            }
        }

        /**
         * Format the array data in a format that could be sent to the LED board.
         * @return - a string of array elements appended together.
         */
        @Override
        public String toString(){
            StringBuilder sb = new StringBuilder();
            for(int i=0;i<mNumberOfRandomNumbers;i++){
                sb.append(String.format("%03d",mArrayOfRandomNumbers[i]));
                if(i==mNumberOfRandomNumbers-1) {
                    sb.append("\n");
                }
            }
            return sb.toString();
        }
    }
//
//    @Override
//    public void onDestroy(){
//        if (btSocket.isConnected()){
//            try {
//                btSocket.close();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//        }
//    }

    /**
     * Class to Establish Bluetooth Connection.
     * This task will happen asynchronously.
     */
    private class ConnectBT extends AsyncTask<Void, Void, Void>  // UI thread
    {
        private boolean ConnectSuccess = true; //if it's here, it's almost connected

        @Override
        protected void onPreExecute()
        {
            progress = ProgressDialog.show(MusicActivity.this, "Connecting...", "Please wait!!!");  //show a progress dialog
        }

        @Override
        protected Void doInBackground(Void... devices) //while the progress dialog is shown, the connection is done in background
        {
            try
            {
                if (btSocket == null || !isBtConnected)
                {
                    myBluetooth = BluetoothAdapter.getDefaultAdapter();//get the mobile bluetooth device
                    BluetoothDevice dispositivo = myBluetooth.getRemoteDevice(address);//connects to the device's address and checks if it's available
                    btSocket = dispositivo.createInsecureRfcommSocketToServiceRecord(myUUID);//create a RFCOMM (SPP) connection
                    BluetoothAdapter.getDefaultAdapter().cancelDiscovery();
                    btSocket.connect();//start connection
                }
            }
            catch (IOException e)
            {
                ConnectSuccess = false;//if the try failed, you can check the exception here
            }
            return null;
        }
        @Override
        protected void onPostExecute(Void result) //after the doInBackground, it checks if everything went fine
        {
            super.onPostExecute(result);

            if (!ConnectSuccess)
            {
                msg("Connection Failed. Try again.");
                Intent connect_bluetooth = new Intent(MusicActivity.this,BluetoothActivity.class);
                startActivityForResult(connect_bluetooth,REQUEST_CODE_CONNECT);
            }
            else
            {
                msg("Connected!");
                isBtConnected = true;
                SocketData socketData = SocketData.getInstance();
                socketData.saveBluetoothSocketData(btSocket);


                if(findViewById(R.id.music_graph_layout)==null){
                    musicFragment = new MusicFragment();
                    getSupportFragmentManager().beginTransaction()
                            .replace(R.id.music_frame_layout,musicFragment)
                            .addToBackStack(null)
                            .commit();
                }
            }
            progress.dismiss();
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent intent){
        switch (requestCode){
            case REQUEST_CODE_CONNECT:
                if (resultCode == RESULT_OK){
                    address = intent.getStringExtra("Address_device");
                    new MusicActivity.ConnectBT().execute();
                }
                else {
                    msg("Error Finding Device");
                    finish();

                }
                break;
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode,
                                           String permissions[], int[] grantResults) {
        switch (requestCode) {
            case RECORD_REQUEST_CODE: {

                if (grantResults.length == 0
                        || grantResults[0] !=
                        PackageManager.PERMISSION_GRANTED) {
                    msg("Microphone Required to run the app, Good Bye......");
                    finish();
                }
                return;
            }
        }
    }

    @Override
    public void onBackPressed(){

        if (backPressedCount < 1 ){
            msg("Press back again to exit");
            backPressedCount = backPressedCount + 1;
        }
        else{
            msg("Bye Bye.....");
            backPressedCount = 0;

            if (musicFragment.getStopEnabled()){
                musicFragment.setStartEnabled();
                onStopButtonPressed();
            }

            if (btSocket.isConnected()){
                try {
                    btSocket.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            finish();
        }
    }

    public void isMicrophoneOn(){
        int permission = ContextCompat.checkSelfPermission(this,
                Manifest.permission.RECORD_AUDIO);

        if (permission != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.RECORD_AUDIO},RECORD_REQUEST_CODE);
        }

    }

    @Override
    public void onResume(){
        super.onResume();
        backPressedCount = 0;

        if (isBtConnected){
            if(findViewById(R.id.music_graph_layout)==null){
                musicFragment = new MusicFragment();
                getSupportFragmentManager().beginTransaction()
                        .replace(R.id.music_frame_layout,musicFragment)
                        .addToBackStack(null)
                        .commit();
            }
        }
    }

    @Override
    public void onPause() {

        super.onPause();
        if (findViewById(R.id.music_graph_layout) != null) {
            if (musicFragment.getStopEnabled()) {
                musicFragment.setStartEnabled();
                onStopButtonPressed();
            }

        }
    }
}