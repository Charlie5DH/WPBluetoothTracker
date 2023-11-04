import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/widgets/empty_list/empty_list_widget.dart';
import '/widgets/received_data/received_data_widget.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'service_characteristics_model.dart';
export 'service_characteristics_model.dart';

class ServiceCharacteristicsWidget extends StatefulWidget {
  const ServiceCharacteristicsWidget({
    Key? key,
    required this.nomeDispositivo,
    required this.idDispositivo,
    required this.rssiDispositivo,
    required this.serviceUuid,
    required this.serviceName,
  }) : super(key: key);

  final String? nomeDispositivo;
  final String? idDispositivo;
  final int? rssiDispositivo;
  final String? serviceUuid;
  final String? serviceName;

  @override
  _ServiceCharacteristicsWidgetState createState() =>
      _ServiceCharacteristicsWidgetState();
}

class _ServiceCharacteristicsWidgetState
    extends State<ServiceCharacteristicsWidget> {
  late ServiceCharacteristicsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ServiceCharacteristicsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.service = await actions.getServiceCharacteristics(
        BTDevicesStruct(
          name: widget.nomeDispositivo,
          id: widget.idDispositivo,
          rssi: widget.rssiDispositivo,
          type: 'null',
          connectable: true,
        ),
        widget.serviceUuid,
      );
      setState(() {
        _model.serviceCharacteristics = _model.service;
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
                      if (widget.rssiDispositivo != null)
                        wrapWithModel(
                          model: _model.strengthIndicatorModel,
                          updateCallback: () => setState(() {}),
                          child: StrengthIndicatorWidget(
                            rssi: widget.rssiDispositivo!,
                            color: valueOrDefault<Color>(
                              () {
                                if (widget.rssiDispositivo! >= -90) {
                                  return FlutterFlowTheme.of(context).success;
                                } else if (widget.rssiDispositivo! < -90) {
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
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'DM Sans',
                            fontSize: 13.0,
                          ),
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        widget.serviceName!,
                        style: FlutterFlowTheme.of(context).bodyLarge,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                    color: Color(0xFF353F49),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        widget.serviceUuid!,
                        style: FlutterFlowTheme.of(context).labelMedium,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Primary: ',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                        Text(
                          valueOrDefault<String>(
                            _model.serviceCharacteristics?.primary?.toString(),
                            'False',
                          ),
                          style: FlutterFlowTheme.of(context).labelMedium,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: Color(0xFF353F49),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Characteristics:',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'DM Sans',
                                    fontSize: 16.0,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Builder(
                          builder: (context) {
                            final characteristicsList = _model
                                    .serviceCharacteristics
                                    ?.bluetoothCharacteristic
                                    ?.toList() ??
                                [];
                            if (characteristicsList.isEmpty) {
                              return Center(
                                child: Container(
                                  width: double.infinity,
                                  height: 50.0,
                                  child: EmptyListWidget(),
                                ),
                              );
                            }
                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: characteristicsList.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 10.0),
                              itemBuilder: (context, characteristicsListIndex) {
                                final characteristicsListItem =
                                    characteristicsList[
                                        characteristicsListIndex];
                                return Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 2.0),
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 0.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
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
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      12.0, 12.0, 12.0, 12.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 8.0),
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
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                'Characteristic UUID:',
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
                                                                characteristicsListItem
                                                                    .uuid,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 2.0),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      elevation: 0.0,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.0),
                                                      ),
                                                      child: Container(
                                                        width: double.infinity,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 4.0,
                                                              color: Color(
                                                                  0x33000000),
                                                              offset: Offset(
                                                                  0.0, 2.0),
                                                            )
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      6.0),
                                                          border: Border.all(
                                                            color: Color(
                                                                0xFF353F49),
                                                            width: 1.5,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      8.0,
                                                                      8.0,
                                                                      8.0,
                                                                      8.0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        'Read: ',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium,
                                                                      ),
                                                                      Text(
                                                                        characteristicsListItem
                                                                            .properties
                                                                            .read
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelMedium,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider(
                                                                thickness: 1.0,
                                                                color: Color(
                                                                    0xFF353F49),
                                                              ),
                                                              Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        'Write: ',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium,
                                                                      ),
                                                                      Text(
                                                                        characteristicsListItem
                                                                            .properties
                                                                            .write
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .labelMedium,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  if (characteristicsListItem
                                                                          .properties
                                                                          .write ==
                                                                      true)
                                                                    FFButtonWidget(
                                                                      onPressed:
                                                                          () {
                                                                        print(
                                                                            'Button pressed ...');
                                                                      },
                                                                      text:
                                                                          'Write',
                                                                      options:
                                                                          FFButtonOptions(
                                                                        height:
                                                                            32.0,
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            22.0,
                                                                            0.0,
                                                                            22.0,
                                                                            0.0),
                                                                        iconPadding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        textStyle: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              fontFamily: 'DM Sans',
                                                                              color: Colors.white,
                                                                              fontSize: 14.0,
                                                                            ),
                                                                        elevation:
                                                                            3.0,
                                                                        borderSide:
                                                                            BorderSide(
                                                                          color:
                                                                              Colors.transparent,
                                                                          width:
                                                                              1.0,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
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
                                                  Divider(
                                                    thickness: 1.0,
                                                    color: Color(0xFF353F49),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 5.0),
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
                                                          children: [
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          2.0),
                                                                  child: Text(
                                                                    'Descriptors: ',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Builder(
                                                    builder: (context) {
                                                      final descriptorsList =
                                                          characteristicsListItem
                                                              .descriptors
                                                              .toList();
                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        physics:
                                                            ClampingScrollPhysics(),
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            descriptorsList
                                                                .length,
                                                        itemBuilder: (context,
                                                            descriptorsListIndex) {
                                                          final descriptorsListItem =
                                                              descriptorsList[
                                                                  descriptorsListIndex];
                                                          return Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        2.0),
                                                            child: Material(
                                                              color: Colors
                                                                  .transparent,
                                                              elevation: 0.0,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            6.0),
                                                              ),
                                                              child: Container(
                                                                width: double
                                                                    .infinity,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      blurRadius:
                                                                          4.0,
                                                                      color: Color(
                                                                          0x33000000),
                                                                      offset: Offset(
                                                                          0.0,
                                                                          2.0),
                                                                    )
                                                                  ],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: Color(
                                                                        0xFF353F49),
                                                                    width: 1.5,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          8.0,
                                                                          8.0,
                                                                          8.0,
                                                                          8.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Text(
                                                                            'UUID: ',
                                                                            style:
                                                                                FlutterFlowTheme.of(context).bodyMedium,
                                                                          ),
                                                                          Text(
                                                                            descriptorsListItem.uuid,
                                                                            style: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                  fontFamily: 'DM Sans',
                                                                                  fontSize: 13.0,
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
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  Divider(
                                                    thickness: 1.2,
                                                    color: Color(0xFF353F49),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 10.0,
                                                                0.0, 0.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Received data',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .titleMedium
                                                              .override(
                                                                fontFamily:
                                                                    'DM Sans',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                0.0, 5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            if (widget
                                                                    .serviceUuid !=
                                                                '6d98920a-905f-4c29-8322-b274154811ea')
                                                              FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  _model.readFirstValue =
                                                                      await actions
                                                                          .readFromCharacteristic(
                                                                    BTDevicesStruct(
                                                                      name: widget
                                                                          .nomeDispositivo,
                                                                      id: widget
                                                                          .idDispositivo,
                                                                      rssi: widget
                                                                          .rssiDispositivo,
                                                                      type:
                                                                          'null',
                                                                      connectable:
                                                                          true,
                                                                    ),
                                                                    widget
                                                                        .serviceUuid,
                                                                    characteristicsListItem
                                                                        .uuid,
                                                                  );
                                                                  setState(() {
                                                                    _model.addToReceivedValues(
                                                                        _model
                                                                            .readFirstValue!);
                                                                    _model.currentValueRead =
                                                                        _model
                                                                            .readFirstValue!;
                                                                  });
                                                                  while (_model
                                                                          .currentValueRead !=
                                                                      'END') {
                                                                    await Future.delayed(const Duration(
                                                                        milliseconds:
                                                                            500));
                                                                    _model.readValueOnStream =
                                                                        await actions
                                                                            .readFromCharacteristic(
                                                                      BTDevicesStruct(
                                                                        name: widget
                                                                            .nomeDispositivo,
                                                                        id: widget
                                                                            .idDispositivo,
                                                                        rssi: widget
                                                                            .rssiDispositivo,
                                                                        type:
                                                                            'null',
                                                                        connectable:
                                                                            true,
                                                                      ),
                                                                      widget
                                                                          .serviceUuid,
                                                                      characteristicsListItem
                                                                          .uuid,
                                                                    );
                                                                    setState(
                                                                        () {
                                                                      _model.addToReceivedValues(
                                                                          _model
                                                                              .readValueOnStream!);
                                                                      _model.currentValueRead =
                                                                          _model
                                                                              .readValueOnStream!;
                                                                    });
                                                                  }

                                                                  setState(
                                                                      () {});
                                                                },
                                                                text:
                                                                    'Read Stream',
                                                                options:
                                                                    FFButtonOptions(
                                                                  height: 32.0,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          12.0,
                                                                          5.0,
                                                                          12.0,
                                                                          5.0),
                                                                  iconPadding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .success,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'DM Sans',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            13.0,
                                                                      ),
                                                                  elevation:
                                                                      3.0,
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFF353F49),
                                                                    width: 1.0,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20.0),
                                                                ),
                                                              ),
                                                            FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                _model.readValue =
                                                                    await actions
                                                                        .readFromCharacteristic(
                                                                  BTDevicesStruct(
                                                                    name: widget
                                                                        .nomeDispositivo,
                                                                    id: widget
                                                                        .idDispositivo,
                                                                    rssi: widget
                                                                        .rssiDispositivo,
                                                                    type:
                                                                        'null',
                                                                    connectable:
                                                                        true,
                                                                  ),
                                                                  widget
                                                                      .serviceUuid,
                                                                  characteristicsListItem
                                                                      .uuid,
                                                                );
                                                                setState(() {
                                                                  _model.addToReceivedValues(
                                                                      _model
                                                                          .readValue!);
                                                                });

                                                                setState(() {});
                                                              },
                                                              text: 'Read Line',
                                                              options:
                                                                  FFButtonOptions(
                                                                height: 32.0,
                                                                padding: EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        5.0,
                                                                        12.0,
                                                                        5.0),
                                                                iconPadding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'DM Sans',
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          13.0,
                                                                    ),
                                                                elevation: 3.0,
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color(
                                                                      0xFF353F49),
                                                                  width: 1.0,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20.0),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              width: 10.0)),
                                                        ),
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            setState(() {
                                                              _model.receivedValues =
                                                                  [];
                                                            });
                                                          },
                                                          text: 'Clear',
                                                          icon: Icon(
                                                            Icons.clear,
                                                            size: 16.0,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            height: 32.0,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12.0,
                                                                        5.0,
                                                                        12.0,
                                                                        5.0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .alternate,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'DM Sans',
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14.0,
                                                                    ),
                                                            elevation: 3.0,
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color(
                                                                  0xFF353F49),
                                                              width: 1.0,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 5.0)),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 1.2,
                                                    color: Color(0xFF353F49),
                                                  ),
                                                  wrapWithModel(
                                                    model: _model
                                                        .receivedDataModels
                                                        .getModel(
                                                      characteristicsListIndex
                                                          .toString(),
                                                      characteristicsListIndex,
                                                    ),
                                                    updateCallback: () =>
                                                        setState(() {}),
                                                    child: ReceivedDataWidget(
                                                      key: Key(
                                                        'Keyvzv_${characteristicsListIndex.toString()}',
                                                      ),
                                                      receivedData:
                                                          _model.receivedValues,
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
                                );
                              },
                            );
                          },
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
    );
  }
}
