import '/flutter_flow/flutter_flow_util.dart';
import 'entry_widget.dart' show EntryWidget;
import 'package:flutter/material.dart';

class EntryModel extends FlutterFlowModel<EntryWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Custom Action - isBluetoothEnabled] action in Entry widget.
  bool? bluettothEnabled;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
