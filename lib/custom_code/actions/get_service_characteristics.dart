// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<ServiceStruct> getServiceCharacteristics(
  BTDevicesStruct? deviceInfo,
  String? serviceUUID,
) async {
  // Add your function code here!
  final device = BluetoothDevice.fromId(deviceInfo!.id);
  final services = await device.discoverServices();

  // returns the service with the given UUID
  BluetoothService service = services.firstWhere(
      (element) => element.uuid.toString() == serviceUUID,
      orElse: () => throw Exception("Service not found"));

  // print(service.characteristics);

  String serviceName = "Custom Service";
  if (service.uuid.toString() == "bae55b96-7d19-458d-970c-50613d801bc9") {
    serviceName = "Localization";
  } else if (service.uuid.toString() ==
      "6d98920a-905f-4c29-8322-b274154811ea") {
    serviceName = "Line Status";
  } else if (service.uuid.toString() ==
      "a617811d-d2a0-4155-923e-de09de01849c") {
    serviceName = "Timestamp";
  } else if (service.uuid.toString() ==
      "0000180a-0000-1000-8000-00805f9b34fb") {
    serviceName = "Device Information";
  } else if (service.uuid.toString().startsWith("00001800")) {
    serviceName = "Generic Access";
  } else if (service.uuid.toString().startsWith("00001801")) {
    serviceName = "Generic Attribute";
  }

  return ServiceStruct(
      uuid: service.uuid.toString(),
      name: serviceName,
      primary: service.isPrimary,
      bluetoothCharacteristic: service.characteristics
          .map((characteristic) => ServiceCharacteristicStruct(
              uuid: characteristic.uuid.toString(),
              serviceUuid: characteristic.serviceUuid.toString(),
              secondaryServiceUuid:
                  characteristic.secondaryServiceUuid.toString(),
              properties: CharacteristicPropertiesStruct(
                  broadcast: characteristic.properties.broadcast,
                  read: characteristic.properties.read,
                  write: characteristic.properties.write,
                  writeWithoutResponse:
                      characteristic.properties.writeWithoutResponse),
              descriptors: characteristic.descriptors
                  .map((descriptor) => BluetoothDescriptorStruct(
                        uuid: descriptor.uuid.toString(),
                        deviceId: descriptor.remoteId.toString(),
                        serviceUuid: descriptor.serviceUuid.toString(),
                        characteristicUuid:
                            descriptor.characteristicUuid.toString(),
                      ))
                  .toList()))
          .toList());
}
