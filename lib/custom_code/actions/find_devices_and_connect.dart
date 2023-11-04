// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Imports other custom actions
// Imports custom functions

// Imports other custom actions
// Imports custom functions

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<List<BTDevicesStruct>> findDevicesAndConnect(String sortBy) async {
  List<BTDevicesStruct> devices = [];

  FlutterBluePlus.scanResults.listen((results) {
    List<ScanResult> scannedDevices = [];
    for (ScanResult r in results) {
      scannedDevices.add(r);
    }

    print("number of devices: ${scannedDevices.length}");
    // print("sortBy: $sortBy");

    // if sortBy = STC-STS then all devices starting with STC will be at the top, then STS, then everything else
    // if sortBy = STS-STC then all devices starting with STS will be at the top, then STC, then everything else
    // if sortBy = RSSI then all devices will be sorted by signal strength

    // scannedDevices.sort((a, b) => b.rssi.compareTo(a.rssi));

    devices.clear();

    scannedDevices.forEach((deviceResult) {
      if (deviceResult.device.platformName.isNotEmpty) {
        devices.add(BTDevicesStruct(
          name: deviceResult.device.platformName,
          id: deviceResult.device.remoteId.toString(),
          rssi: deviceResult.rssi,
          type: "BLE",
          connectable: deviceResult.advertisementData.connectable,
        ));

        // connect the device
      } else if (deviceResult.advertisementData.localName.isNotEmpty) {
        devices.add(BTDevicesStruct(
          name: deviceResult.advertisementData.localName,
          id: deviceResult.device.remoteId.toString(),
          rssi: deviceResult.rssi,
          type: "BLE",
          connectable: deviceResult.advertisementData.connectable,
        ));
      }
    });
  });

  final isScanning = FlutterBluePlus.isScanningNow;
  if (!isScanning) {
    await FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 10),
    );
  }

  final connectedDevices = FlutterBluePlus.connectedDevices;
  for (int i = 0; i < connectedDevices.length; i++) {
    final deviceResult = connectedDevices[i];
    // if the device is already connected, remove it from the list of devices
    devices.removeWhere(
        (element) => element.id == deviceResult.remoteId.toString());
  }

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
