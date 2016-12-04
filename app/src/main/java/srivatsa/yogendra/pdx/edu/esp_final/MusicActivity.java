package srivatsa.yogendra.pdx.edu.esp_final;

import android.app.ProgressDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.widget.Button;
import android.widget.TextView;

import java.io.IOException;
import java.util.ArrayList;


import android.widget.Toast;

import java.util.Random;
import java.util.UUID;

import be.tarsos.dsp.AudioDispatcher;
import be.tarsos.dsp.AudioEvent;
import be.tarsos.dsp.pitch.PitchDetectionHandler;
import be.tarsos.dsp.pitch.PitchDetectionResult;
import be.tarsos.dsp.pitch.PitchProcessor;

public class MusicActivity extends AppCompatActivity implements ConnectFragment.OnConnectButtonPressedListener {

    //private float pitchValue;
    //private double amplitudeValue;
    private int size = 512;
    private int sampleRate = 24000;
    private AudioDispatcher dispatcher;
    private Thread thread, threadData;
    private double duration;
    private ArrayList<Double> amplitudeBuffer;
    private double dbLevel;

    //User interface widgets
    private Button startButton;
    private Button stopButton;
    private TextView pitchText;
    private TextView amplitudeText;
    private TextView durationText;
    private TextView thresholdText;


    private double avgAmplitude = 0.0;
    private int count = 0;
    private double sum = 0.0;


    //Threshold Constants
    private static final int MIN = 0;
    private static final int AVG_MIN = 1;
    private static final int AVG_THRESHOLD = 2;
    private static final int AVG_MAX = 3;
    private static final int MAX = 4;

    private static final int[] intensityRange = {0,64,128,192,255};
    private double[] threshold = new double[5];

    //Bluetooth related variables
    private BluetoothSocket bluetoothSocket;
    String address = null;
    private ProgressDialog progress;
    BluetoothAdapter myBluetooth = null;
    BluetoothSocket btSocket = null;
    private boolean isBtConnected = false;
    static final UUID myUUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");
    private final int REQUEST_CODE_CONNECT =1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_music);
        if(findViewById(R.id.connect_frame_layout)==null){
            if(savedInstanceState !=null){
                return;
            }
            ConnectFragment connectFragment = new ConnectFragment();
            getSupportFragmentManager().beginTransaction()
                    .add(R.id.music_frame_layout,connectFragment)
                    .commit();
        }

        initialize(); // Initialize all the widgets to be used in the activity

        /*
         * Set on click listener for start listening to music
         */
