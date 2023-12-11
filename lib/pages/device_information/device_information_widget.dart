import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_animations.dart';
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
import 'device_information_model.dart';
export 'device_information_model.dart';

class DeviceInformationWidget extends StatefulWidget {
  const DeviceInformationWidget({
    Key? key,
    required this.nomeDispositivo,
    required this.idDispositivo,
    int? rssi,
    String? type,
    String? serviceUUID,
  })  : this.rssi = rssi ?? 0,
        this.type = type ?? 'BLE',
        this.serviceUUID =
            serviceUUID ?? '54f3dec8-eae3-469c-89ed-4f1724858728',
        super(key: key);

  final String? nomeDispositivo;
  final String? idDispositivo;
  final int rssi;
  final String type;
  final String serviceUUID;

  @override
  _DeviceInformationWidgetState createState() =>
      _DeviceInformationWidgetState();
}

class _DeviceInformationWidgetState extends State<DeviceInformationWidget>
    with TickerProviderStateMixin {
  late DeviceInformationModel _model;

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
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeviceInformationModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.infoReadStart = await actions.getDeviceInfo(
        BTDevicesStruct(
          name: widget.nomeDispositivo,
          id: widget.idDispositivo,
          rssi: widget.rssi,
          type: widget.type,
          connectable: true,
        ),
        widget.nomeDispositivo!.startsWith("STC")
            ? "2eb141d5-a002-4b80-bd3e-950d2bb3e7f9"
            : widget.serviceUUID,
      );
      setState(() {
        _model.addToInfo(_model.infoReadStart);
        _model.currentInfo = _model.infoReadStart;
        _model.isFetching = true;
        _model.firstLoad = false;
      });
      while (_model.currentInfo != 'END') {
        _model.infoReadOnStreamStart = await actions.getDeviceInfo(
          BTDevicesStruct(
            name: widget.nomeDispositivo,
            id: widget.idDispositivo,
            rssi: widget.rssi,
            type: widget.type,
            connectable: true,
          ),
          widget.nomeDispositivo!.startsWith("STC")
              ? "2eb141d5-a002-4b80-bd3e-950d2bb3e7f9"
              : widget.serviceUUID,
        );
        if (_model.infoReadOnStreamStart != 'END') {
          setState(() {
            _model.addToInfo(_model.infoReadOnStreamStart);
            _model.currentInfo = _model.infoReadOnStreamStart;
          });
        } else {
          setState(() {
            _model.isFetching = false;
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

    context.watch<FFAppState>();

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
          title: Row(
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
                            rssi: widget.rssi,
                            color: valueOrDefault<Color>(
                              () {
                                if (widget.rssi >= -90) {
                                  return FlutterFlowTheme.of(context).success;
                                } else if (widget.rssi < -90) {
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
                          FFAppState().languageCode == 'POR'
                              ? 'Configurações'
                              : FFAppState().languageCode == 'ENG'
                                  ? 'Settings'
                                  : 'Configuraciones',
                          style: FlutterFlowTheme.of(context).bodyLarge,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                if (_model.info.length != 0) {
                                  setState(() {
                                    _model.info = [];
                                  });
                                }
                                _model.informationRead =
                                    await actions.getDeviceInfo(
                                  BTDevicesStruct(
                                    name: widget.nomeDispositivo,
                                    id: widget.idDispositivo,
                                    rssi: widget.rssi,
                                    type: widget.type,
                                    connectable: true,
                                  ),
                                  widget.nomeDispositivo!.startsWith("STC")
                                      ? "2eb141d5-a002-4b80-bd3e-950d2bb3e7f9"
                                      : widget.serviceUUID,
                                );
                                setState(() {
                                  _model.addToInfo(_model.informationRead!);
                                  _model.currentInfo = _model.informationRead!;
                                  _model.isFetching = true;
                                });
                                while (_model.currentInfo != 'END') {
                                  _model.infoReadOnStream =
                                      await actions.getDeviceInfo(
                                    BTDevicesStruct(
                                      name: widget.nomeDispositivo,
                                      id: widget.idDispositivo,
                                      rssi: widget.rssi,
                                      type: widget.type,
                                      connectable: true,
                                    ),
                                    widget.nomeDispositivo!.startsWith("STC")
                                        ? "2eb141d5-a002-4b80-bd3e-950d2bb3e7f9"
                                        : widget.serviceUUID,
                                  );
                                  if (_model.infoReadOnStream != 'END') {
                                    setState(() {
                                      _model
                                          .addToInfo(_model.infoReadOnStream!);
                                      _model.currentInfo =
                                          _model.infoReadOnStream!;
                                    });
                                  } else {
                                    setState(() {
                                      _model.isFetching = false;
                                    });
                                    break;
                                  }
                                }

                                setState(() {});
                              },
                              text: valueOrDefault<String>(
                                _model.info.length == 0
                                    ? FFAppState().languageCode == 'POR'
                                        ? 'Solicitar'
                                        : FFAppState().languageCode == 'ENG'
                                            ? 'Request'
                                            : 'Solicitar'
                                    : FFAppState().languageCode == 'POR'
                                        ? 'Atualizar'
                                        : FFAppState().languageCode == 'ENG'
                                            ? 'Update'
                                            : 'Actualizar',
                                'Solicitar',
                              ),
                              options: FFButtonOptions(
                                width: 120,
                                height: 32.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'DM Sans',
                                      color: Colors.white,
                                    ),
                                elevation: 3.0,
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
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
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            minHeight: 80.0,
                            maxHeight: 600.0,
                          ),
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
                              width: 1.5,
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_model.info.length == 0)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 10.0, 10.0),
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
                                                    : 'Sem Informação',
                                                'Sem Informação',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily: 'DM Sans',
                                                        fontSize: 20.0,
                                                      ),
                                            ),
                                            Text(
                                              'Pressione o botão de solicitação para \nreceber as informações do dispositivo.',
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
                                if (_model.info.length > 0)
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5.0, 10.0, 0.0, 10.0),
                                    child: wrapWithModel(
                                      model: _model.receiveDataMonoModel,
                                      updateCallback: () => setState(() {}),
                                      child: ReceiveDataMonoWidget(
                                        receivedData: _model.info,
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
