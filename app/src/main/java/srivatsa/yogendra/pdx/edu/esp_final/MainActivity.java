package srivatsa.yogendra.pdx.edu.esp_final;

import android.bluetooth.BluetoothServerSocket;
import android.bluetooth.BluetoothSocket;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.io.IOException;
import java.util.ArrayList;


import android.media.AudioRecord;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Random;

import be.tarsos.dsp.AudioDispatcher;
import be.tarsos.dsp.AudioEvent;
import be.tarsos.dsp.io.android.AudioDispatcherFactory;
import be.tarsos.dsp.pitch.PitchDetectionHandler;
import be.tarsos.dsp.pitch.PitchDetectionResult;
import be.tarsos.dsp.pitch.PitchProcessor;

public class MainActivity extends AppCompatActivity {

    //private float pitchValue;
    //private double amplitudeValue;
    private int bufferSize = 1024;
    private int overflowBufferSize = bufferSize/2;
    private int sampleRate = 24000;
    private AudioDispatcher dispatcher;
    private Thread threadMusic, threadData;
    private double duration;
    private ArrayList<Double> amplitudeBuffer;
    private double dbLevel;
    private TransmitData transmitData;

    private Button startButton;
    private Button stopButton;
//    private TextView pitchText;
//    private TextView amplitudeText;
//    private TextView durationText;
    private TextView thresholdText;


    private double avgAmplitude = 0.0;
    private int count = 0;
    private double sum = 0.0;


    //Threshold Constants
    private static final int MIN = 0;
    private static final int AVG_MIN = 1;
    private static final int AVG = 2;
    private static final int AVG_MAX = 3;
    private static final int MAX = 4;

    //RGB Constants
    private static final int RED = 0;
    private static final int GREEN = 1;
    private static final int BLUE = 2;



    private static final int[] intensityRange = {0,64,128,192,255};
    private double[] threshold = new double[5];

    private BluetoothSocket bluetoothSocket;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        initialize(); // Initialize all the widgets to be used in the activity

        /*
         * Set on click listener for start listening to music
         * Keep listening to the music and process the audio in thread 'threadMusic'
         * Transmit data over bluetooth in a separate thread 'threadData'
         */
        startButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startButton.setEnabled(false);
                stopButton.setEnabled(true);
                amplitudeBuffer = new ArrayList<Double>();

                //Initialize audio dispatcher to listen from microphone
                dispatcher = AudioDispatcherFactory.fromDefaultMicrophone(sampleRate,bufferSize,overflowBufferSize);
                transmitData = new TransmitData(true);   // initialize data transmission object

                // Calculate the decibel level in the detected audio stream
                CalculateDecibel();

