import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/widgets/empty_list/empty_list_widget.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'device_model.dart';
export 'device_model.dart';

class DeviceWidget extends StatefulWidget {
  const DeviceWidget({
    Key? key,
    required this.deviceName,
    required this.deviceId,
    required this.deviceRssi,
    required this.hasWriteCharacteristics,
    String? deviceType,
    required this.deviceConnectable,
  })  : this.deviceType = deviceType ?? 'device',
        super(key: key);

  final String? deviceName;
  final String? deviceId;
  final int? deviceRssi;
  final bool? hasWriteCharacteristics;
  final String deviceType;
  final bool? deviceConnectable;

  @override
  _DeviceWidgetState createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {
  late DeviceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeviceModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setDarkModeSetting(context, ThemeMode.dark);
      setState(() {
        _model.currentRssi = widget.deviceRssi;
      });

      _model.servicesInDevice = await actions.getDeviceServices(
        BTDevicesStruct(
          name: widget.deviceName,
          id: widget.deviceId,
          rssi: widget.deviceRssi,
          type: widget.deviceType,
          connectable: widget.deviceConnectable,
        ),
      );
      setState(() {
        _model.language = FFAppState().languageCode;
      });

      await actions.sendLanguageSetting(
        BTDevicesStruct(
          name: widget.deviceName,
          id: widget.deviceId,
          rssi: widget.deviceRssi,
        ),
        FFAppState().languageCode,
      );

      setState(() {
        _model.deviceServices =
            _model.servicesInDevice!.toList().cast<ServiceStruct>();
      });
      _model.rssiUpdateTimer = InstantTimer.periodic(
        duration: Duration(milliseconds: 5000),
        callback: (timer) async {
          _model.updatedRssi = await actions.getRssi(
            BTDevicesStruct(
              name: widget.deviceName,
              id: widget.deviceId,
              rssi: widget.deviceRssi,
            ),
          );
          // if (_model.updatedRssi == 100) {
          //   await showDialog(
          //     context: context,
          //     builder: (alertDialogContext) {
          //       return AlertDialog(
          //         title: Text('Disconnected'),
          //         content: Text(
          //             'The device is diconnected, scan again and reconnect to the device'),
          //         actions: [
          //           TextButton(
          //             onPressed: () => Navigator.pop(alertDialogContext),
          //             child: Text('Ok'),
          //           ),
          //         ],
          //       );
          //     },
          //   );
          //   context.safePop();
          // }
          setState(() {
            _model.currentRssi = _model.updatedRssi;
          });
        },
        startImmediately: true,
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
          title: Column(
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
                      widget.deviceName!,
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'DM Sans',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  if (widget.deviceRssi != null)
                    wrapWithModel(
                      model: _model.strengthIndicatorModel,
                      updateCallback: () => setState(() {}),
                      child: StrengthIndicatorWidget(
                        rssi: widget.deviceRssi!,
                        color: valueOrDefault<Color>(
                          () {
                            if (widget.deviceRssi! >= -90) {
                              return FlutterFlowTheme.of(context).success;
                            } else if (widget.deviceRssi! < -90) {
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
                  widget.deviceId!,
                  style: FlutterFlowTheme.of(context).labelSmall,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // CupertinoSlidingSegmentedControl(
                  //   children: {
                  //     'POR': Text(
                  //       'POR',
                  //       style: FlutterFlowTheme.of(context).bodySmall.override(
                  //             fontFamily: 'DM Sans',
                  //             color: FlutterFlowTheme.of(context).primaryText,
                  //           ),
                  //     ),
                  //     'ENG': Text(
                  //       'ENG',
                  //       style: FlutterFlowTheme.of(context).bodySmall.override(
                  //             fontFamily: 'DM Sans',
                  //             color: FlutterFlowTheme.of(context).primaryText,
                  //           ),
                  //     ),
                  //     'SPA': Text(
                  //       'SPA',
                  //       style: FlutterFlowTheme.of(context).bodySmall.override(
                  //             fontFamily: 'DM Sans',
                  //             color: FlutterFlowTheme.of(context).primaryText,
                  //           ),
                  //     ),
                  //   },
                  //   groupValue: FFAppState().languageCode,
                  //   onValueChanged: (newValue) async {
                  //     setState(() => _model.language = newValue!);
                  //     FFAppState().languageCode = newValue!;
                  //     await actions.sendLanguageSetting(
                  //       BTDevicesStruct(
                  //         name: widget.deviceName,
                  //         id: widget.deviceId,
                  //         rssi: widget.deviceRssi,
                  //       ),
                  //       FFAppState().languageCode,
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ],
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
                  if (functions.isSTC(widget.deviceName)! ||
                      functions.isSTS(widget.deviceName)!)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFAppState().languageCode == 'POR'
                                ? 'Dispositivo: '
                                : FFAppState().languageCode == 'ENG'
                                    ? 'Device: '
                                    : 'Dispositivo: ',
                            style:
                                FlutterFlowTheme.of(context).bodyLarge.override(
                                      fontFamily: 'DM Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 14.0,
                                    ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 8.0, 0.0),
                            child: Text(
                              () {
                                if (functions.isSTS(widget.deviceName)!) {
                                  return 'Solar Tracker Sensor';
                                } else if (functions
                                    .isSTC(widget.deviceName)!) {
                                  return 'Solar Tracker Controller';
                                } else {
                                  return 'Solar Tracker Modem';
                                }
                              }(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'DM Sans',
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    fontSize: 14.0,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (functions.isSTS(widget.deviceName)! ||
                      functions.isSTC(widget.deviceName)!)
                    Divider(
                      thickness: 1.0,
                      color: Color(0xFF353F49),
                    ),
                  if (functions.isSTS(widget.deviceName)! ||
                      functions.isSTC(widget.deviceName)!)
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            FFAppState().languageCode == 'POR'
                                ? 'Serviços: '
                                : FFAppState().languageCode == 'ENG'
                                    ? 'Services: '
                                    : 'Servicios: ',
                            style: FlutterFlowTheme.of(context).bodyLarge,
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              await actions.disconnectDevice(
                                BTDevicesStruct(
                                  name: widget.deviceName,
                                  id: widget.deviceId,
                                  rssi: _model.currentRssi,
                                ),
                              );
                              context.safePop();
                            },
                            text: FFAppState().languageCode == 'POR'
                                ? 'Desconectar'
                                : FFAppState().languageCode == 'ENG'
                                    ? 'Disconnect'
                                    : 'Desconectar',
                            icon: Icon(
                              Icons.bluetooth_disabled,
                              color: FlutterFlowTheme.of(context).error,
                              size: 24.0,
                            ),
                            options: FFButtonOptions(
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              textStyle: FlutterFlowTheme.of(context)
                                  .labelSmall
                                  .override(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          // Language selector
                        ],
                      ),
                    ),
                  if (functions.isSTS(widget.deviceName)! ||
                      functions.isSTC(widget.deviceName)!)
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(
                                    'LineStatus',
                                    queryParameters: {
                                      'nomeDispositivo': serializeParam(
                                        widget.deviceName,
                                        ParamType.String,
                                      ),
                                      'idDispositivo': serializeParam(
                                        widget.deviceId,
                                        ParamType.String,
                                      ),
                                      'rssi': serializeParam(
                                        widget.deviceRssi,
                                        ParamType.int,
                                      ),
                                      'type': serializeParam(
                                        widget.deviceType,
                                        ParamType.String,
                                      ),
                                      'serviceUUID': serializeParam(
                                        '6d98920a-905f-4c29-8322-b274154811ea',
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 200),
                                      ),
                                    },
                                  );
                                },
                                text: FFAppState().languageCode == 'POR'
                                    ? 'Status'
                                    : FFAppState().languageCode == 'ENG'
                                        ? 'Status'
                                        : 'Estado',
                                options: FFButtonOptions(
                                  height: 60.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      14.0, 0.0, 14.0, 0.0),
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
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(
                                    'DeviceInformation',
                                    queryParameters: {
                                      'nomeDispositivo': serializeParam(
                                        widget.deviceName,
                                        ParamType.String,
                                      ),
                                      'idDispositivo': serializeParam(
                                        widget.deviceId,
                                        ParamType.String,
                                      ),
                                      'rssi': serializeParam(
                                        widget.deviceRssi,
                                        ParamType.int,
                                      ),
                                      'type': serializeParam(
                                        widget.deviceType,
                                        ParamType.String,
                                      ),
                                      'serviceUUID': serializeParam(
                                        '54f3dec8-eae3-469c-89ed-4f1724858728',
                                        ParamType.String,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 200),
                                      ),
                                    },
                                  );
                                },
                                text: FFAppState().languageCode == 'POR'
                                    ? 'Configurações'
                                    : FFAppState().languageCode == 'ENG'
                                        ? 'Settings'
                                        : 'Configuraciones',
                                options: FFButtonOptions(
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  height: 60,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      14, 0, 14, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
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
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(width: 8.0)),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed(
                                      'GravarLocalization',
                                      queryParameters: {
                                        'nomeDispositivo': serializeParam(
                                          widget.deviceName,
                                          ParamType.String,
                                        ),
                                        'idDispositivo': serializeParam(
                                          widget.deviceId,
                                          ParamType.String,
                                        ),
                                        'rssiDispositivo': serializeParam(
                                          widget.deviceRssi,
                                          ParamType.int,
                                        ),
                                        'tipoDoDispositivo': serializeParam(
                                          widget.deviceType,
                                          ParamType.String,
                                        ),
                                        'conectable': serializeParam(
                                          widget.deviceConnectable,
                                          ParamType.bool,
                                        ),
                                        'serviceUUID': serializeParam(
                                          'bae55b96-7d19-458d-970c-50613d801bc9',
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.fade,
                                          duration: Duration(milliseconds: 200),
                                        ),
                                      },
                                    );
                                  },
                                  text: FFAppState().languageCode == 'POR'
                                      ? 'Sincronizar'
                                      : FFAppState().languageCode == 'ENG'
                                          ? 'Sync'
                                          : 'Sincronizar',
                                  icon: Icon(
                                    Icons.edit_location_alt_rounded,
                                    size: 24.0,
                                  ),
                                  options: FFButtonOptions(
                                    height: 60.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        14.0, 0.0, 14.0, 0.0),
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
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                ),
                              ),
                              if (functions.isSTC(widget.deviceName) ?? true)
                                Expanded(
                                  flex: 1,
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      context.pushNamed(
                                        'Motor',
                                        queryParameters: {
                                          'nomeDispositivo': serializeParam(
                                            widget.deviceName,
                                            ParamType.String,
                                          ),
                                          'idDispositivo': serializeParam(
                                            widget.deviceId,
                                            ParamType.String,
                                          ),
                                          'rssi': serializeParam(
                                            widget.deviceRssi,
                                            ParamType.int,
                                          ),
                                          'characteristicUUID': serializeParam(
                                            'b5b10c03-7f57-43bb-8451-5af4767a4459',
                                            ParamType.String,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                            duration:
                                                Duration(milliseconds: 200),
                                          ),
                                        },
                                      );
                                    },
                                    text: 'Motor',
                                    icon: Icon(
                                      Icons.settings_suggest,
                                      size: 24.0,
                                    ),
                                    options: FFButtonOptions(
                                      height: 60.0,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          18.0, 0.0, 18.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                  ),
                                ),
                            ].divide(SizedBox(width: 8.0)),
                          ),
                        ),
                      ],
                    ),
                  if ((functions.isSTC(widget.deviceName)! ||
                          functions.isSTS(widget.deviceName)!) &&
                      FFAppState().languageCode == "ENG")
                    Divider(
                      thickness: 1.5,
                      color: Color(0xFF353F49),
                    ),
                  if (FFAppState().languageCode == "ENG")
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Debug',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                  ),
                        ),
                        CupertinoSwitch(
                          value: _model.switchValue,
                          onChanged: (newValue) async {
                            setState(() => _model.switchValue = newValue);
                          },
                          activeColor: FlutterFlowTheme.of(context).primary,
                          trackColor: FlutterFlowTheme.of(context).alternate,
                          thumbColor: Colors.white
                              .withOpacity(_model.switchValue ? 1 : 0.5),
                        ),
                      ],
                    ),
                  if (_model.switchValue)
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 0.0),
                            child: Builder(
                              builder: (context) {
                                final servicesList =
                                    _model.deviceServices.toList();
                                if (servicesList.isEmpty) {
                                  return Center(
                                    child: Container(
                                      width: double.infinity,
                                      height: 50.0,
                                      child: EmptyListWidget(),
                                    ),
                                  );
                                }
                                return RefreshIndicator(
                                  onRefresh: () async {
                                    _model.servicesFromDevice =
                                        await actions.getDeviceServices(
                                      BTDevicesStruct(
                                        name: widget.deviceName,
                                        id: widget.deviceId,
                                        rssi: widget.deviceRssi,
                                        type: widget.deviceType,
                                        connectable: widget.deviceConnectable,
                                      ),
                                    );
                                    setState(() {
                                      _model.deviceServices = _model
                                          .servicesFromDevice!
                                          .toList()
                                          .cast<ServiceStruct>();
                                    });
                                  },
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: servicesList.length,
                                    itemBuilder: (context, servicesListIndex) {
                                      final servicesListItem =
                                          servicesList[servicesListIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 2.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              'ServiceCharacteristics',
                                              queryParameters: {
                                                'nomeDispositivo':
                                                    serializeParam(
                                                  widget.deviceName,
                                                  ParamType.String,
                                                ),
                                                'idDispositivo': serializeParam(
                                                  widget.deviceId,
                                                  ParamType.String,
                                                ),
                                                'rssiDispositivo':
                                                    serializeParam(
                                                  widget.deviceRssi,
                                                  ParamType.int,
                                                ),
                                                'serviceUuid': serializeParam(
                                                  servicesListItem.uuid,
                                                  ParamType.String,
                                                ),
                                                'serviceName': serializeParam(
                                                  servicesListItem.name,
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                            ),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 4.0,
                                                    color: Color(0x33000000),
                                                    offset: Offset(0.0, 2.0),
                                                  )
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                border: Border.all(
                                                  color: Color(0xFF353F49),
                                                  width: 1.5,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        12.0, 10.0, 12.0, 10.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                'Service name: ',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          8.0,
                                                                          0.0),
                                                              child: Text(
                                                                servicesListItem
                                                                    .name,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      3.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Text(
                                                                'Primary: ',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium,
                                                              ),
                                                              Text(
                                                                servicesListItem
                                                                    .primary
                                                                    .toString(),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                'uuid: ',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                servicesListItem
                                                                    .uuid,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'DM Sans',
                                                                      fontSize:
                                                                          13.0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 30.0,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
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
