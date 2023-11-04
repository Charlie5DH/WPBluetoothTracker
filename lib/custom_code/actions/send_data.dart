// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future sendData(BTDevicesStruct deviceInfo, String data) async {
  final device = BluetoothDevice.fromId(deviceInfo.id);
  final services = await device.discoverServices();
  for (BluetoothService service in services) {
    print('----------------------------------------------');
    print('Service: ${service.uuid}');
    print('Characteristics: ${service.characteristics}');
    print('Included Services${service.includedServices}');
    print('Primary ${service.isPrimary}');
    print('----------------------------------------------');
    for (BluetoothCharacteristic characteristic in service.characteristics) {
      final isWrite = characteristic.properties.write;
      if (isWrite) {
        // print('----------------------------------------------');
        // print('write to ${characteristic.uuid}');
        // print('Descriptors: ${characteristic.descriptors}');
        // print('Data: $data');
        // print('Write type: ${characteristic.properties}');
        // print('----------------------------------------------');
        // print('Service: ${service.uuid}');
        // print('Characteristics: ${service.characteristics}');
        // print('${service.includedServices}');
        // print('----------------------------------------------');
        await characteristic.write(data.codeUnits);
      }
    }
  }
}
