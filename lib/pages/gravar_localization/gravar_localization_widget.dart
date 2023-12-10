import 'package:bluetooth_w_p/flutter_flow/custom_functions.dart';
import 'package:bluetooth_w_p/flutter_flow/flutter_flow_animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'gravar_localization_model.dart';
import '/widgets/confirm_localization/confirm_localization_widget.dart';
export 'gravar_localization_model.dart';

class GravarLocalizationWidget extends StatefulWidget {
  const GravarLocalizationWidget({
    Key? key,
    required this.nomeDispositivo,
    required this.idDispositivo,
    required this.rssiDispositivo,
    required this.tipoDoDispositivo,
    required this.conectable,
    required this.serviceUUID,
  }) : super(key: key);

  final String? nomeDispositivo;
  final String? idDispositivo;
  final int? rssiDispositivo;
  final String? tipoDoDispositivo;
  final bool? conectable;
  final String? serviceUUID;

  @override
  _GravarLocalizationWidgetState createState() =>
      _GravarLocalizationWidgetState();
}

class _GravarLocalizationWidgetState extends State<GravarLocalizationWidget> {
  late GravarLocalizationModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  // LatLng? currentUserLocationValue;

  final animationsMap = {
    'textOnPageLoadAnimation1': AnimationInfo(
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
    _model = createModel(context, () => GravarLocalizationModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.loadedLocalization = await actions.getFullLocalizationFromService(
        BTDevicesStruct(
          name: widget.nomeDispositivo,
          id: widget.idDispositivo,
          rssi: widget.rssiDispositivo,
          type: widget.tipoDoDispositivo,
          connectable: true,
        ),
      );
      setState(() {
        _model.currentLocalization = _model.loadedLocalization!;
      });

      DateTime now = DateTime.now().toUtc();
      String timestamp = now.toString();
      // convert to the format YYYY-MM-DD, HH:mm:ss
      String firstPart = timestamp.substring(0, 10);
      String secondPart = timestamp.substring(11, 19);
      timestamp = firstPart + ", " + secondPart;
    });

    getCurrentUserLocation(
            defaultLocation: LatLng(0.0, 0.0), cached: false, timeout: 10)
        .then((loc) => (setState(() => _model.deviceLocation = loc)));

    if (_model.deviceLocation == LatLng(0.0, 0.0)) {
      queryPrevUserLocation(15)
          .then((loc) => setState(() => _model.devicePrevLocation = loc));
    }

    _model.textController1 ??= TextEditingController();
    _model.textFieldFocusNode1 ??= FocusNode();
    _model.textController2 ??= TextEditingController();
    _model.textFieldFocusNode2 ??= FocusNode();
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

    if (_model.deviceLocation == null) {
      return Container(
        color: FlutterFlowTheme.of(context).primaryBackground,
        child: Center(
          child: SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                child: Text(
                                  widget.nomeDispositivo!,
                                  style: FlutterFlowTheme.of(context)
                                      .titleLarge
                                      .override(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
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
                                          return FlutterFlowTheme.of(context)
                                              .success;
                                        } else if (widget.rssiDispositivo! <
                                            -90) {
                                          return FlutterFlowTheme.of(context)
                                              .tertiary;
                                        } else {
                                          return FlutterFlowTheme.of(context)
                                              .error;
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
                      FlutterFlowIconButton(
                          borderColor: FlutterFlowTheme.of(context).accent1,
                          borderRadius: 20,
                          borderWidth: 2,
                          buttonSize: 42,
                          fillColor: FlutterFlowTheme.of(context).accent1,
                          showLoadingIndicator: true,
                          icon: Icon(
                            Icons.replay_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 20,
                          ),
                          onPressed: () async {
                            setState(
                                () => _model.isRequestingLocalization = true);
                            _model.deviceLocation =
                                await getCurrentUserLocation(
                              defaultLocation: LatLng(0.0, 0.0),
                              timeout: 10,
                              cached: false,
                            );
                            setState(
                                () => _model.isRequestingLocalization = false);
                            // if (_model.deviceLocation == LatLng(0.0, 0.0)) {
                            //   showCupertinoModalPopup(
                            //       context: context,
                            //       builder: (context) {
                            //         return CupertinoAlertDialog(
                            //             title: Text('Atenção'),
                            //             content: (_model
                            //                     .isRequestingLocalization
                            //                 ? Text('Solicitando coordenadas do GPS...')
                            //                     .animateOnPageLoad(animationsMap[
                            //                         'textOnPageLoadAnimation1']!)
                            //                 : Text(
                            //                     'Não foi possível obter as coordenadas do GPS. Tente novamente ou insira manualmente.')),
                            //             actions: [
                            //               CupertinoDialogAction(
                            //                 onPressed: () {
                            //                   Navigator.pop(context);
                            //                 },
                            //                 child: Text('Sair'),
                            //               ),
                            //               CupertinoDialogAction(
                            //                   onPressed: () async {
                            //                     setState(() => _model
                            //                             .isRequestingLocalization =
                            //                         true);
                            //                     Navigator.pop(context);
                            //                     _model.deviceLocation =
                            //                         await getCurrentUserLocation(
                            //                       defaultLocation:
                            //                           LatLng(0.0, 0.0),
                            //                       timeout: 5,
                            //                       cached: false,
                            //                     );
                            //                     setState(() => _model
                            //                             .isRequestingLocalization =
                            //                         false);
                            //                     setState(() {});
                            //                   },
                            //                   child: Text('Tentar novamente')),
                            //             ]);
                            //       });
                            // }
                            setState(() {});
                          }),
                    ],
                  )
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
            padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Localização do STC',
                          style: FlutterFlowTheme.of(context).bodyLarge,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pressione para solicitar novamente',
                          style: FlutterFlowTheme.of(context).labelMedium,
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                      child: Material(
                        color: Colors.transparent,
                        // elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: 80.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).alternate,
                            // boxShadow: [
                            //   BoxShadow(
                            //     blurRadius: 4.0,
                            //     color: Color(0x33000000),
                            //     offset: Offset(0.0, 2.0),
                            //   )
                            // ],
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: Color(0xFF353F49),
                            ),
                          ),
                          child: FFButtonWidget(
                            onPressed: () async {
                              _model.loadedLocalizationButton =
                                  await actions.getFullLocalizationFromService(
                                BTDevicesStruct(
                                  name: widget.nomeDispositivo,
                                  id: widget.idDispositivo,
                                  rssi: widget.rssiDispositivo,
                                  type: widget.tipoDoDispositivo,
                                  connectable: true,
                                ),
                              );
                              setState(() {
                                _model.currentLocalization =
                                    _model.loadedLocalizationButton!;
                              });

                              setState(() {});
                            },
                            text: valueOrDefault<String>(
                              _model.currentLocalization,
                              'solicitando...',
                            ),
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 1.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).alternate,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'DM Sans',
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_model.deviceLocation != LatLng(0.0, 0.0))
                      Divider(
                        thickness: 1.2,
                        color: Color(0xFF323B43),
                      ),
                    if (_model.deviceLocation != LatLng(0.0, 0.0))
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlutterFlowChoiceChips(
                              options: [
                                ChipData('GPS', Icons.my_location),
                                ChipData(
                                  'Manual',
                                  Icons.edit_location_alt_outlined,
                                )
                              ],
                              onChanged: (val) => setState(
                                  () => _model.choiceChipsValue = val?.first),
                              selectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).success,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'DM Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                iconColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                iconSize: 18.0,
                                elevation: 5.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).accent2,
                                borderWidth: 1.0,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              unselectedChipStyle: ChipStyle(
                                backgroundColor:
                                    FlutterFlowTheme.of(context).alternate,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'DM Sans',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                    ),
                                iconColor:
                                    FlutterFlowTheme.of(context).secondaryText,
                                iconSize: 18.0,
                                elevation: 5.0,
                                borderColor: Color(0xFF323B43),
                                borderWidth: 1.0,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              chipSpacing: 12.0,
                              rowSpacing: 8.0,
                              multiselect: false,
                              initialized: _model.choiceChipsValue != null,
                              alignment: WrapAlignment.start,
                              controller: _model.choiceChipsValueController ??=
                                  FormFieldController<List<String>>(
                                ['GPS'],
                              ),
                              wrapped: true,
                            ),
                          ],
                        ),
                      ),
                    if (_model.deviceLocation != LatLng(0.0, 0.0) &&
                        _model.choiceChipsValue == 'GPS')
                      Divider(
                        thickness: 1.2,
                        color: Color(0xFF323B43),
                      ),
                    if (_model.choiceChipsValue == 'GPS' &&
                        _model.deviceLocation != LatLng(0.0, 0.0))
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 6.0),
                        child: Row(
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 6.0, 0.0),
                                      child: Icon(
                                        Icons.my_location_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        size: 22.0,
                                      ),
                                    ),
                                    Text(
                                      'Coordenadas do GPS:',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'DM Sans',
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 6.0, 0.0, 6.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formatLatLng(
                                            _model.deviceLocation!.latitude
                                                .toString(),
                                            _model.deviceLocation!.longitude
                                                .toString()),
                                        style: FlutterFlowTheme.of(context)
                                            .labelMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    if (_model.seeWarning &&
                        _model.deviceLocation == LatLng(0.0, 0.0))
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          setState(
                              () => _model.isRequestingLocalization = true);
                          _model.deviceLocation = await getCurrentUserLocation(
                            defaultLocation: LatLng(0.0, 0.0),
                            timeout: 15,
                            cached: true,
                          );
                          setState(
                              () => _model.isRequestingLocalization = false);
                          setState(() {});
                        },
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(2, 10, 2, 10),
                          child: Material(
                            color: Colors.transparent,
                            // elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              // height: 60,
                              decoration: BoxDecoration(
                                  // color: FlutterFlowTheme.of(context).alternate,
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     blurRadius: 4.0,
                                  //     color: Color(0x33000000),
                                  //     offset: Offset(0.0, 2.0),
                                  //   )
                                  // ],
                                  // borderRadius: BorderRadius.circular(6.0),
                                  // border: Border.all(
                                  //   color: Color(0xFF353F49),
                                  // ),
                                  ),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 0, 0),
                                        child: _model.isRequestingLocalization
                                            ? Text(
                                                'Solicitando coordenadas do GPS...',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'DM Sans',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiary,
                                                        ),
                                                textAlign: TextAlign.center,
                                              ).animateOnPageLoad(animationsMap[
                                                'textOnPageLoadAnimation1']!)
                                            : Text(
                                                'Não foi possível obter as coordenadas do GPS. Tente novamente ou insira manualmente.',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'DM Sans',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiary,
                                                        ),
                                                textAlign: TextAlign.center,
                                              ),
                                      ),
                                    ),
                                    // InkWell(
                                    //   splashColor: Colors.transparent,
                                    //   focusColor: Colors.transparent,
                                    //   hoverColor: Colors.transparent,
                                    //   highlightColor: Colors.transparent,
                                    //   onTap: () async {
                                    //     _model.deviceLocation =
                                    //         await getCurrentUserLocation(
                                    //       defaultLocation: LatLng(0.0, 0.0),
                                    //       timeout: 15,
                                    //       cached: true,
                                    //     );
                                    //     setState(() {});
                                    //   },
                                    //   child: Icon(
                                    //     Icons.replay_rounded,
                                    //     color: FlutterFlowTheme.of(context)
                                    //         .primaryText,
                                    //     size: 24,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    // if (_model.choiceChipsValue == 'Manual' ||
                    //     _model.deviceLocation == LatLng(0.0, 0.0))
                    //   Divider(
                    //     thickness: 1.2,
                    //     color: Color(0xFF323B43),
                    //   ),
                    // if (_model.devicePrevLocation != LatLng(0.0, 0.0) &&
                    //     _model.deviceLocation == LatLng(0.0, 0.0))
                    //   Padding(
                    //     padding:
                    //         EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 6.0),
                    //     child: Row(
                    //       mainAxisSize: MainAxisSize.max,
                    //       children: [
                    //         Column(
                    //           mainAxisSize: MainAxisSize.max,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Row(
                    //               mainAxisSize: MainAxisSize.max,
                    //               children: [
                    //                 Padding(
                    //                   padding: EdgeInsetsDirectional.fromSTEB(
                    //                       0.0, 0.0, 6.0, 0.0),
                    //                   child: Icon(
                    //                     Icons.my_location_rounded,
                    //                     color: FlutterFlowTheme.of(context)
                    //                         .primaryText,
                    //                     size: 22.0,
                    //                   ),
                    //                 ),
                    //                 SelectionArea(
                    //                   child: Text(
                    //                     'Últimas coordenadas registradas: ',
                    //                     style: FlutterFlowTheme.of(context)
                    //                         .bodyMedium
                    //                         .override(
                    //                           fontFamily: 'DM Sans',
                    //                           fontWeight: FontWeight.w600,
                    //                         ),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //             Padding(
                    //               padding: EdgeInsetsDirectional.fromSTEB(
                    //                   0.0, 6.0, 0.0, 6.0),
                    //               child: Row(
                    //                 mainAxisSize: MainAxisSize.max,
                    //                 mainAxisAlignment:
                    //                     MainAxisAlignment.spaceBetween,
                    //                 children: [
                    //                   if (_model.devicePrevLocation != null)
                    //                     SelectionArea(
                    //                       child: Text(
                    //                         formatLatLng(
                    //                           _model
                    //                               .devicePrevLocation!.latitude
                    //                               .toString(),
                    //                           _model
                    //                               .devicePrevLocation!.longitude
                    //                               .toString(),
                    //                         ),
                    //                         style: FlutterFlowTheme.of(context)
                    //                             .labelMedium,
                    //                       ),
                    //                     ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    if (_model.choiceChipsValue == 'Manual' ||
                        _model.deviceLocation == LatLng(0.0, 0.0))
                      Divider(
                        thickness: 1.2,
                        color: Color(0xFF323B43),
                      ),
                    if (_model.choiceChipsValue == 'Manual' ||
                        _model.deviceLocation == LatLng(0.0, 0.0))
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 6.0, 0.0, 6.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 6.0, 0.0),
                                    child: Icon(
                                      Icons.edit_location_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 24.0,
                                    ),
                                  ),
                                  Text(
                                    'Insira a localização (Lat, Lng):',
                                    textAlign: TextAlign.start,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'DM Sans',
                                          lineHeight: 1.4,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 6.0, 0.0, 6.0),
                              child: Text(
                                valueOrDefault<String>(
                                    _model.deviceLocation != LatLng(0.0, 0.0)
                                        ? 'Grave sua localização e o timemstamp atual (UTC), no botão "GPS" ou uma localização diferente, no botão "Manual".'
                                        : 'Grave uma localização e o timemstamp atual (UTC).',
                                    'Grave sua localização e o timemstamp atual (UTC), no botão "GPS" ou uma localização diferente, no botão "Manual".'),
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'DM Sans',
                                      fontSize: 14.0,
                                      lineHeight: 1.4,
                                    ),
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 6.0),
                                    child: Container(
                                      width: double.infinity,
                                      child: TextFormField(
                                        controller: _model.textController1,
                                        focusNode: _model.textFieldFocusNode1,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.textController1',
                                          Duration(milliseconds: 2000),
                                          () => setState(() {}),
                                        ),
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          isDense: true,
                                          hintText: 'latitude',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelLarge
                                                  .override(
                                                    fontFamily: 'DM Sans',
                                                    fontSize: 14.0,
                                                  ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .error,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(6.0),
                                          ),
                                          filled: true,
                                          fillColor:
                                              FlutterFlowTheme.of(context)
                                                  .accent1,
                                          suffixIcon: _model.textController1!
                                                  .text.isNotEmpty
                                              ? InkWell(
                                                  onTap: () async {
                                                    _model.textController1
                                                        ?.clear();
                                                    setState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    size: 18.0,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'DM Sans',
                                              fontSize: 14.0,
                                            ),
                                        keyboardType: const TextInputType
                                            .numberWithOptions(
                                            signed: true, decimal: true),
                                        validator: _model
                                            .textController1Validator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: Container(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _model.textController2,
                                      focusNode: _model.textFieldFocusNode2,
                                      onChanged: (_) => EasyDebounce.debounce(
                                        '_model.textController2',
                                        Duration(milliseconds: 2000),
                                        () => setState(() {}),
                                      ),
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'longitude',
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelLarge
                                            .override(
                                              fontFamily: 'DM Sans',
                                              fontSize: 14.0,
                                            ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            width: 1.0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                        ),
                                        filled: true,
                                        fillColor: FlutterFlowTheme.of(context)
                                            .accent1,
                                        suffixIcon: _model.textController2!.text
                                                .isNotEmpty
                                            ? InkWell(
                                                onTap: () async {
                                                  _model.textController2
                                                      ?.clear();
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.clear,
                                                  size: 18.0,
                                                ),
                                              )
                                            : null,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyLarge
                                          .override(
                                            fontFamily: 'DM Sans',
                                            fontSize: 14.0,
                                          ),
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: true, decimal: true),
                                      validator: _model.textController2Validator
                                          .asValidator(context),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    Divider(
                      thickness: 1.0,
                      color: FlutterFlowTheme.of(context).alternate,
                    ),
                  ],
                ),
                Align(
                  alignment: AlignmentDirectional(0.00, 1.00),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 40.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        await showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          enableDrag: false,
                          context: context,
                          builder: (context) {
                            return GestureDetector(
                              onTap: () => _model.unfocusNode.canRequestFocus
                                  ? FocusScope.of(context)
                                      .requestFocus(_model.unfocusNode)
                                  : FocusScope.of(context).unfocus(),
                              child: Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.7,
                                  child: ConfirmLocalizationWidget(
                                    latitude:
                                        _model.choiceChipsValue == 'GPS' &&
                                                _model.deviceLocation !=
                                                    LatLng(0.0, 0.0)
                                            ? _model.deviceLocation?.latitude
                                                .toString()
                                            : _model.textController1.text == ''
                                                ? '0.0'
                                                : _model.textController1.text,
                                    longitude:
                                        _model.choiceChipsValue == 'GPS' &&
                                                _model.deviceLocation !=
                                                    LatLng(0.0, 0.0)
                                            ? _model.deviceLocation?.longitude
                                                .toString()
                                            : _model.textController2.text == ''
                                                ? '0.0'
                                                : _model.textController2.text,
                                    timestamp: () {
                                      DateTime now = DateTime.now().toUtc();
                                      String timestamp = now.toString();
                                      // convert to the format YYYY-MM-DD, HH:mm:ss
                                      String firstPart =
                                          timestamp.substring(0, 10);
                                      String secondPart =
                                          timestamp.substring(11, 19);
                                      timestamp = firstPart + ", " + secondPart;
                                      return timestamp;
                                    }(),
                                    localization:
                                        _model.deviceLocation!.toString(),
                                    fullLocalization:
                                        _model.choiceChipsValue == 'GPS' &&
                                            _model.deviceLocation !=
                                                LatLng(0.0, 0.0),
                                    device: BTDevicesStruct(
                                      name: widget.nomeDispositivo,
                                      id: widget.idDispositivo,
                                      rssi: widget.rssiDispositivo,
                                      type: widget.tipoDoDispositivo,
                                      connectable: true,
                                    ),
                                    serviceUUID: widget.serviceUUID!,
                                  ),
                                ),
                              ),
                            );
                          },
                        ).then((value) => safeSetState(() {}));
                        _model.updatedLocalization =
                            await actions.getFullLocalizationFromService(
                          BTDevicesStruct(
                            name: widget.nomeDispositivo,
                            id: widget.idDispositivo,
                            rssi: widget.rssiDispositivo,
                            type: widget.tipoDoDispositivo,
                            connectable: true,
                          ),
                        );
                        setState(() {
                          _model.currentLocalization =
                              _model.updatedLocalization!;
                        });

                        // await actions.gravarLocalization(
                        //   BTDevicesStruct(
                        //     name: widget.nomeDispositivo,
                        //     id: widget.idDispositivo,
                        //     rssi: widget.rssiDispositivo,
                        //     type: widget.tipoDoDispositivo,
                        //     connectable: true,
                        //   ),
                        //   widget.serviceUUID,
                        //   _model.choiceChipsValue == 'GPS'
                        //       ? _model.deviceLocation?.toString()
                        //       : _model.textController1.text == ''
                        //           ? '0.0'
                        //           : _model.textController1.text,
                        //   _model.choiceChipsValue == 'GPS'
                        //       ? _model.deviceLocation?.toString()
                        //       : _model.textController2.text == ''
                        //           ? '0.0'
                        //           : _model.textController2.text,
                        //   _model.deviceLocation?.toString(),
                        //   _model.choiceChipsValue == 'GPS',
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text(
                        //       'Localization and Timestamp sent to tracker',
                        //       style: TextStyle(
                        //         color:
                        //             FlutterFlowTheme.of(context).primaryText,
                        //       ),
                        //     ),
                        //     duration: Duration(milliseconds: 4000),
                        //     backgroundColor:
                        //         FlutterFlowTheme.of(context).secondary,
                        //   ),
                        // );
                        // _model.updatedLocalization =
                        //     await actions.getFullLocalizationFromService(
                        //   BTDevicesStruct(
                        //     name: widget.nomeDispositivo,
                        //     id: widget.idDispositivo,
                        //     rssi: widget.rssiDispositivo,
                        //     type: widget.tipoDoDispositivo,
                        //     connectable: true,
                        //   ),
                        // );
                        // setState(() {
                        //   _model.currentLocalization =
                        //       _model.updatedLocalization!;
                        // });

                        // setState(() {});
                      },
                      text: 'Gravar',
                      options: FFButtonOptions(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        height: 42.0,
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
