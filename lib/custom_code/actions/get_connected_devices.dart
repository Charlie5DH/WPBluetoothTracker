// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Imports other custom actions
// Imports custom functions

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<List<BTDevicesStruct>> getConnectedDevices(String sortBy) async {
  final connectedDevices = FlutterBluePlus.connectedDevices;
  List<BTDevicesStruct> devices = [];
  for (int i = 0; i < connectedDevices.length; i++) {
    final deviceResult = connectedDevices[i];

    final deviceState = await deviceResult.connectionState.first;
    if (deviceState == BluetoothConnectionState.connected) {
      final deviceRssi = await deviceResult.readRssi();

      if (deviceResult.platformName.isNotEmpty) {
        devices.add(BTDevicesStruct(
          name: deviceResult.platformName,
          id: deviceResult.remoteId.toString(),
          rssi: deviceRssi,
          type: "BLE",
          connectable: true,
        ));
      }
    }
  }

  // if sortBy = STC-STS then all devices starting with STC will be at the top, then STS, then everything else
  // if sortBy = STS-STC then all devices starting with STS will be at the top, then STC, then everything else
  // if sortBy = RSSI then all devices will be sorted by signal strength
  // scannedDevices.sort((a, b) => b.rssi.compareTo(a.rssi));

  if (sortBy == "STS-STC" || sortBy == "STC-STS") {
    List startsWithSTS = [];
    List startsWithSTC = [];
    List otherObjects = [];

    for (var obj in devices) {
      if (obj.name.startsWith("STS")) {
        startsWithSTS.add(obj);
      } else if (obj.name.startsWith("STC")) {
        startsWithSTC.add(obj);
      } else {
        otherObjects.add(obj);
      }
    }

    // startsWithSTS.sort((a, b) => a.name.compareTo(b.name));
    // startsWithSTC.sort((a, b) => a.name.compareTo(b.name));
    // otherObjects.sort((a, b) => a.name.compareTo(b.name));

    if (sortBy == "STS-STC") {
      // sort the STS by rssi, then STC by rssi, then everything else by rssi
      startsWithSTS.sort((a, b) => b.rssi.compareTo(a.rssi));
      startsWithSTC.sort((a, b) => b.rssi.compareTo(a.rssi));
      otherObjects.sort((a, b) => b.rssi.compareTo(a.rssi));

      return [...startsWithSTS, ...startsWithSTC, ...otherObjects];
    } else {
      startsWithSTS.sort((a, b) => b.rssi.compareTo(a.rssi));
      startsWithSTC.sort((a, b) => b.rssi.compareTo(a.rssi));
      otherObjects.sort((a, b) => b.rssi.compareTo(a.rssi));

      return [...startsWithSTC, ...startsWithSTS, ...otherObjects];
    }
  } else if (sortBy == "RSSI") {
    devices.sort((a, b) => b.rssi.compareTo(a.rssi));
    return devices;
  } else {
    // If sortingParam is not "STS," sort the list without any changes.
    devices.sort((a, b) => a.name.compareTo(b.name));
    return devices;
  }

  // return devices;
}
