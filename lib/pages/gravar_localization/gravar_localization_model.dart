import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import 'gravar_localization_widget.dart' show GravarLocalizationWidget;
import 'package:flutter/material.dart';

class GravarLocalizationModel
    extends FlutterFlowModel<GravarLocalizationWidget> {
  ///  Local state fields for this page.

  String receivedText = '';

  int? currentRssi;

  String currentLocalization = '';

  bool seeWarning = true;

  LatLng? deviceLocation;

  LatLng? devicePrevLocation;

  bool isRequestingLocalization = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - getFullLocalizationFromService] action in GravarLocalization widget.
  String? loadedLocalization;
  // Model for StrengthIndicator component.
  late StrengthIndicatorModel strengthIndicatorModel;
  // Stores action output result for [Custom Action - getFullLocalizationFromService] action in Button widget.
  String? loadedLocalizationButton;
  // State field(s) for ChoiceChips widget.
  String? choiceChipsValue;
  FormFieldController<List<String>>? choiceChipsValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // Stores action output result for [Custom Action - getFullLocalizationFromService] action in Button widget.
  String? updatedLocalization;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    strengthIndicatorModel =
        createModel(context, () => StrengthIndicatorModel());
  }

  void dispose() {
    unfocusNode.dispose();
    strengthIndicatorModel.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
