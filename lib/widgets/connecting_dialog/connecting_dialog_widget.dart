import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'connecting_dialog_model.dart';
export 'connecting_dialog_model.dart';

class ConnectingDialogWidget extends StatefulWidget {
  const ConnectingDialogWidget({
    Key? key,
    required this.isConnectingToDeviceLoading,
    required this.deviceName,
  }) : super(key: key);

  final bool? isConnectingToDeviceLoading;
  final String? deviceName;

  @override
  _ConnectingDialogWidgetState createState() => _ConnectingDialogWidgetState();
}

class _ConnectingDialogWidgetState extends State<ConnectingDialogWidget> {
  late ConnectingDialogModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConnectingDialogModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.00, 0.00),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 12),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 0.9,
          constraints: BoxConstraints(
            maxWidth: 530,
          ),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Color(0x33000000),
                offset: Offset(0, 1),
              )
            ],
            gradient: LinearGradient(
              colors: [
                Color(0xFF6354DD),
                FlutterFlowTheme.of(context).success,
                Color(0xFF353F49)
              ],
              stops: [0, 1, 1],
              begin: AlignmentDirectional(1, 0),
              end: AlignmentDirectional(-1, 0),
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                        child: Icon(
                          Icons.compare_arrows_rounded,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 50,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.00, 0.00),
                      child: Text(
                        'Connecting to device',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'DM Sans',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 18,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Text(
                  widget.deviceName!,
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                        fontFamily: 'DM Sans',
                        fontSize: 20,
                      ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.00, 0.00),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Text(
                    'Requesting device info, please wait...',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'DM Sans',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 16,
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
