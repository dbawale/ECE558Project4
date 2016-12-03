package srivatsa.yogendra.pdx.edu.esp_final;

import android.app.ProgressDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import java.io.IOException;
import java.util.Random;
import java.util.UUID;


//TODO: Fix bugs
//TODO: What happens when user exits app?
//TODO: What happens when user tries to reconnect to already connected device?
//TODO: What happens when user turns off bluetooth when it's connected?
//TODO: What happens if the board turns off?

public class ControlActivity extends AppCompatActivity {

    String address = null;
    private ProgressDialog progress;
    BluetoothAdapter myBluetooth = null;
    BluetoothSocket btSocket = null;
    private boolean isBtConnected = false;
    static final UUID myUUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");
    EditText text1;
    Button sendbtn,clearbtn, BTConnectbtn;
    private final int REQUEST_CODE_CONNECT = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_control);


        BTConnectbtn = (Button) findViewById(R.id.BTConnect);
        BTConnectbtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent connect_bluetooth = new Intent(ControlActivity.this,BluetoothActivity.class);
                startActivityForResult(connect_bluetooth,REQUEST_CODE_CONNECT);
            }
        });
        text1 = (EditText) findViewById(R.id.textbox1);
        text1.setText("190,54,150,10,225,134,180,144,127,112,3,83,1,23,4,75,124,245,211,88,207,155,63,11,154,50,42,20,25,109,55,140,84,43,33,89,98,237,201,135,66,45,57,129,105,254,184,142,32,15,47,86,91,199,138,48,94,61,162,168,8,213,82,115,227,110,181,31,79,51,100,160,27,128,188,7,244,193,121,122,200,139,37,174,252,176,123,18,9,166,190,54,150,10,225,134,180,144,127,112,3,83,1,23,4,75,124,245,211,88,207,155,63,11,154,50,42,20,25,109,55,140,84,43,33,89,98,237,201,135,66,45,57,129,105,254,184,142,32,15,47,86,91,199,138,48,94,61,162,168,8,213,82,115,227,110,181,31,79,51,100,160,27,128,188,7,244,193,121,122,200,139,37,174,252,176,123,18,9,166\n");
        sendbtn = (Button) findViewById(R.id.sndbtn);
//      generatebtn = (Button) findViewById(R.id.generaterandombtn);
//      randomizebtn = (Button) findViewById(R.id.randomizebtn);
        clearbtn = (Button) findViewById(R.id.clearbtn);


        sendbtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                RandomNumberArray arr = new RandomNumberArray(180);
                arr.generateArray();
                text1.setText(arr.toString());
                if (btSocket!=null)
                {
                    try
                    {
                        String data = String.valueOf(text1.getText());
                        btSocket.getOutputStream().write(data.getBytes());
                    }
                    catch (IOException e)
                    {
                        msg("Error");
                    }
                }
            }
        });

//        randomizebtn.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                RandomNumberArray arr = new RandomNumberArray(180);
//
//                for(int i=5000;i>0;i--){
//                    arr.generateArray();
//                    String data = arr.toString();
//                    if (btSocket!=null)
//                    {
//                        try
//                        {
//                            btSocket.getOutputStream().write(data.getBytes());
//                        }
//                        catch (IOException e)
//                        {
//                            msg("Error");
//                        }
//                    }
//                    arr.generateClearArray();
//                    data = arr.toString();
//                    if (btSocket!=null)
//                    {
//                        try
//                        {
//                            btSocket.getOutputStream().write(data.getBytes());
//                        }
//                        catch (IOException e)
//                        {
//                            msg("Error");
//                        }
//                    }
//                }
//            }
//        });

//        generatebtn.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                RandomNumberArray arr = new RandomNumberArray(180);
//                arr.generateArray();
//                text1.setText(arr.toString());
//            }
//        });
        clearbtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                RandomNumberArray arr = new RandomNumberArray(180);
                arr.generateClearArray();
                text1.setText(arr.toString());
                if (btSocket!=null)
                {
                    try
                    {
                        String data = String.valueOf(text1.getText());
                        btSocket.getOutputStream().write(data.getBytes());
                    }
                    catch (IOException e)
                    {
                        msg("Error");
                    }
                }
            }
        });

    }

    private class ConnectBT extends AsyncTask<Void, Void, Void>  // UI thread
    {
        private boolean ConnectSuccess = true; //if it's here, it's almost connected

        @Override
        protected void onPreExecute()
        {
            progress = ProgressDialog.show(ControlActivity.this, "Connecting...", "Please wait!!!");  //show a progress dialog
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
                Intent connect_bluetooth = new Intent(ControlActivity.this,BluetoothActivity.class);
                startActivityForResult(connect_bluetooth,REQUEST_CODE_CONNECT);
            }
            else
            {
                msg("Connected. Yay!!");
                isBtConnected = true;
            }
            progress.dismiss();
        }
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
        public void generateArray(){
            for(int i=0;i<mNumberOfRandomNumbers;i++){
                mArrayOfRandomNumbers[i] = random.nextInt(255);
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

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent intent){
        switch (requestCode){
            case REQUEST_CODE_CONNECT:
                if (resultCode == RESULT_OK){
//                    Intent control_activity_intent = getIntent();
//                    address = control_activity_intent.getStringExtra("Address_device");
                    address = intent.getStringExtra("Address_device");
                    new ConnectBT().execute();
                    sendbtn.setEnabled(true);
                    clearbtn.setEnabled(true);
                    text1.setEnabled(true);
                    BTConnectbtn.setEnabled(false);
                }
                else {
                    msg("Error Finding Device");
                    finish();
                }
                break;
        }
    }

    // fast way to call Toast
    private void msg(String s)
    {
        Toast.makeText(getApplicationContext(),s,Toast.LENGTH_SHORT).show();
    }
}

