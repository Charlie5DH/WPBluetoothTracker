import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'searchbutton_model.dart';
export 'searchbutton_model.dart';

class SearchbuttonWidget extends StatefulWidget {
  const SearchbuttonWidget({Key? key}) : super(key: key);

  @override
  _SearchbuttonWidgetState createState() => _SearchbuttonWidgetState();
}

class _SearchbuttonWidgetState extends State<SearchbuttonWidget> {
  late SearchbuttonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchbuttonModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterFlowIconButton(
      borderColor: FlutterFlowTheme.of(context).alternate,
      borderRadius: 10.0,
      borderWidth: 2.0,
      buttonSize: 50.0,
      fillColor: FlutterFlowTheme.of(context).primaryBackground,
      icon: Icon(
        Icons.manage_search,
        color: FlutterFlowTheme.of(context).primaryText,
        size: 24.0,
      ),
      onPressed: () {
        print('IconButton pressed ...');
      },
    );
  }
}
