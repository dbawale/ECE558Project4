package srivatsa.yogendra.pdx.edu.esp_final;

/**
 * Created by Tejaswini Vibhute, Srivatsa Yogendra and Deven Bawale on 12/3/2016.
 */

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;


public class ConnectFragment extends Fragment{

    private OnConnectButtonPressedListener mListener;
    private Button connectBtn, creditBtn;
    private TextView creditText;
    private boolean creditsView = false;

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
        creditBtn = (Button) view.findViewById(R.id.creditsbtn);
        creditText = (TextView) view.findViewById(R.id.creditsText);

        //Call the hosting activity's onConnectButtonPressed
        connectBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                OnConnectButtonPressedListener listener = (OnConnectButtonPressedListener)getActivity();
                listener.onConnectButtonPressed();
            }
        });

        //Credits shown for the developers
        creditBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                creditsView = true;
                onSetCreditView();
            }
        });

        return view;
    }

    /**
     * Code to enable the views that show the text fields consisting of the Developers names
     */
    public void onSetCreditView()
    {
        connectBtn.setVisibility(View.INVISIBLE);
        creditBtn.setVisibility(View.INVISIBLE);
        creditText.setVisibility(View.VISIBLE);
    }

    /**
     * Code to disable the views that show the text fields consisting of the Developers names
     */

    public void onReturnCreditView()
    {
        connectBtn.setVisibility(View.VISIBLE);
        creditBtn.setVisibility(View.VISIBLE);
        creditText.setVisibility(View.INVISIBLE);
    }


    /**
     * Indicates the view in display
     * @return True - The app is showing the Credits
     *         False - The app is not showing the credits
     */
    public boolean isCreditsView() {
        return creditsView;
    }

    /**
     * Sets if the credits view is enabled or disabled
     * @param creditsView Boolean indicating the status
     */
    public void setCreditsView(boolean creditsView) {
        this.creditsView = creditsView;
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
