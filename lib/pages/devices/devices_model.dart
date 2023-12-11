import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'devices_widget.dart' show DevicesWidget;
import 'package:flutter/material.dart';

class DevicesModel extends FlutterFlowModel<DevicesWidget> {
  ///  Local state fields for this page.

  bool? isBluetoothEnabled = true;

  bool isFetchingConnectedDevices = false;

  bool isFetchingDevices = false;

  bool autoconnect = false;

  bool isScanning = false;

  String language = 'POR';

  List<BTDevicesStruct> foundDevices = [];
  void addToFoundDevices(BTDevicesStruct item) => foundDevices.add(item);
  void removeFromFoundDevices(BTDevicesStruct item) =>
      foundDevices.remove(item);
  void removeAtIndexFromFoundDevices(int index) => foundDevices.removeAt(index);
  void insertAtIndexInFoundDevices(int index, BTDevicesStruct item) =>
      foundDevices.insert(index, item);
  void updateFoundDevicesAtIndex(
          int index, Function(BTDevicesStruct) updateFn) =>
      foundDevices[index] = updateFn(foundDevices[index]);

  List<BTDevicesStruct> connectedDevices = [];
  void addToConnectedDevices(BTDevicesStruct item) =>
      connectedDevices.add(item);
  void removeFromConnectedDevices(BTDevicesStruct item) =>
      connectedDevices.remove(item);
  void removeAtIndexFromConnectedDevices(int index) =>
      connectedDevices.removeAt(index);
  void insertAtIndexInConnectedDevices(int index, BTDevicesStruct item) =>
      connectedDevices.insert(index, item);
  void updateConnectedDevicesAtIndex(
          int index, Function(BTDevicesStruct) updateFn) =>
      connectedDevices[index] = updateFn(connectedDevices[index]);

  String filterName = '';

  bool isConnectingToDevice = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - findDevices] action in Devices widget.
  List<BTDevicesStruct>? fetchedDevices;
  // Stores action output result for [Custom Action - getConnectedDevices] action in Devices widget.
  List<BTDevicesStruct>? fetchedConnectedDevices;
  // State field(s) for TextField widget.
  final textFieldKey = GlobalKey();
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? textFieldSelectedOption;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for ChoiceChips widget.
  String? choiceChipsValue;
  FormFieldController<List<String>>? choiceChipsValueController;
  // Stores action output result for [Custom Action - findDevices] action in ScannedDevicesList widget.
  List<BTDevicesStruct>? devicesRefreshPull;
  // Stores action output result for [Custom Action - connectDevice] action in ScannedDeviceTile widget.
  bool? hasWrite;
  // Stores action output result for [Custom Action - findDevices] action in IconButton widget.
  List<BTDevicesStruct>? devicesRefresh;
  // Stores action output result for [Custom Action - getConnectedDevices] action in IconButton widget.
  List<BTDevicesStruct>? connDevicesRefresh;
  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for Switch widget.
  bool? switchValue1;
  // Stores action output result for [Custom Action - turnOnBluetooth] action in Switch widget.
  bool? isTurningOn;
  // Stores action output result for [Custom Action - getConnectedDevices] action in Switch widget.
  List<BTDevicesStruct>? fetchedConnectedDevicesSW;
  // Stores action output result for [Custom Action - findDevices] action in Switch widget.
  List<BTDevicesStruct>? fetchedDevicesSW;
  // Stores action output result for [Custom Action - turnOffBluetooth] action in Switch widget.
  bool? isTurningOff;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
