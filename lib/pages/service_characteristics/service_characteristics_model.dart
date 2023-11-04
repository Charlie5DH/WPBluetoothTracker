import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/widgets/received_data/received_data_widget.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import 'service_characteristics_widget.dart' show ServiceCharacteristicsWidget;
import 'package:flutter/material.dart';

class ServiceCharacteristicsModel
    extends FlutterFlowModel<ServiceCharacteristicsWidget> {
  ///  Local state fields for this page.

  ServiceStruct? serviceCharacteristics;
  void updateServiceCharacteristicsStruct(Function(ServiceStruct) updateFn) =>
      updateFn(serviceCharacteristics ??= ServiceStruct());

  List<String> receivedValues = [];
  void addToReceivedValues(String item) => receivedValues.add(item);
  void removeFromReceivedValues(String item) => receivedValues.remove(item);
  void removeAtIndexFromReceivedValues(int index) =>
      receivedValues.removeAt(index);
  void insertAtIndexInReceivedValues(int index, String item) =>
      receivedValues.insert(index, item);
  void updateReceivedValuesAtIndex(int index, Function(String) updateFn) =>
      receivedValues[index] = updateFn(receivedValues[index]);

  String currentValueRead = '';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getServiceCharacteristics] action in ServiceCharacteristics widget.
  ServiceStruct? service;
  // Model for StrengthIndicator component.
  late StrengthIndicatorModel strengthIndicatorModel;
  // Stores action output result for [Custom Action - readFromCharacteristic] action in Button widget.
  String? readFirstValue;
  // Stores action output result for [Custom Action - readFromCharacteristic] action in Button widget.
  String? readValueOnStream;
  // Stores action output result for [Custom Action - readFromCharacteristic] action in Button widget.
  String? readValue;
  // Models for ReceivedData dynamic component.
  late FlutterFlowDynamicModels<ReceivedDataModel> receivedDataModels;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    strengthIndicatorModel =
        createModel(context, () => StrengthIndicatorModel());
    receivedDataModels = FlutterFlowDynamicModels(() => ReceivedDataModel());
  }

  void dispose() {
    unfocusNode.dispose();
    strengthIndicatorModel.dispose();
    receivedDataModels.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
