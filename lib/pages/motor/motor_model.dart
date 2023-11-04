import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import 'motor_widget.dart' show MotorWidget;
import 'package:flutter/material.dart';

class MotorModel extends FlutterFlowModel<MotorWidget> {
  ///  Local state fields for this page.

  String selectedAngle = 'Zero';

  String currentAngle = '';

  int? writeAngleValue = 0;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  InstantTimer? instantTimer;
  // Stores action output result for [Custom Action - readMotorAngle] action in Motor widget.
  String? readAngle;
  // Stores action output result for [Custom Action - readMotorAngle] action in Container widget.
  String? readAngleUpdated;
  // State field(s) for Slider widget.
  double? sliderValue;
  // Stores action output result for [Custom Action - readMotorAngle] action in Button widget.
  String? readAngleUpdatedAfterWrite;
  // Model for StrengthIndicator component.
  late StrengthIndicatorModel strengthIndicatorModel;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    strengthIndicatorModel =
        createModel(context, () => StrengthIndicatorModel());
  }

  void dispose() {
    unfocusNode.dispose();
    instantTimer?.cancel();
    strengthIndicatorModel.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
