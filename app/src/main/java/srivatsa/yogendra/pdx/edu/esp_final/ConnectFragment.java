package srivatsa.yogendra.pdx.edu.esp_final;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;


public class ConnectFragment extends Fragment{

    private OnConnectButtonPressedListener mListener;
    private Button connectBtn;

    public ConnectFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_connect, container, false);

        //Find the only widget on this fragment: the connect button
        connectBtn = (Button)view.findViewById(R.id.connectbtn);

        //Call the hosting activity's onConnectButtonPressed
        connectBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                OnConnectButtonPressedListener listener = (OnConnectButtonPressedListener)getActivity();
                listener.onConnectButtonPressed();
            }
        });
        return view;
    }

    /**
     * The onAttach event for the fragment.
     * Called when the fragment attaches
     * @param context The context of the fragment
     */
    @Override
    public void onAttach(Context context) {
        super.onAttach(context);

        //Throw an exception if the hosting activity doesn't implement the interface
        if (context instanceof OnConnectButtonPressedListener) {
            mListener = (OnConnectButtonPressedListener) context;
        } else {
            throw new RuntimeException(context.toString()
                    + " must implement OnConnectButtonPressedListener");
        }
    }

    /**
     * Called when the fragment detaches from the activity
     */
    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    /**
     * OnConnectButtonPressedListener should be implemented by any activity that hosts
     * ConnectFragment
     */
    public interface OnConnectButtonPressedListener {
        void onConnectButtonPressed();
    }


}
