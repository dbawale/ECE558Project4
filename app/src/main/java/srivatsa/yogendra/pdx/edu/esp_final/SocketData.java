package srivatsa.yogendra.pdx.edu.esp_final;

import android.bluetooth.BluetoothSocket;

/**
 * Created by Tejaswini on 12/3/2016.
 */

public final class SocketData {

    private static BluetoothSocket bluetoothSocket;
    private static SocketData instance;

    private SocketData() {

    }

    static {
        instance = new SocketData();
    }

    public static SocketData getInstance() {
        return instance;
    }

    public static BluetoothSocket getBluetoothSocketData() {
        return instance.bluetoothSocket;
    }

    public static void saveBluetoothSocketData(BluetoothSocket bluetoothSocket) {

        instance.bluetoothSocket = bluetoothSocket;
    }
}
