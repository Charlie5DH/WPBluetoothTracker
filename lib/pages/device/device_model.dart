import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import 'device_widget.dart' show DeviceWidget;
import 'package:flutter/material.dart';

class DeviceModel extends FlutterFlowModel<DeviceWidget> {
  ///  Local state fields for this page.

  int? currentRssi;

  String receivedValue = '';

  String language = 'POR';

  List<ServiceStruct> deviceServices = [];
  void addToDeviceServices(ServiceStruct item) => deviceServices.add(item);
  void removeFromDeviceServices(ServiceStruct item) =>
      deviceServices.remove(item);
  void removeAtIndexFromDeviceServices(int index) =>
      deviceServices.removeAt(index);
  void insertAtIndexInDeviceServices(int index, ServiceStruct item) =>
      deviceServices.insert(index, item);
  void updateDeviceServicesAtIndex(
          int index, Function(ServiceStruct) updateFn) =>
      deviceServices[index] = updateFn(deviceServices[index]);

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getDeviceServices] action in Device widget.
  List<ServiceStruct>? servicesInDevice;
  InstantTimer? rssiUpdateTimer;
  // Stores action output result for [Custom Action - getRssi] action in Device widget.
  int? updatedRssi;
  // State field(s) for Switch widget.
  bool switchValue = false;
  // Stores action output result for [Custom Action - getDeviceServices] action in ScannedDevicesList widget.
  List<ServiceStruct>? servicesFromDevice;
  // Model for StrengthIndicator component.
  late StrengthIndicatorModel strengthIndicatorModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    strengthIndicatorModel =
        createModel(context, () => StrengthIndicatorModel());
  }

  void dispose() {
    unfocusNode.dispose();
    rssiUpdateTimer?.cancel();
    strengthIndicatorModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