                // Keep listening to music and calculate the decibel level for data captured in buffer
                threadMusic = new Thread(dispatcher,"Audio Dispatcher");
                // Keep polling 'dbLevel' to transmit appropriate color as per the decibel value
                threadData = new Thread(transmitData, "Color Transmition");
                threadMusic.start();
                threadData.start();
                Log.d("threads","Threads started");
            }
        });

        /*
         * On click listener for stop listening to music
         */
        stopButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                startButton.setEnabled(true);
                stopButton.setEnabled(false);

                transmitData.setMusic(false);   // send a clear data to stop the effects of musical lights
                try {
                    threadData.join();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                threadMusic.interrupt();
                threadMusic = null;
//                threadData.interrupt();
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
        });

    }


    /**
     * Get the threshold value at the specified index
     * @param index - index for the required threshold value
     * @return - return the threshold value
     */
    public double getThreshold(int index) {
        return this.threshold[index];
    }

    /**
     * Set the threshold value for the given index
     * @param thresholdValue - threshold value to be set
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
     * Initialize the widgets used in the activity/fragment
     */
    public void initialize()
    {
        bluetoothSocket = SocketData.getBluetoothSocketData();

        startButton = (Button) findViewById(R.id.startButton);
        stopButton = (Button) findViewById(R.id.stopButton);
//        pitchText = (TextView) findViewById(R.id.pitchTextView);
//        amplitudeText = (TextView) findViewById(R.id.amplitudeTextView);
//        durationText = (TextView) findViewById(R.id.durationTextView);
        thresholdText = (TextView) findViewById(R.id.thresholdTextView);
    }

    /**
     * Read the data from the audio stream and calculate the decibel level.
     *
     */
    public void CalculateDecibel()
    {

        dispatcher.addAudioProcessor(new PitchProcessor(PitchProcessor.PitchEstimationAlgorithm.FFT_YIN, 22050, bufferSize, new PitchDetectionHandler() {

            @Override
            public void handlePitch(PitchDetectionResult pitchDetectionResult,
                                    AudioEvent audioEvent) {
//                double pitchValue = pitchDetectionResult.getPitch();
//                Log.d("PITCH", String.valueOf(pitchValue));
//                double amplitudeValue = CalculateLoudness(audioEvent.getFloatBuffer(), audioEvent.getBufferSize());

                // For the amplitude data collected by the audio event in the buffer, calculate
                // the corresponding decibel level for each amplitude.
                setDbLevel(soundPressureLevel(audioEvent.getFloatBuffer()));

                // Train the microphone to figure out the decibel ranges only for the initial 2 sec
                calculateThreshold(getDbLevel());
//                Log.d("AMPLITUDE", String.valueOf(amplitudeValue));
             //   Log.d("DECIBEL", String.valueOf(getDbLevel()));
//                display(pitchValue, amplitudeValue);

                // display data on UI
                display();
            }
        }));

        Log.d("THRESHOLD", String.valueOf(getThreshold(AVG)));
    }

//    /**
//     *
//     * @param buffer
//     * @param bufferSize
//     * @return
//     */
//    private double CalculateLoudness(float[] buffer, int bufferSize)
//    {
//        double sumLevel = 0.0;
//        for (int i = 0; i < bufferSize; i++) {
//            sumLevel += buffer[i]*1000000;
//        }
//        return Math.abs(sumLevel/bufferSize);
//    }

    /**
     *  Calculates the decibel level for the amplitude data collected the buffer.
     * @param buffer - data collected by audio Event
     * @return - returns absolute decibel level for the collected data in the buffer.
     */
    private double soundPressureLevel(final float[] buffer) {
        double power = 0.0D;
        for (float element : buffer) {
            power += element * element;
        }
        double value = Math.pow(power, 0.5)/ buffer.length;
        // Taking the absolute value of decibel value. The actual value is negative.
        return Math.abs(20.0 * Math.log10(value));

    }

    /**
     * Calculate the ranges of decibel levels as found during the training session
     * Based on these range decide the threshold level for calibrating the microphone
     * @param dbValue - decibel level as calculated.
     */
    private void calculateThreshold(double dbValue) {
        double secondsProcessed = Math.abs(dispatcher.secondsProcessed());

        /* Use the first 2sec of audio stream as training data for the microphone.
         * Using this data set the threshold values for colors to be displayed.
         */
        if((secondsProcessed <= 2))
            amplitudeBuffer.add(dbValue);
        else if((secondsProcessed<2.20) && ((secondsProcessed%2 >= 0) && (secondsProcessed%2 < 0.05))) {
            calculateRanges();  // Calculate the range for which the decibel level spans.
        }
    }

    /**
     * Inorder to standardize the decibel values as perceived by different microphones,
     * Calculate the minimum, maximum, average value of the amplitude for a period of 2sec.
     * i.e. Calibrate the device's microphone for the music being played.
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
         //   Log.d("AMPLITUDE BUFFER", String.valueOf(amplitudeBuffer.get(i)));
        }
        avg = avg/amplitudeBuffer.size();

        /*
         * Since the actual dB value obtained is negative but for calculation purpose, its
         * absolute value is considered, while making a note of the minimum, avg and maximum values
         * reverse the order.
         * i.e. 40 > 60
         */
        setThreshold(max, MIN);
        Log.d("min", String.valueOf(max));
        setThreshold(min, MAX);
        Log.d("max", String.valueOf(min));
        setThreshold(avg, AVG);
        Log.d("Avg", String.valueOf(avg));
        setThreshold((avg+min)/2, AVG_MAX);
        Log.d("Avg_max", String.valueOf((avg+min)/2));
        setThreshold((avg+max)/2, AVG_MIN);
        Log.d("Avg_min", String.valueOf((avg+max)/2));
    }

    /**
     * Display data on UI in a UI thread.
     */
