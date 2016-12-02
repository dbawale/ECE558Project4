package srivatsa.yogendra.pdx.edu.esp_final;

import android.app.Activity;
import android.app.ProgressDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Set;
import java.util.UUID;

public class BluetoothActivity extends AppCompatActivity {

private static final String TAG = "BluetoothDevices";

    public static String EXTRA_DEVICE_ADDRESS = "device_address";
    private BluetoothAdapter bluetoothAdapter;
    private ArrayAdapter<String> newDevicesArrayAdapter;
    private final int REQUEST_CONNECT_DEVICE = 0;
    private ArrayAdapter<String> pairedDevicesArrayAdapter;
    private ArrayList<String> mDeviceList = new ArrayList<String>();
    private ListView newDevicesListView;
    String address = null;
    private ProgressDialog progress;
    BluetoothAdapter myBluetooth = null;
    BluetoothSocket btSocket = null;
    private boolean isBtConnected = false;
    static final UUID myUUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");

    @Override
    protected void onCreate (Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Setup the window
//        requestWindowFeature(Window.FEATURE_INDETERMINATE_PROGRESS);
        setContentView(R.layout.activity_bluetooth);

        // Set result CANCELED in case the user backs out
        setResult(Activity.RESULT_CANCELED);

        // Initialize the button to perform device scan
        Button scanButton = (Button)findViewById(R.id.button_scan);
        scanButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                discoverDevices();
                v.setVisibility(View.GONE);
            }
        });


        newDevicesArrayAdapter = new ArrayAdapter<String>(this, R.layout.device_name);
        pairedDevicesArrayAdapter = new ArrayAdapter<String>(this, R.layout.device_name);

        IntentFilter filter = new IntentFilter(BluetoothDevice.ACTION_FOUND);
        filter.addAction(BluetoothAdapter.ACTION_DISCOVERY_FINISHED);
        this.registerReceiver(receiver, filter);

        // Find and set up the ListView for paired devices
        ListView pairedListView = (ListView)findViewById(R.id.paired_devices);
        pairedListView.setAdapter(pairedDevicesArrayAdapter);
        pairedListView.setOnItemClickListener(deviceClickListener);

        // Find and set up the ListView for newly discovered devices
        newDevicesListView = (ListView)findViewById(R.id.new_devices);
        newDevicesListView.setOnItemClickListener(deviceClickListener);

        // Get the local Bluetooth adapter and set of currently paired devices
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if(bluetoothAdapter==null){
            Toast.makeText(getApplicationContext(),R.string.bluetooth_not_supported,Toast.LENGTH_SHORT).show();
            finish();
        }

        if(!bluetoothAdapter.isEnabled()){
        Intent turnOn = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
        startActivityForResult(turnOn, REQUEST_CONNECT_DEVICE);
        }
        else {

            setPairedDevices(pairedDevicesArrayAdapter);
        }
    }

    private void setPairedDevices(ArrayAdapter<String> pairedDevicesArrayAdapter) {
        Set<BluetoothDevice> pairedDevices = bluetoothAdapter.getBondedDevices();

        // If there are paired devices, add each one to the ArrayAdapter
        if (pairedDevices.size() > 0) {
            findViewById(R.id.title_paired_devices).setVisibility(View.VISIBLE);
            for (BluetoothDevice device : pairedDevices) {
                pairedDevicesArrayAdapter.add(device.getName() + "\n" + device.getAddress());
            }
        } else {
            pairedDevicesArrayAdapter.add("No paired devices");
        }
    }

    /**
     * Called when an activity returns a result to BluetoothActivity
     * @param requestCode The request code that was used to start the child activity
     * @param resultCode The result code of the result
     * @param intent The intent that was passed
     */
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent intent){
        //If the user allows Bluetooth to be turned on, then proceed. Otherwise exit.
        switch (requestCode){
            case REQUEST_CONNECT_DEVICE:
                if(resultCode == Activity.RESULT_OK){
                setPairedDevices(pairedDevicesArrayAdapter);
                }
                else{
                    Toast.makeText(getApplicationContext(),R.string.bluetooth_cannot_use_without,Toast.LENGTH_SHORT).show();
                    finish();
                }
                break;
        }
    }

    @Override
    protected void onDestroy () {
        super.onDestroy();

        // Make sure we're not doing discovery anymore
        if (bluetoothAdapter != null) {
            bluetoothAdapter.cancelDiscovery();
        }

        // Unregister broadcast listeners
        this.unregisterReceiver(receiver);
    }

    // Start device discover with the BluetoothAdapter
    private void discoverDevices () {
        Log.d(TAG, "discoverDevices()");

        // Indicate scanning in the title
        setProgressBarIndeterminateVisibility(true);
        setTitle("Scanning for new devices");

        // Turn on sub-title for new devices
        findViewById(R.id.title_new_devices).setVisibility(View.VISIBLE);

        // If we're already discovering, stop it
        if (bluetoothAdapter.isDiscovering()) {
            bluetoothAdapter.cancelDiscovery();
        }
        // Request discover from BluetoothAdapter

        bluetoothAdapter.startDiscovery();
        // Register for broadcasts when a device is discovered

    }


    // The on-click listener for all devices in the ListViews
    private AdapterView.OnItemClickListener deviceClickListener = new AdapterView.OnItemClickListener () {
        public void onItemClick (AdapterView<?> av, View v, int arg2, long arg3) {
            // Cancel discovery because it's costly and we're about to connect
            bluetoothAdapter.cancelDiscovery();

            // Get the device MAC address, which is the last 17 chars in the View
            String info = ((TextView)v).getText().toString();
            address = info.substring(info.length() - 17);

            //address = control_activity_intent.getStringExtra("Address_device");
            new ConnectBT().execute(); //Call the class to connect


//            // Create the result Intent and include the MAC address
//            Intent intent = new Intent();
//            intent.putExtra(EXTRA_DEVICE_ADDRESS, address);
//
//            // Set result and finish this Activity
//            setResult(Activity.RESULT_OK, intent);
            //finish();
        }
    };

    // The BroadcastReceiver that listens for discovered devices and changes the title when
    //discovery is finished
    private final BroadcastReceiver receiver = new BroadcastReceiver () {
        @Override
        public void onReceive (Context context, Intent intent) {
            String action = intent.getAction();

            // When discovery finds a device
            if (BluetoothDevice.ACTION_FOUND.equals(action)) {
                // Get the BluetoothDevice object from the Intent
                BluetoothDevice device = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE);
                // If it's already paired, skip it, because it's been listed already
                if (device.getBondState() != BluetoothDevice.BOND_BONDED) {
                    newDevicesArrayAdapter.add(device.getName() + "\n" + device.getAddress());
                }
                // When discovery is finished, change the Activity title
            } else if (BluetoothAdapter.ACTION_DISCOVERY_FINISHED.equals(action)) {
                setTitle("Select a device to connect");
                if (newDevicesArrayAdapter.getCount() == 0) {
                    newDevicesArrayAdapter.add("No devices found");
                }
            }
        }
    };
    private class ConnectBT extends AsyncTask<Void, Void, Void>  // UI thread
    {
        private boolean ConnectSuccess = true; //if it's here, it's almost connected

        @Override
        protected void onPreExecute()
        {
            progress = ProgressDialog.show(BluetoothActivity.this, "Connecting...", "Please wait!!!");  //show a progress dialog
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
            progress.dismiss();
            if (!ConnectSuccess)
            {
                msg("Connection Failed. Try again.");

            }
            else
            {
                msg("Connected. Yay!!");
                isBtConnected = true;

                Intent control_activity_intent = new Intent(BluetoothActivity.this, ControlActivity.class);
                control_activity_intent.putExtra("Bluetooth_Address", address);
                startActivity(control_activity_intent);
                finish();
            }


        }
    }
    // fast way to call Toast
    private void msg(String s)
    {
        Toast.makeText(getApplicationContext(),s,Toast.LENGTH_LONG).show();
    }
}