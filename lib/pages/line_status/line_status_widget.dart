import 'package:flutter/scheduler.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/widgets/receive_data_mono/receive_data_mono_widget.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '/flutter_flow/flutter_flow_animations.dart';

import 'line_status_model.dart';
export 'line_status_model.dart';

class LineStatusWidget extends StatefulWidget {
  const LineStatusWidget({
    Key? key,
    required this.nomeDispositivo,
    required this.idDispositivo,
    required this.rssi,
    required this.type,
    required this.serviceUUID,
  }) : super(key: key);

  final String? nomeDispositivo;
  final String? idDispositivo;
  final int? rssi;
  final String? type;
  final String? serviceUUID;

  @override
  _LineStatusWidgetState createState() => _LineStatusWidgetState();
}

class _LineStatusWidgetState extends State<LineStatusWidget> {
  late LineStatusModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'iconOnPageLoadAnimation': AnimationInfo(
      loop: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        RotateEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
    'textOnPageLoadAnimation': AnimationInfo(
      loop: true,
      reverse: true,
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: 0.5,
          end: 1,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LineStatusModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.lineStatusReadStart = await actions.getLineStatus(
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
        _model.addToMeasures(_model.lineStatusReadStart);
        _model.currentMeasure = _model.lineStatusReadStart;
        _model.isFetchingStatus = true;
        _model.firstLoad = false;
      });
      while (_model.currentMeasure != 'END') {
        _model.lineStatusReadOnStreamStart = await actions.getLineStatus(
          BTDevicesStruct(
            name: widget.nomeDispositivo,
            id: widget.idDispositivo,
            rssi: widget.rssi,
            type: widget.type,
            connectable: true,
          ),
          widget.serviceUUID,
        );
        if (_model.lineStatusReadOnStreamStart != 'END') {
          setState(() {
            _model.addToMeasures(_model.lineStatusReadOnStreamStart);
            _model.currentMeasure = _model.lineStatusReadOnStreamStart;
          });
        } else {
          setState(() {
            _model.isFetchingStatus = false;
            _model.firstLoad = false;
          });
          break;
        }
      }
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
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30,
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                        child: Text(
                          widget.nomeDispositivo!,
                          style:
                              FlutterFlowTheme.of(context).titleLarge.override(
                                    fontFamily: 'DM Sans',
                                    fontSize: 16,
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
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
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
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Line status service',
                          style: FlutterFlowTheme.of(context).bodyLarge,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                if (_model.measures.length != 0) {
                                  setState(() {
                                    _model.measures = [];
                                  });
                                }
                                _model.lineStatusRead =
                                    await actions.getLineStatus(
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
                                  _model.addToMeasures(_model.lineStatusRead!);
                                  _model.currentMeasure =
                                      _model.lineStatusRead!;
                                  _model.isFetchingStatus = true;
                                });
                                while (_model.currentMeasure != 'END') {
                                  _model.lineStatusReadOnStream =
                                      await actions.getLineStatus(
                                    BTDevicesStruct(
                                      name: widget.nomeDispositivo,
                                      id: widget.idDispositivo,
                                      rssi: widget.rssi,
                                      type: widget.type,
                                      connectable: true,
                                    ),
                                    widget.serviceUUID,
                                  );
                                  if (_model.lineStatusReadOnStream != 'END') {
                                    setState(() {
                                      _model.addToMeasures(
                                          _model.lineStatusReadOnStream!);
                                      _model.currentMeasure =
                                          _model.lineStatusReadOnStream!;
                                    });
                                  } else {
                                    setState(() {
                                      _model.isFetchingStatus = false;
                                    });
                                    break;
                                  }
                                }

                                setState(() {});
                              },
                              text: valueOrDefault<String>(
                                _model.measures.length == 0
                                    ? 'Solicitar'
                                    : 'Atualizar',
                                'Solicitar',
                              ),
                              icon: Icon(
                                Icons.refresh_outlined,
                                size: 20,
                              ),
                              options: FFButtonOptions(
                                width: 120,
                                height: 32,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16, 0, 16, 0),
                                iconPadding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'DM Sans',
                                      color: Colors.white,
                                    ),
                                elevation: 3,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 1.2,
                      color: Color(0xFF353F49),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight: 120,
                            maxHeight: 600,
                          ),
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: Color(0xFF353F49),
                              width: 1.5,
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_model.measures.length == 0)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 10, 10, 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              valueOrDefault<String>(
                                                _model.firstLoad
                                                    ? 'Solicitando...'
                                                    : 'Sem Medidas',
                                                'Sem Medidas',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily: 'DM Sans',
                                                        fontSize: 20,
                                                      ),
                                            ),
                                            Text(
                                              'Pressione o botão de solicitação para \nreceber as medidas',
                                              textAlign: TextAlign.center,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                if (_model.measures.length > 0)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 10, 0, 10),
                                    child: wrapWithModel(
                                      model: _model.receiveDataMonoModel,
                                      updateCallback: () => setState(() {}),
                                      child: ReceiveDataMonoWidget(
                                        receivedData: _model.measures,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
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
    );
  }
}
