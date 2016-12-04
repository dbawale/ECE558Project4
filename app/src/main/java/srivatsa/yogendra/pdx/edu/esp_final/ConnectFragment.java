package srivatsa.yogendra.pdx.edu.esp_final;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;


public class ConnectFragment extends Fragment implements Button.OnClickListener{

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
        //connectBtn = (Button)getView().findViewById(R.id.connectbtn);
        connectBtn = (Button)view.findViewById(R.id.connectbtn);
        connectBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                OnConnectButtonPressedListener listener = (OnConnectButtonPressedListener)getActivity();
                listener.onConnectButtonPressed();
            }
        });
        return view;
    }

//    // TODO: Rename method, update argument and hook method into UI event
//    public void onButtonPressed(Uri uri) {
//        if (mListener != null) {
//            mListener.onConnectButtonPressed(uri);
//        }
//    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        if (context instanceof OnConnectButtonPressedListener) {
            mListener = (OnConnectButtonPressedListener) context;
        } else {
            throw new RuntimeException(context.toString()
                    + " must implement OnConnectButtonPressedListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }


    @Override
    public void onClick(View view) {
        if(view.getId()==R.id.connectbtn){
            OnConnectButtonPressedListener listener = (OnConnectButtonPressedListener)getActivity();
            listener.onConnectButtonPressed();
        }
    }

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    public interface OnConnectButtonPressedListener {
        void onConnectButtonPressed();
    }
}
