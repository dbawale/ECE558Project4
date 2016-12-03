package srivatsa.yogendra.pdx.edu.esp_final;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.util.ArrayList;


import android.media.AudioRecord;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.lang.reflect.Array;
import java.util.ArrayList;

import be.tarsos.dsp.AudioDispatcher;
import be.tarsos.dsp.AudioEvent;
import be.tarsos.dsp.io.android.AudioDispatcherFactory;
import be.tarsos.dsp.pitch.PitchDetectionHandler;
import be.tarsos.dsp.pitch.PitchDetectionResult;
import be.tarsos.dsp.pitch.PitchProcessor;

public class MainActivity extends AppCompatActivity {

    //private float pitchValue;
    //private double amplitudeValue;
    private int size = 512;
    private int sampleRate = 24000;
    private AudioDispatcher dispatcher;
    private Thread thread;
    private double duration;
    private ArrayList<Double> amplitudeBuffer;

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
    private static final int MIN_THRESHOLD = 0;
    private static final int MAX_THRESHOLD = 1;
    private static final int AVG_THRESHOLD = 2;
    private double[] threshold = new double[3];


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        initialize(); // Initialize all the widgets to be used in the activity

        /*
         * Set on click listener for start listening to music
         */
        startButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startButton.setEnabled(false);
                stopButton.setEnabled(true);
                amplitudeBuffer = new ArrayList<Double>();
                //Initialize audio dispatcher to listen from microphone
                dispatcher = AudioDispatcherFactory.fromDefaultMicrophone(sampleRate,1024,size);

                // Calculate the pitch and loudness in the detected audio stream
                //CalculatePitchLoudness(dispatcher);
                CalculatePitchLoudness();

                // do this calculation in a thread

                thread = new Thread(dispatcher,"Audio Dispatcher");
                thread.start();

            }
        });

        /*
         * On click listener for stop listening to music
         */
        stopButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                thread.interrupt();
                thread = null;
                startButton.setEnabled(true);
                stopButton.setEnabled(false);
                try{
                    if(dispatcher!=null)
                    {
                        dispatcher.stop();
                    }
                }
                catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });

    }

    // Getters and Setters

    public double getThreshold(int index) {
        return this.threshold[index];
    }

    public void setThreshold(double thresholdValue, int index) {
        this.threshold[index] = thresholdValue;
    }


    /**
     *
     */
    public void initialize()
    {
        startButton = (Button) findViewById(R.id.startButton);
        stopButton = (Button) findViewById(R.id.stopButton);
        pitchText = (TextView) findViewById(R.id.pitchTextView);
        amplitudeText = (TextView) findViewById(R.id.amplitudeTextView);
        durationText = (TextView) findViewById(R.id.durationTextView);
        thresholdText = (TextView) findViewById(R.id.thresholdTextView);

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
                double dbLevel = soundPressureLevel(audioEvent.getFloatBuffer());
                calculateThreshold(dbLevel);
                Log.d("AMPLITUDE", String.valueOf(amplitudeValue));
                Log.d("DECIBEL", String.valueOf(dbLevel));
                display(pitchValue, amplitudeValue);
            }
        }));

        Log.d("THRESHOLD", String.valueOf(getThreshold(AVG_THRESHOLD)));
    }

    private double soundPressureLevel(final float[] buffer) {
        double power = 0.0D;
        for (float element : buffer) {
            power += element * element;
        }
        double value = Math.pow(power, 0.5)/ buffer.length;;
        return 20.0 * Math.log10(value);
    }

    private void calculateThreshold(double dbValue) {
        double secondsProcessed = Math.abs(dispatcher.secondsProcessed());

        /* Use the first 10sec of audio stream as training data for the microphone.
         * Using this data set the threshold values for colors to be displayed.
         */
        if((secondsProcessed <= 2))
            amplitudeBuffer.add(dbValue);
        else if((secondsProcessed<2.20) && ((secondsProcessed%2 >= 0) && (secondsProcessed%2 < 0.05)))
            setThreshold();
//
//        if((secondsProcessed%30 >= 0) && (secondsProcessed%30 < 0.05))
//        {
//
//            // Reset the threshold.
//            // use the next 10sec as training data.
//        }
    }

    /**
     * Calculate the minimum, maximum, average value of the amplitude for a period of 10sec
     */
    private void setThreshold() {
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

        setThreshold(min, MIN_THRESHOLD);
        setThreshold(max, MAX_THRESHOLD);
        setThreshold(avg, AVG_THRESHOLD);
        amplitudeBuffer.clear();
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