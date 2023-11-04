import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import 'display_received_data_widget.dart' show DisplayReceivedDataWidget;
import 'package:flutter/material.dart';

class DisplayReceivedDataModel
    extends FlutterFlowModel<DisplayReceivedDataWidget> {
  ///  Local state fields for this component.

  String data = '';

  List<String> dataList = [];
  void addToDataList(String item) => dataList.add(item);
  void removeFromDataList(String item) => dataList.remove(item);
  void removeAtIndexFromDataList(int index) => dataList.removeAt(index);
  void insertAtIndexInDataList(int index, String item) =>
      dataList.insert(index, item);
  void updateDataListAtIndex(int index, Function(String) updateFn) =>
      dataList[index] = updateFn(dataList[index]);

  ///  State fields for stateful widgets in this component.

  InstantTimer? receivedDataTimer;
  // Stores action output result for [Custom Action - receiveData] action in displayReceivedData widget.
  String? receivedData;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    receivedDataTimer?.cancel();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
