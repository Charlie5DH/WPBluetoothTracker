import '/flutter_flow/flutter_flow_util.dart';
import '/widgets/receive_data_mono/receive_data_mono_widget.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import 'device_information_widget.dart' show DeviceInformationWidget;
import 'package:flutter/material.dart';

class DeviceInformationModel extends FlutterFlowModel<DeviceInformationWidget> {
  ///  Local state fields for this page.

  String characteristicUUID = 'd79e2496-9f36-45ca-9bdf-f122437903f3';

  List<String> info = [];
  void addToInfo(String item) => info.add(item);
  void removeFromInfo(String item) => info.remove(item);
  void removeAtIndexFromInfo(int index) => info.removeAt(index);
  void insertAtIndexInInfo(int index, String item) => info.insert(index, item);
  void updateInfoAtIndex(int index, Function(String) updateFn) =>
      info[index] = updateFn(info[index]);

  String currentInfo = 'solicitando...';

  bool isFetching = false;

  bool firstLoad = true;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for StrengthIndicator component.
  late StrengthIndicatorModel strengthIndicatorModel;
  // Model for receiveDataMono component.
  late ReceiveDataMonoModel receiveDataMonoModel;
  // Stores action output result for [Custom Action - getLineStatus] action in Button widget.
  String? informationRead;
  // Stores action output result for [Custom Action - getLineStatus] action in Button widget.
  String? infoReadOnStream;
  String infoReadStart = '';
  String infoReadOnStreamStart = '';

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    strengthIndicatorModel =
        createModel(context, () => StrengthIndicatorModel());
    receiveDataMonoModel = createModel(context, () => ReceiveDataMonoModel());
  }

  void dispose() {
    unfocusNode.dispose();
    strengthIndicatorModel.dispose();
    receiveDataMonoModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
