// Automatic FlutterFlow imports
// Imports other custom actions
// Imports custom functions
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Add the following code:
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

Future<bool> isBluetoothEnabled() async {
  BluetoothAdapterState state = await FlutterBluePlus.adapterState.firstWhere(
      (state) =>
          state == BluetoothAdapterState.on ||
          state == BluetoothAdapterState.off);
  return state == BluetoothAdapterState.on;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!