//        startButton.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                startButton.setEnabled(false);
//                stopButton.setEnabled(true);
//                amplitudeBuffer = new ArrayList<Double>();
//                //Initialize audio dispatcher to listen from microphone
//                dispatcher = AudioDispatcherFactory.fromDefaultMicrophone(sampleRate,1024,size);
//
//                // Calculate the pitch and loudness in the detected audio stream
//                //CalculatePitchLoudness(dispatcher);
//                CalculatePitchLoudness();
//
//                // do this calculation in a thread
//
//                thread = new Thread(dispatcher,"Audio Dispatcher");
//                //threadData = new Thread(new transmitData());
//                thread.start();
//
//            }
//        });
//
//        /*
//         * On click listener for stop listening to music
//         */
//        stopButton.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//
//               // threadData.start();
//                thread.interrupt();
//                thread = null;
//             //   threadData.interrupt();
//             //   threadData = null;
//                startButton.setEnabled(true);
//                stopButton.setEnabled(false);
//                try{
//                    if(dispatcher!=null)
//                    {
//                        dispatcher.stop();
//                    }
//                }
//                catch (Exception e) {
//                    e.printStackTrace();
//                }
//            }
//        });

    }

    // Getters and Setters

    public double getThreshold(int index) {
        return this.threshold[index];
    }

    public void setThreshold(double thresholdValue, int index) {
        this.threshold[index] = thresholdValue;
    }

    public double getDbLevel() {
        return dbLevel;
    }

    public void setDbLevel(double dbLevel) {
        this.dbLevel = dbLevel;
    }

    /**
     *
     */
    public void initialize()
    {
//        bluetoothSocket = SocketData.getBluetoothSocketData();
//
//        startButton = (Button) findViewById(R.id.startButton);
//        stopButton = (Button) findViewById(R.id.stopButton);
//        pitchText = (TextView) findViewById(R.id.pitchTextView);
//        amplitudeText = (TextView) findViewById(R.id.amplitudeTextView);
//        durationText = (TextView) findViewById(R.id.durationTextView);
//        thresholdText = (TextView) findViewById(R.id.thresholdTextView);
    }

    /**
     *
     *
     */
    public void CalculatePitchLoudness()
    {

        dispatcher.addAudioProcessor(new PitchProcessor(PitchProcessor.PitchEstimationAlgorithm.FFT_YIN, 22050, size*2, new PitchDetectionHandler() {

            @Override
            public void handlePitch(PitchDetectionResult pitchDetectionResult,
                                    AudioEvent audioEvent) {
                double pitchValue = pitchDetectionResult.getPitch();
                Log.d("PITCH", String.valueOf(pitchValue));
                double amplitudeValue = CalculateLoudness(audioEvent.getFloatBuffer(), audioEvent.getBufferSize());
                setDbLevel(soundPressureLevel(audioEvent.getFloatBuffer()));
                calculateThreshold(getDbLevel());
                Log.d("AMPLITUDE", String.valueOf(amplitudeValue));
                Log.d("DECIBEL", String.valueOf(getDbLevel()));
                display(pitchValue, amplitudeValue);
                threadData = new Thread(new transmitData());
                threadData.start();

            }
        }));

        Log.d("THRESHOLD", String.valueOf(getThreshold(AVG_THRESHOLD)));
    }

    /**
     *
     * @param buffer
     * @param bufferSize
     * @return
     */
    private double CalculateLoudness(float[] buffer, int bufferSize)
    {
        double sumLevel = 0.0;
        for (int i = 0; i < bufferSize; i++) {
            sumLevel += buffer[i]*1000000;
        }
        return Math.abs(sumLevel/bufferSize);
    }


    private double soundPressureLevel(final float[] buffer) {
        double power = 0.0D;
        for (float element : buffer) {
            power += element * element;
        }
        double value = Math.pow(power, 0.5)/ buffer.length;;
        // Taking the absolute value of decibel value. The actual value is negative.
        return Math.abs(20.0 * Math.log10(value));

    }

    private void calculateThreshold(double dbValue) {
        double secondsProcessed = Math.abs(dispatcher.secondsProcessed());

        /* Use the first 2sec of audio stream as training data for the microphone.
         * Using this data set the threshold values for colors to be displayed.
         */
        if((secondsProcessed <= 2))
            amplitudeBuffer.add(dbValue);
        else if((secondsProcessed<2.20) && ((secondsProcessed%2 >= 0) && (secondsProcessed%2 < 0.05))) {
            calculateRanges();
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
            Log.d("AMPLITUDE BUFFER", String.valueOf(amplitudeBuffer.get(i)));
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
        setThreshold(avg, AVG_THRESHOLD);
        setThreshold((avg+min)/2, AVG_MAX);
        setThreshold((avg+max)/2, AVG_MIN);
    }

    /**
     * Display data on UI in a UI thread.
     */
    private void display(final double pitchValue, final double amplitudeValue)
    {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                pitchText.setText("" + pitchValue);
                amplitudeText.setText("" + amplitudeValue);
                durationText.setText(""+duration);
                thresholdText.setText(""+getThreshold(AVG_THRESHOLD));
            }
        });

    }

    @Override
    public void onConnectButtonPressed() {
        Intent connect_bluetooth = new Intent(MusicActivity.this,BluetoothActivity.class);
        startActivityForResult(connect_bluetooth,REQUEST_CODE_CONNECT);
    }

    private class transmitData implements Runnable{
        public void run() {
            try {
                threadData.sleep(10);
//                Thread.sleep(10);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            String data;
            /* 180 data sets have to generated
             * 60 LEDs and 3 values for each LED : RGB
             * Hence, 180 = 60*3
             */
            RandomNumberArray arr = new RandomNumberArray(180);

            /*
             * Values above 70 are silent values. For silence range, transmit  data
             * decibel Number line is:       |---------|---------|-------|---------|
             *                              MAX     AVG_MAX     AVG   AVG_MIN   MIN
             * the intensity Number Line is: |---------|---------|-------|---------|
             *                              MIN     AVG_MIN     AVG   AVG_MAX   MAX
             *                               |--range1-|------range2-----|--range3-|
             *
             */
//            if (getDbLevel() > getThreshold(AVG_MIN) && getDbLevel() < 70) {
//                arr.generateArray(new Random().nextInt(3), intensityRange[MAX],intensityRange[AVG_MAX]);
//            }
//            else if (getDbLevel() > getThreshold(AVG_MAX) && getDbLevel() < getThreshold(AVG_MIN)) {
//                arr.generateArray(new Random().nextInt(3), intensityRange[AVG_MAX],intensityRange[AVG_MIN]);
//            }
//            else if (getDbLevel() > getThreshold(MAX) && getDbLevel() < getThreshold(AVG_MAX)) {
//                arr.generateArray(new Random().nextInt(3), intensityRange[AVG_MIN],intensityRange[MIN]);
//            }
//            else if(getDbLevel() >= 70) {
//                arr.generateArray(0, -1, 0);
//            }

            if(getDbLevel() > getThreshold(AVG_MAX) && getDbLevel() < 70){
                arr.generateArray(new Random().nextInt(3),intensityRange[MAX],intensityRange[AVG_MAX]);
            }
            else{
                arr.generateClearArray();
            }



            if (bluetoothSocket != null) {
                try {
                    data = arr.toString();
                    bluetoothSocket.getOutputStream().write(data.getBytes());
                } catch (IOException e) {
                    msg("Error");
                }
            }
        }
    }

    // fast way to call Toast
    private void msg(String s)
    {
        Toast.makeText(getApplicationContext(),s,Toast.LENGTH_SHORT).show();
    }


    private class RandomNumberArray{
        private int mNumberOfRandomNumbers;
        private int[] mArrayOfRandomNumbers;
        Random random;
        public RandomNumberArray(int numberOfRandomNumbers){
            mNumberOfRandomNumbers = numberOfRandomNumbers;
            mArrayOfRandomNumbers = new int[numberOfRandomNumbers];
            random = new Random();
        }

        /**
         * Generate an array of color having different intensity in the range of
         * supplied min to max value.
         * @param color - Color for which the dataset is to be generated
         * @param max - Maximum color intensity
         * @param min - Minimum color intensity
         */
        public void generateArray(int color, int max, int min){
            for(int i=color;i<mNumberOfRandomNumbers;i+=3){
                mArrayOfRandomNumbers[i] = random.nextInt(max-min+1)+min;
            }
        }
        public void generateClearArray(){
            for(int i=0;i<mNumberOfRandomNumbers;i++){
                mArrayOfRandomNumbers[i] = 0;
            }
        }
        @Override
        public String toString(){
            StringBuilder sb = new StringBuilder();
            for(int i=0;i<mNumberOfRandomNumbers;i++){
                sb.append(mArrayOfRandomNumbers[i]);
                if(i!=mNumberOfRandomNumbers-1) {
                    sb.append(",");
                }
                else{
                    sb.append("\n");
                }
            }
            return sb.toString();
        }
    }

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
                msg("Connected. Yay!!");
                isBtConnected = true;
                SocketData socketData = SocketData.getInstance();
                socketData.saveBluetoothSocketData(btSocket);
                Intent mainactivityIntent = new Intent(MusicActivity.this,MusicActivity.class);
                startActivity(mainactivityIntent);
            }
            progress.dismiss();
        }
    }

}


/**
 * Extra code ignore
 */
//                    count += 1;
//                    sum += amplitudeValue;
//                }while (count<10);

//                duration = dispatcher.secondsProcessed();
//                Log.d("DURATION", String.valueOf(duration));
//                Log.d("COUNT", String.valueOf(count));
//                avgAmplitude = sum/count;
//                //Log.d("AVGAMPLITUDE", String.valueOf(amplitudeValue));
//                sum = 0.0;
//                count = 0;

//                display();
//                if(duration % (1/60) == 0) {
//                if(count == 60) {
//                    amplitudeValue = avgAmplitude/count;
//                    Log.d("AVGAMPLITUDE", String.valueOf(amplitudeValue));
//                    avgAmplitude = 0.0;
//                    count = 0;
//                    display();
//                }
//                else {
//                    avgAmplitude += amplitudeValue;
//                    count++;
//                }