import '/flutter_flow/flutter_flow_util.dart';
import '/widgets/receive_data_mono/receive_data_mono_widget.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import 'line_status_widget.dart' show LineStatusWidget;
import 'package:flutter/material.dart';

class LineStatusModel extends FlutterFlowModel<LineStatusWidget> {
  ///  Local state fields for this page.

  List<String> measures = [];
  void addToMeasures(String item) => measures.add(item);
  void removeFromMeasures(String item) => measures.remove(item);
  void removeAtIndexFromMeasures(int index) => measures.removeAt(index);
  void insertAtIndexInMeasures(int index, String item) =>
      measures.insert(index, item);
  void updateMeasuresAtIndex(int index, Function(String) updateFn) =>
      measures[index] = updateFn(measures[index]);

  String currentMeasure = '';

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for receiveDataMono component.
  late ReceiveDataMonoModel receiveDataMonoModel;
  // Stores action output result for [Custom Action - getLineStatus] action in Button widget.
  String? lineStatusRead;
  // Stores action output result for [Custom Action - getLineStatus] action in Button widget.
  String? lineStatusReadOnStream;
  // Model for StrengthIndicator component.
  String lineStatusReadStart = '';
  String lineStatusReadOnStreamStart = '';
  bool isFetchingStatus = false;
  bool firstLoad = true;
  late StrengthIndicatorModel strengthIndicatorModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    receiveDataMonoModel = createModel(context, () => ReceiveDataMonoModel());
    strengthIndicatorModel =
        createModel(context, () => StrengthIndicatorModel());
  }

  void dispose() {
    unfocusNode.dispose();
    receiveDataMonoModel.dispose();
    strengthIndicatorModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
