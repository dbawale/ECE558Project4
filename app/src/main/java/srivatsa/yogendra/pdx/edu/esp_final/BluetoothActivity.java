package srivatsa.yogendra.pdx.edu.esp_final;


/**
 * Created by Tejaswini Vibhute, Srivatsa Yogendra and Deven Bawale on 12/3/2016.
 *
 * The code is inspired from the android example initiating Bluetooth connection
 * in android.
 *
 * References: https://developer.android.com/guide/topics/connectivity/bluetooth.html
 *
 */

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.util.Set;

public class BluetoothActivity extends AppCompatActivity {

private static final String TAG = "BluetoothDevices";

    private BluetoothAdapter bluetoothAdapter;
    private final int REQUEST_CONNECT_DEVICE = 0;
    private ArrayAdapter<String> pairedDevicesArrayAdapter;
    String address = null;
    private int backPressedCount = 0;

    @Override
    protected void onCreate (Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Setup the window
        setContentView(R.layout.activity_bluetooth);

        // Set result CANCELED in case the user backs out
        setResult(Activity.RESULT_CANCELED);

        // Initialize the button to perform device scan
        Button scanButton = (Button)findViewById(R.id.button_scan);
        scanButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                backPressedCount = 0;
                Intent bluetoothSettingsIntent = new Intent(android.provider.Settings.ACTION_BLUETOOTH_SETTINGS);
                startActivity(bluetoothSettingsIntent);
            }
        });


        pairedDevicesArrayAdapter = new ArrayAdapter<String>(this, R.layout.device_name);

        IntentFilter filter = new IntentFilter(BluetoothDevice.ACTION_FOUND);
        filter.addAction(BluetoothAdapter.ACTION_DISCOVERY_FINISHED);

        // Find and set up the ListView for paired devices
        ListView pairedListView = (ListView)findViewById(R.id.paired_devices);
        pairedListView.setAdapter(pairedDevicesArrayAdapter);
        pairedListView.setOnItemClickListener(deviceClickListener);

        // Get the local Bluetooth adapter and set of currently paired devices
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if(bluetoothAdapter==null){
            Toast.makeText(getApplicationContext(),R.string.bluetooth_not_supported,Toast.LENGTH_SHORT).show();
            finish();
        }
    }

    @Override
    public void onResume(){
        super.onResume();
        backPressedCount = 0;
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

        pairedDevicesArrayAdapter.clear();
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
    }

    // The on-click listener for all devices in the ListViews
    private AdapterView.OnItemClickListener deviceClickListener = new AdapterView.OnItemClickListener () {
        public void onItemClick (AdapterView<?> av, View v, int arg2, long arg3) {
            backPressedCount = 0;
            // Cancel discovery because it's costly and we're about to connect
            bluetoothAdapter.cancelDiscovery();

            // Get the device MAC address, which is the last 17 chars in the View
            String info = ((TextView)v).getText().toString();
            address = info.substring(info.length() - 17);
            // Create the result Intent and include the MAC address
            Intent control_activity_intent = new Intent();
            control_activity_intent.putExtra("Address_device",address);

            // Set result and finish this Activity
            setResult(Activity.RESULT_OK, control_activity_intent);
            finish();
        }
    };

    // Easy way to display toast
    private void msg(String s)
    {
        Toast.makeText(getApplicationContext(),s,Toast.LENGTH_SHORT).show();
    }


    @Override
    public void onBackPressed(){
        Intent intent = new Intent(BluetoothActivity.this,MusicActivity.class);
        startActivity(intent);
        finish();
    }

}