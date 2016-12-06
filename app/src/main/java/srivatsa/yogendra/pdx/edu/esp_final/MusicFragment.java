package srivatsa.yogendra.pdx.edu.esp_final;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.jjoe64.graphview.GraphView;
import com.jjoe64.graphview.series.DataPoint;
import com.jjoe64.graphview.series.LineGraphSeries;


public class MusicFragment extends Fragment {
    private OnMusicButtonPressedListener mListener;
    private Button startButton, stopButton;
    static LineGraphSeries<DataPoint> series;
    static Boolean isStopEnabled;

    private Runnable mTimer;
    public MusicFragment() {
        // Required empty public constructor
    }

    public Boolean getStopEnabled(){
        return isStopEnabled;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        series = new LineGraphSeries<>();
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_music, container, false);
        GraphView graph = (GraphView) view.findViewById(R.id.graph);
        graph.getViewport().setXAxisBoundsManual(true);
        graph.getViewport().setMinX(-5);
        graph.getViewport().setMaxX(2);
        graph.addSeries(series);
        startButton = (Button) view.findViewById(R.id.startbutton);
        stopButton = (Button) view.findViewById(R.id.stopbutton);
        startButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                setStopEnabled();
                series.resetData(new DataPoint[0]);
                OnMusicButtonPressedListener listener = (OnMusicButtonPressedListener) getActivity();
                listener.onStartButtonPressed();
            }
        });
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

    public void setStartEnabled(){
        stopButton.setVisibility(View.INVISIBLE);
        startButton.setVisibility(View.VISIBLE);
        startButton.setEnabled(true);
        stopButton.setEnabled(false);
        isStopEnabled = false;
    }

    public void setStopEnabled(){
        startButton.setVisibility(View.INVISIBLE);
        startButton.setEnabled(false);
        stopButton.setEnabled(true);
        isStopEnabled = true;
        stopButton.setVisibility(View.VISIBLE);
    }

    public void updateGraph(final double dBValue, final float seconds){
                series.appendData(new DataPoint(seconds, dBValue), true, 400);
    }

    public interface OnMusicButtonPressedListener {
        void onStartButtonPressed();
        void onStopButtonPressed();
    }
}
