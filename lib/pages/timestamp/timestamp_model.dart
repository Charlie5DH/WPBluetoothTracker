import '/flutter_flow/flutter_flow_util.dart';
import '/widgets/received_data/received_data_widget.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import 'timestamp_widget.dart' show TimestampWidget;
import 'package:flutter/material.dart';

class TimestampModel extends FlutterFlowModel<TimestampWidget> {
  ///  Local state fields for this page.

  String currentTimestamp = '';

  List<String> timestampHistory = [];
  void addToTimestampHistory(String item) => timestampHistory.add(item);
  void removeFromTimestampHistory(String item) => timestampHistory.remove(item);
  void removeAtIndexFromTimestampHistory(int index) =>
      timestampHistory.removeAt(index);
  void insertAtIndexInTimestampHistory(int index, String item) =>
      timestampHistory.insert(index, item);
  void updateTimestampHistoryAtIndex(int index, Function(String) updateFn) =>
      timestampHistory[index] = updateFn(timestampHistory[index]);

  bool reading = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getTimestampFromDevice] action in Timestamp widget.
  String? firstTimeReadTimestamp;
  // Stores action output result for [Custom Action - getTimestampFromDevice] action in Button widget.
  String? readTimeStreamFirst;
  // Stores action output result for [Custom Action - getTimestampFromDevice] action in Button widget.
  String? readTimeStream;
  // Stores action output result for [Custom Action - getTimestampFromDevice] action in Button widget.
  String? streamTimestampLine;
  // Model for ReceivedData component.
  late ReceivedDataModel receivedDataModel;
  // Model for StrengthIndicator component.
  late StrengthIndicatorModel strengthIndicatorModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    receivedDataModel = createModel(context, () => ReceivedDataModel());
    strengthIndicatorModel =
        createModel(context, () => StrengthIndicatorModel());
  }

  void dispose() {
    unfocusNode.dispose();
    receivedDataModel.dispose();
    strengthIndicatorModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
