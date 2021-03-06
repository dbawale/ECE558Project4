package srivatsa.yogendra.pdx.edu.esp_final;

/**
 * Created by Tejaswini Vibhute, Srivatsa Yogendra and Deven Bawale on 12/3/2016.
 */

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.Paint;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.jjoe64.graphview.GraphView;
import com.jjoe64.graphview.series.BarGraphSeries;
import com.jjoe64.graphview.series.DataPoint;


public class MusicFragment extends Fragment {

    private OnMusicButtonPressedListener mListener;
    private Button startButton, stopButton;
    static BarGraphSeries<DataPoint> series;
    static Boolean isStopEnabled = false;
    private final int REQUEST_CODE_CONNECT =1;


    public MusicFragment() {
        // Required empty public constructor
    }

    public Boolean getStopEnabled(){
        return isStopEnabled;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        series = new BarGraphSeries<>();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_music, container, false);
        GraphView graph = (GraphView) view.findViewById(R.id.graph);

        // The Visual setting for the GraphView
        graph.getGridLabelRenderer().setGridColor(-1);
        graph.getGridLabelRenderer().setHighlightZeroLines(false);
        graph.getGridLabelRenderer().setHorizontalLabelsVisible(false);
        graph.getGridLabelRenderer().setVerticalLabelsVisible(false);
        graph.getViewport().setXAxisBoundsManual(true);
        graph.getViewport().setMinX(-5);
        graph.getViewport().setMaxX(2);
        graph.getViewport().setMaxY(0);
        graph.getViewport().setMinY(-100);
        graph.addSeries(series);


        startButton = (Button) view.findViewById(R.id.startbutton);
        stopButton = (Button) view.findViewById(R.id.stopbutton);

        //Set startButton to call onStartButtonPressed which is implemented in MusicActivity
        startButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                setStopEnabled();
                series.resetData(new DataPoint[0]);
                OnMusicButtonPressedListener listener = (OnMusicButtonPressedListener) getActivity();
                listener.onStartButtonPressed();
            }
        });

        //Set stopButton to call onStopButtonPressed which is implemented in MusicActivity
        stopButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                setStartEnabled();
                OnMusicButtonPressedListener listener = (OnMusicButtonPressedListener) getActivity();
                listener.onStopButtonPressed();

            }
        });
        return view;
    }

    //When the fragment attaches check if the activity implements the interface
    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        if (context instanceof OnMusicButtonPressedListener) {
            mListener = (OnMusicButtonPressedListener) context;
        } else {
            throw new RuntimeException(context.toString()
                    + " must implement OnMusicButtonPressedListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    //Show start button, hide stop button
    public void setStartEnabled(){
        stopButton.setVisibility(View.INVISIBLE);
        startButton.setVisibility(View.VISIBLE);
        startButton.setEnabled(true);
        stopButton.setEnabled(false);
        isStopEnabled = false;
    }

    //Show stopbutton, hide startbutton
    public void setStopEnabled(){
        startButton.setVisibility(View.INVISIBLE);
        startButton.setEnabled(false);
        stopButton.setEnabled(true);
        isStopEnabled = true;
        stopButton.setVisibility(View.VISIBLE);
    }

    //Update GraphView
    public void updateGraph(final double dBValue, final float seconds){
                series.appendData(new DataPoint(seconds, dBValue), true, 400);
    }

    //Change the color of thr graph
    public void changeColor(int RED, int BLUE, int GREEN){
        Paint paint = new Paint();
        paint.setColor(Color.rgb(RED,GREEN,BLUE));
        series.setCustomPaint(paint);
    }

    //Any activity that contains this fragment should also implement this interface
    public interface OnMusicButtonPressedListener {
        void onStartButtonPressed();
        void onStopButtonPressed();
    }

    @Override
    public void onResume()
    {
        super.onResume();
        MusicActivity musicActivity = (MusicActivity) this.getActivity();
        musicActivity.isMicrophoneOn();
        if (!musicActivity.btSocket.isConnected()){
            Intent connect_bluetooth = new Intent(musicActivity,BluetoothActivity.class);
            startActivityForResult(connect_bluetooth,REQUEST_CODE_CONNECT);
        }
    }
}
