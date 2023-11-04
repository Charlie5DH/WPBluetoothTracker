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

Future<void> findDevices(String sortBy, Function setStateCallback,
    List<BTDevicesStruct> devices) async {
  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  List<BTDevicesStruct> devicesList = [];
  List startsWithSTS = [];
  List startsWithSTC = [];
  List otherObjects = [];

  devices.clear();

  _scanResultsSubscription = FlutterBluePlus.scanResults.listen((results) {
    for (ScanResult r in results) {
      // if the device is already in the list, replace it with the new one
      if (devices
          .any((element) => element.id == r.device.remoteId.toString())) {
        setStateCallback(() {
          devices.removeWhere(
              (element) => element.id == r.device.remoteId.toString());
        });
      }

      if (r.device.platformName.isNotEmpty) {
        final connectedDevices = FlutterBluePlus.connectedDevices;
        setStateCallback(() {
          devices.add(BTDevicesStruct(
            name: r.device.platformName,
            id: r.device.remoteId.toString(),
            rssi: r.rssi,
            type: "BLE",
            connectable: r.advertisementData.connectable,
          ));

          devices.sort((a, b) => b.rssi.compareTo(a.rssi));
          startsWithSTS = devices
              .where((element) => element.name.startsWith('STS'))
              .toList();
          startsWithSTC = devices
              .where((element) => element.name.startsWith('STC'))
              .toList();
          otherObjects = devices
              .where((element) =>
                  !element.name.startsWith('STS') &&
                  !element.name.startsWith('STC'))
              .toList();

          startsWithSTS.sort((a, b) => b.rssi.compareTo(a.rssi));
          startsWithSTC.sort((a, b) => b.rssi.compareTo(a.rssi));
          otherObjects.sort((a, b) => b.rssi.compareTo(a.rssi));

          if (connectedDevices.contains(r.device) == false &&
              r.advertisementData.connectable == true &&
              (r.device.platformName.startsWith("STS") ||
                  r.device.platformName.startsWith("STC"))) {
            try {
              print('connecting to ${r.device.platformName}');
              r.device.connect();
              print("connected to ${r.device.platformName}");
            } catch (e) {
              // print(e);
              print("failed to connect to ${r.device.platformName}");
            }
          }

          print('Devices sorted $devices');

          devices = [...startsWithSTS, ...startsWithSTC, ...otherObjects];
        });

        print(r.device.platformName);

        // connect the device
      }
    }
  });

  print("starting scan");

  try {
    // await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
    await FlutterBluePlus.startScan();
  } catch (e) {
    print(e);
  }

  // Wait for the scan to complete
  await Future.delayed(Duration(seconds: 15));

  // Cancel the subscription
  await _scanResultsSubscription.cancel();

  //---------------------------------------------------------------
  // connect with the devices
  // for (int i = 0; i < devices.length; i++) {
  //   final deviceResult = devices[i];
  //   final device = BluetoothDevice.fromId(deviceResult.id);
  //   final connectedDevices = FlutterBluePlus.connectedDevices;
  //   // if the device is already connected, don't try to connect again
  //   if (connectedDevices.contains(device)) {
  //     continue;
  //   }
  //   if (deviceResult.connectable == false) {
  //     continue;
  //   }
  //   if (device.platformName.startsWith("STS") ||
  //       device.platformName.startsWith("STC")) {
  //     try {
  //       print('connecting to ${device.platformName}');
  //       await device.connect();
  //       print("connected to ${device.platformName}");
  //     } catch (e) {
  //       // print(e);
  //       print("failed to connect to ${device.platformName}");
  //     }
  //   }
  // }
  //---------------------------------------------------------------

  // final connectedDevices = FlutterBluePlus.connectedDevices;
  // // final connectedDevices = await flutterBlue.connectedDevices;
  // for (int i = 0; i < connectedDevices.length; i++) {
  //   final deviceResult = connectedDevices[i];
  //   // if the device is already connected, remove it from the list of devices
  //   devices.removeWhere(
  //       (element) => element.id == deviceResult.remoteId.toString());
  // }

  // if (sortBy == "STS-STC" || sortBy == "STC-STS") {
  //   List startsWithSTS = [];
  //   List startsWithSTC = [];
  //   List otherObjects = [];

  //   for (var obj in devices) {
  //     if (obj.name.startsWith("STS")) {
  //       startsWithSTS.add(obj);
  //     } else if (obj.name.startsWith("STC")) {
  //       startsWithSTC.add(obj);
  //     } else {
  //       otherObjects.add(obj);
  //     }
  //   }

  //   // startsWithSTS.sort((a, b) => a.name.compareTo(b.name));
  //   // startsWithSTC.sort((a, b) => a.name.compareTo(b.name));
  //   // otherObjects.sort((a, b) => a.name.compareTo(b.name));

  //   if (sortBy == "STS-STC") {
  //     // sort the STS by rssi, then STC by rssi, then everything else by rssi
  //     startsWithSTS.sort((a, b) => b.rssi.compareTo(a.rssi));
  //     startsWithSTC.sort((a, b) => b.rssi.compareTo(a.rssi));
  //     otherObjects.sort((a, b) => b.rssi.compareTo(a.rssi));

  //     return [...startsWithSTS, ...startsWithSTC, ...otherObjects];
  //   } else {
  //     startsWithSTS.sort((a, b) => b.rssi.compareTo(a.rssi));
  //     startsWithSTC.sort((a, b) => b.rssi.compareTo(a.rssi));
  //     otherObjects.sort((a, b) => b.rssi.compareTo(a.rssi));

  //     return [...startsWithSTC, ...startsWithSTS, ...otherObjects];
  //   }
  // } else if (sortBy == "RSSI") {
  //   devices.sort((a, b) => b.rssi.compareTo(a.rssi));
  //   return devices;
  // } else {
  //   // If sortingParam is not "STS," sort the list without any changes.
  //   devices.sort((a, b) => a.name.compareTo(b.name));
  //   return devices;
  // }

  // return devices;
}
