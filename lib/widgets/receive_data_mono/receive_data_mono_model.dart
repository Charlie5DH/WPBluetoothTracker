import '/flutter_flow/flutter_flow_util.dart';
import 'receive_data_mono_widget.dart' show ReceiveDataMonoWidget;
import 'package:flutter/material.dart';

class ReceiveDataMonoModel extends FlutterFlowModel<ReceiveDataMonoWidget> {
  ///  Local state fields for this component.

  List<String> receivedData = [];
  void addToReceivedData(String item) => receivedData.add(item);
  void removeFromReceivedData(String item) => receivedData.remove(item);
  void removeAtIndexFromReceivedData(int index) => receivedData.removeAt(index);
  void insertAtIndexInReceivedData(int index, String item) =>
      receivedData.insert(index, item);
  void updateReceivedDataAtIndex(int index, Function(String) updateFn) =>
      receivedData[index] = updateFn(receivedData[index]);

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