//    private void display(final double pitchValue, final double amplitudeValue)
    private void display()
    {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
//                pitchText.setText("" + pitchValue);
//                amplitudeText.setText("" + amplitudeValue);
//                durationText.setText(""+duration);
                thresholdText.setText(String.valueOf(getThreshold(AVG)));
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
         * @param playMusic
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
         * While bluetooth socket connection exists, keep generating color data for the
         * decibel level value calculated and send it via bluetooth.
         */
        public void run() {
            while (bluetoothSocket != null && stopButton.isEnabled()) {
//                try {
//                    // sleep for 100 ms before the next data is sent.
//                    // This is to assist in showing flickering of lights
//                    Thread.sleep(100);
//                } catch (InterruptedException e) {
//                    e.printStackTrace();
//                }
//                if (bluetoothSocket != null) {

                    try {
                        String data = generateColorData(isMusic()).toString();
                       // Log.d("BT", "Sending data" + data);
                        bluetoothSocket.getOutputStream().write(data.getBytes());
                        Thread.sleep(50);
//                        data = generateColorData(false).toString();
//                        bluetoothSocket.getOutputStream().write(data.getBytes());
                    } catch (IOException e) {
                        msg("Error");
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
//                }
            }
//            msg("Either Stopped listening to Music or Bluetooth disconnected");
        }
    }

    /**
     *
     * @param playMusic
     * @return
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
                Log.d("min","im here");
            }
            else if(getDbLevel() < getThreshold(MIN) && getDbLevel() > getThreshold(AVG_MIN)){
                arr.generateArray(new Random().nextInt(3), intensityRange[AVG_MIN], intensityRange[MIN]);
                Log.d("avg_min - min","im here");
            }
            else if(getDbLevel() < getThreshold(AVG_MIN) && getDbLevel() > getThreshold(AVG_MAX)){
                arr.generateArray(new Random().nextInt(3), intensityRange[AVG_MAX], intensityRange[AVG_MIN]);
                Log.d("avg_max - avg_min","im here");
            }
            else if(getDbLevel() < getThreshold(AVG_MAX) && getDbLevel() > getThreshold(MAX)){
                arr.generateArray(new Random().nextInt(3), intensityRange[MAX], intensityRange[AVG_MAX]);
                Log.d("avg_max - max","im here");
            }
            else if(getDbLevel() < getThreshold(MAX)){
                arr.generateArray(new Random().nextInt(3), intensityRange[MAX], intensityRange[MAX]);
                Log.d("max","im here");
            }
        }
        else    // Music is stopped, hence clear data.
            arr.generateClearArray();

//                if (getDbLevel() > getThreshold(AVG_MAX) && getDbLevel() < 70) {
//                    arr.generateArray(new Random().nextInt(3), intensityRange[MAX], intensityRange[AVG_MAX]);
//                } else {
//                    arr.generateClearArray();
//                }
        return arr;
    }

    // display Toast
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
//            for(int i=color;i<mNumberOfRandomNumbers;i+=3){
                mArrayOfRandomNumbers[color] = random.nextInt(max-min+1)+min;
//            }
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
                sb.append(String.format("%03d",mArrayOfRandomNumbers[i]));
//                if(i!=mNumberOfRandomNumbers-1) {
//                    sb.append(",");
//                }
                if(i==mNumberOfRandomNumbers-1) {
                    sb.append("\n");
                }
            }
            return sb.toString();
        }
    }

}