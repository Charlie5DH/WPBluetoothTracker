import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/widgets/received_data/received_data_widget.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'timestamp_model.dart';
export 'timestamp_model.dart';

class TimestampWidget extends StatefulWidget {
  const TimestampWidget({
    Key? key,
    required this.nomeDispositivo,
    required this.idDispositivo,
    required this.type,
    required this.serviceUUID,
    required this.rssi,
  }) : super(key: key);

  final String? nomeDispositivo;
  final String? idDispositivo;
  final String? type;
  final String? serviceUUID;
  final int? rssi;

  @override
  _TimestampWidgetState createState() => _TimestampWidgetState();
}

class _TimestampWidgetState extends State<TimestampWidget> {
  late TimestampModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TimestampModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.firstTimeReadTimestamp = await actions.getTimestampFromDevice(
        BTDevicesStruct(
          name: widget.nomeDispositivo,
          id: widget.idDispositivo,
          rssi: widget.rssi,
          type: widget.type,
          connectable: true,
        ),
        widget.serviceUUID,
      );
      setState(() {
        _model.currentTimestamp = _model.firstTimeReadTimestamp!;
        _model.addToTimestampHistory(_model.firstTimeReadTimestamp!);
      });
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
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                        child: Text(
                          widget.nomeDispositivo!,
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'DM Sans',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      if (widget.rssi != null)
                        wrapWithModel(
                          model: _model.strengthIndicatorModel,
                          updateCallback: () => setState(() {}),
                          child: StrengthIndicatorWidget(
                            rssi: widget.rssi!,
                            color: valueOrDefault<Color>(
                              () {
                                if (widget.rssi! >= -90) {
                                  return FlutterFlowTheme.of(context).success;
                                } else if (widget.rssi! < -90) {
                                  return FlutterFlowTheme.of(context).tertiary;
                                } else {
                                  return FlutterFlowTheme.of(context).error;
                                }
                              }(),
                              FlutterFlowTheme.of(context).success,
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                    child: Text(
                      widget.idDispositivo!,
                      style: FlutterFlowTheme.of(context).labelSmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Timestamp service',
                          style: FlutterFlowTheme.of(context).bodyLarge,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Leia o timestamp no dispositivo.\nVocê pode solicitar linha por linha ou um stream',
                          style: FlutterFlowTheme.of(context).labelMedium,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.2,
                    color: Color(0xFF353F49),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                    child: Text(
                      'Timestamp atual do dispositivo',
                      style: FlutterFlowTheme.of(context).bodyLarge,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.7,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).alternate,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x33000000),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(
                            color: Color(0xFF353F49),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.00, 0.00),
                                  child: Text(
                                    valueOrDefault<String>(
                                      _model.currentTimestamp,
                                      'requesting...',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Histórico:',
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                                fontFamily: 'DM Sans',
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.2,
                    color: Color(0xFF353F49),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (widget.serviceUUID !=
                                '6d98920a-905f-4c29-8322-b274154811ea')
                              FFButtonWidget(
                                onPressed: () async {
                                  _model.readTimeStreamFirst =
                                      await actions.getTimestampFromDevice(
                                    BTDevicesStruct(
                                      name: widget.nomeDispositivo,
                                      id: widget.idDispositivo,
                                      rssi: widget.rssi,
                                      type: widget.type,
                                      connectable: true,
                                    ),
                                    widget.serviceUUID,
                                  );
                                  setState(() {
                                    _model.currentTimestamp =
                                        _model.readTimeStreamFirst!;
                                    _model.addToTimestampHistory(
                                        _model.readTimeStreamFirst!);
                                    _model.reading = true;
                                  });
                                  while ((_model.currentTimestamp != 'END') &&
                                      _model.reading) {
                                    await Future.delayed(
                                        const Duration(milliseconds: 500));
                                    _model.readTimeStream =
                                        await actions.getTimestampFromDevice(
                                      BTDevicesStruct(
                                        name: widget.nomeDispositivo,
                                        id: widget.idDispositivo,
                                        rssi: widget.rssi,
                                        type: widget.type,
                                        connectable: true,
                                      ),
                                      widget.serviceUUID,
                                    );
                                    setState(() {
                                      _model.currentTimestamp =
                                          _model.readTimeStream!;
                                      _model.addToTimestampHistory(
                                          _model.readTimeStream!);
                                    });
                                  }

                                  setState(() {});
                                },
                                text: 'Read Stream',
                                options: FFButtonOptions(
                                  height: 32.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 5.0, 12.0, 5.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'DM Sans',
                                        color: Colors.white,
                                        fontSize: 13.0,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color: Color(0xFF353F49),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            FFButtonWidget(
                              onPressed: () async {
                                _model.streamTimestampLine =
                                    await actions.getTimestampFromDevice(
                                  BTDevicesStruct(
                                    name: widget.nomeDispositivo,
                                    id: widget.idDispositivo,
                                    rssi: widget.rssi,
                                    type: widget.type,
                                    connectable: true,
                                  ),
                                  widget.serviceUUID,
                                );
                                setState(() {
                                  _model.currentTimestamp =
                                      _model.streamTimestampLine!;
                                  _model.addToTimestampHistory(
                                      _model.streamTimestampLine!);
                                });

                                setState(() {});
                              },
                              text: 'Read Line',
                              options: FFButtonOptions(
                                height: 32.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 5.0, 12.0, 5.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'DM Sans',
                                      color: Colors.white,
                                      fontSize: 13.0,
                                    ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: Color(0xFF353F49),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ].divide(SizedBox(width: 8.0)),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (_model.reading == true)
                              FFButtonWidget(
                                onPressed: () async {
                                  setState(() {
                                    _model.reading = false;
                                  });
                                },
                                text: 'stop',
                                options: FFButtonOptions(
                                  height: 32.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      12.0, 5.0, 12.0, 5.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: Color(0xFFDD8763),
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'DM Sans',
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                  elevation: 3.0,
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            FFButtonWidget(
                              onPressed: () async {
                                setState(() {
                                  _model.timestampHistory = [];
                                });
                              },
                              text: 'Clear',
                              icon: Icon(
                                Icons.clear,
                                size: 16.0,
                              ),
                              options: FFButtonOptions(
                                height: 32.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    12.0, 5.0, 12.0, 5.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'DM Sans',
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: Color(0xFF353F49),
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ].divide(SizedBox(width: 5.0)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(6.0, 6.0, 6.0, 6.0),
                    child: wrapWithModel(
                      model: _model.receivedDataModel,
                      updateCallback: () => setState(() {}),
                      child: ReceivedDataWidget(
                        receivedData: _model.timestampHistory,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
