import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/instant_timer.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'motor_model.dart';
export 'motor_model.dart';

class MotorWidget extends StatefulWidget {
  const MotorWidget({
    Key? key,
    required this.nomeDispositivo,
    required this.idDispositivo,
    required this.rssi,
    required this.characteristicUUID,
  }) : super(key: key);

  final String? nomeDispositivo;
  final String? idDispositivo;
  final int? rssi;
  final String? characteristicUUID;

  @override
  _MotorWidgetState createState() => _MotorWidgetState();
}

class _MotorWidgetState extends State<MotorWidget> {
  late MotorModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MotorModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.instantTimer = InstantTimer.periodic(
        duration: Duration(milliseconds: 5000),
        callback: (timer) async {
          _model.readAngle = await actions.readMotorAngle(
            BTDevicesStruct(
              name: widget.nomeDispositivo,
              id: widget.idDispositivo,
              rssi: widget.rssi,
              type: 'STC',
              connectable: true,
            ),
            widget.characteristicUUID,
          );
          setState(() {
            _model.currentAngle = _model.readAngle!;
          });
        },
        startImmediately: true,
      );
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
                          valueOrDefault<String>(
                            widget.nomeDispositivo,
                            'Unknown',
                          ),
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
                      valueOrDefault<String>(
                        widget.idDispositivo,
                        'unknown',
                      ),
                      style: FlutterFlowTheme.of(context).labelSmall,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Ângulo atual do motor',
                  style: FlutterFlowTheme.of(context).bodyLarge,
                ),
                Text(
                  'Pressione o botão para atualizar',
                  style: FlutterFlowTheme.of(context).labelMedium,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      _model.readAngleUpdated = await actions.readMotorAngle(
                        BTDevicesStruct(
                          name: widget.nomeDispositivo,
                          id: widget.idDispositivo,
                          rssi: widget.rssi,
                          type: 'STC',
                          connectable: true,
                        ),
                        widget.characteristicUUID,
                      );
                      setState(() {
                        _model.currentAngle = _model.readAngleUpdated!;
                      });

                      setState(() {});
                    },
                    child: Material(
                      color: Colors.transparent,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.5,
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
                                      _model.currentAngle,
                                      'requesting...',
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 0.0, 14.0),
                                  child: Icon(
                                    Icons.circle_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    size: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 6.0),
                      child: Text(
                        'Movimente o motor do tracker selecionando a direção',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'DM Sans',
                                  fontSize: 14.0,
                                  lineHeight: 1.4,
                                ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1.5,
                  color: FlutterFlowTheme.of(context).alternate,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              setState(() {
                                _model.selectedAngle = 'East';
                                _model.writeAngleValue = 101;
                              });
                            },
                            text: 'East',
                            options: FFButtonOptions(
                              height: 32.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 20.0, 10.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: _model.selectedAngle == 'East'
                                  ? FlutterFlowTheme.of(context).success
                                  : FlutterFlowTheme.of(context).alternate,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w500,
                                  ),
                              elevation: 5.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              setState(() {
                                _model.selectedAngle = 'Zero';
                                _model.writeAngleValue = 100;
                              });
                            },
                            text: 'Zero',
                            options: FFButtonOptions(
                              height: 32.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 20.0, 10.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: _model.selectedAngle == 'Zero'
                                  ? FlutterFlowTheme.of(context).success
                                  : FlutterFlowTheme.of(context).alternate,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'DM Sans',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              elevation: 5.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              setState(() {
                                _model.selectedAngle = 'West';
                                _model.writeAngleValue = 102;
                              });
                            },
                            text: 'West',
                            options: FFButtonOptions(
                              height: 32.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 20.0, 10.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: _model.selectedAngle == 'West'
                                  ? FlutterFlowTheme.of(context).success
                                  : FlutterFlowTheme.of(context).alternate,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'DM Sans',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              elevation: 5.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ].divide(SizedBox(width: 30.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              setState(() {
                                _model.selectedAngle = 'Clean east';
                                _model.writeAngleValue = 103;
                              });
                            },
                            text: 'Clean east',
                            options: FFButtonOptions(
                              height: 32.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 20.0, 10.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: _model.selectedAngle == 'Clean east'
                                  ? FlutterFlowTheme.of(context).success
                                  : FlutterFlowTheme.of(context).alternate,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'DM Sans',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              elevation: 5.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              setState(() {
                                _model.selectedAngle = 'Clean west';
                                _model.writeAngleValue = 104;
                              });
                            },
                            text: 'Clean west',
                            options: FFButtonOptions(
                              height: 32.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 20.0, 10.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: _model.selectedAngle == 'Clean west'
                                  ? FlutterFlowTheme.of(context).success
                                  : FlutterFlowTheme.of(context).alternate,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'DM Sans',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              elevation: 5.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ].divide(SizedBox(width: 15.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              setState(() {
                                _model.selectedAngle = 'Rest';
                                _model.writeAngleValue = 105;
                              });
                            },
                            text: 'Rest',
                            options: FFButtonOptions(
                              height: 32.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 20.0, 10.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: _model.selectedAngle == 'Rest'
                                  ? FlutterFlowTheme.of(context).success
                                  : FlutterFlowTheme.of(context).alternate,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'DM Sans',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              elevation: 5.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              setState(() {
                                _model.selectedAngle = 'Storm';
                                _model.writeAngleValue = 106;
                              });
                            },
                            text: 'Storm',
                            options: FFButtonOptions(
                              height: 32.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 20.0, 10.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: _model.selectedAngle == 'Storm'
                                  ? FlutterFlowTheme.of(context).success
                                  : FlutterFlowTheme.of(context).alternate,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'DM Sans',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              elevation: 5.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ].divide(SizedBox(width: 12.0)),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              setState(() {
                                _model.selectedAngle = 'Custom';
                              });
                            },
                            text: 'Custom',
                            options: FFButtonOptions(
                              height: 32.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  20.0, 10.0, 20.0, 10.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: _model.selectedAngle == 'Custom'
                                  ? FlutterFlowTheme.of(context).success
                                  : FlutterFlowTheme.of(context).alternate,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'DM Sans',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              elevation: 5.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ].divide(SizedBox(width: 10.0)),
                      ),
                    ].divide(SizedBox(height: 14.0)),
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: FlutterFlowTheme.of(context).alternate,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selecione um valor entre -55 e 55',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'DM Sans',
                                  fontSize: 14.0,
                                  lineHeight: 1.4,
                                ),
                      ),
                      if (_model.selectedAngle == 'Custom')
                        Text(
                          valueOrDefault<String>(
                            _model.sliderValue?.toString(),
                            '0',
                          ),
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'DM Sans',
                                    fontSize: 14.0,
                                    lineHeight: 1.4,
                                  ),
                        ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '-55',
                                style: FlutterFlowTheme.of(context).labelMedium,
                              ),
                              Text(
                                'West',
                                style: FlutterFlowTheme.of(context).labelMedium,
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
                              child: Slider(
                                activeColor:
                                    FlutterFlowTheme.of(context).primary,
                                inactiveColor:
                                    FlutterFlowTheme.of(context).alternate,
                                min: -55.0,
                                max: 55.0,
                                value: _model.sliderValue ??= 0.0,
                                label: _model.sliderValue.toString(),
                                divisions: 55,
                                onChanged: _model.selectedAngle != 'Custom'
                                    ? null
                                    : (newValue) {
                                        newValue = double.parse(
                                            newValue.toStringAsFixed(1));
                                        setState(() =>
                                            _model.sliderValue = newValue);
                                      },
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '+55',
                                style: FlutterFlowTheme.of(context).labelMedium,
                              ),
                              Text(
                                'East',
                                style: FlutterFlowTheme.of(context).labelMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.5,
                  color: FlutterFlowTheme.of(context).alternate,
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(0.00, 1.00),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          var _shouldSetState = false;
                          if (_model.selectedAngle == 'Custom') {
                            if ((_model.sliderValue! >= -55.0) &&
                                (_model.sliderValue! <= 55.0)) {
                              await actions.writeMotorAngle(
                                BTDevicesStruct(
                                  name: widget.nomeDispositivo,
                                  id: widget.idDispositivo,
                                  rssi: widget.rssi,
                                  type: 'STC',
                                  connectable: true,
                                ),
                                valueOrDefault<String>(
                                  _model.sliderValue?.toString(),
                                  '0',
                                ),
                                widget.characteristicUUID,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Data sent to STC',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'DM Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  duration: Duration(milliseconds: 3000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Angle must be between -55 and 55. Fail!!!',
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'DM Sans',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  duration: Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).error,
                                ),
                              );
                              if (_shouldSetState) setState(() {});
                              return;
                            }
                          } else {
                            await actions.writeMotorAngle(
                              BTDevicesStruct(
                                name: widget.nomeDispositivo,
                                id: widget.idDispositivo,
                                rssi: widget.rssi,
                                type: 'STC',
                                connectable: true,
                              ),
                              valueOrDefault<String>(
                                _model.writeAngleValue?.toString(),
                                '0',
                              ),
                              widget.characteristicUUID,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Data sent to STC',
                                  style: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .override(
                                        fontFamily: 'DM Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                duration: Duration(milliseconds: 3000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).secondary,
                              ),
                            );
                          }

                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          _model.readAngleUpdatedAfterWrite =
                              await actions.readMotorAngle(
                            BTDevicesStruct(
                              name: widget.nomeDispositivo,
                              id: widget.idDispositivo,
                              rssi: widget.rssi,
                              type: 'STC',
                              connectable: true,
                            ),
                            widget.characteristicUUID,
                          );
                          _shouldSetState = true;
                          setState(() {
                            _model.currentAngle =
                                _model.readAngleUpdatedAfterWrite!;
                          });
                          if (_shouldSetState) setState(() {});
                        },
                        text: 'Acionar',
                        options: FFButtonOptions(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          height: 42.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              24.0, 0.0, 24.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
