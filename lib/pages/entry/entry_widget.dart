import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/permissions_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'entry_model.dart';
export 'entry_model.dart';

class EntryWidget extends StatefulWidget {
  const EntryWidget({Key? key}) : super(key: key);

  @override
  _EntryWidgetState createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {
  late EntryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EntryModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setDarkModeSetting(context, ThemeMode.dark);
      await requestPermission(bluetoothPermission);
      _model.bluettothEnabled = await actions.isBluetoothEnabled();
      if (Navigator.of(context).canPop()) {
        context.pop();
      }
      context.pushNamed(
        'Devices',
        queryParameters: {
          'isBTEnabled': serializeParam(
            _model.bluettothEnabled,
            ParamType.bool,
          ),
        }.withoutNulls,
      );
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Align(
            alignment: AlignmentDirectional(0.00, 0.00),
            child: Text(
              'WP Blutooth Scanner',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'DM Sans',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 22.0,
                  ),
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.00, 0.00),
                    child: Text(
                      'Fetching bluetooth status...',
                      style: FlutterFlowTheme.of(context).labelMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
