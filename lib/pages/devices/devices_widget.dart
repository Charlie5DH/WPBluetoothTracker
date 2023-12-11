import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_autocomplete_options_list.dart';
// import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
// import '/flutter_flow/form_field_controller.dart';
import '/widgets/connecting_dialog/connecting_dialog_widget.dart';
import '/widgets/empty_list/empty_list_widget.dart';
import '/widgets/no_paired_devices/no_paired_devices_widget.dart';
import '/widgets/strength_indicator/strength_indicator_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'devices_model.dart';
export 'devices_model.dart';

class DevicesWidget extends StatefulWidget {
  const DevicesWidget({
    Key? key,
    bool? isBTEnabled,
  })  : this.isBTEnabled = isBTEnabled ?? true,
        super(key: key);

  final bool isBTEnabled;

  @override
  _DevicesWidgetState createState() => _DevicesWidgetState();
}

class _DevicesWidgetState extends State<DevicesWidget>
    with TickerProviderStateMixin {
  late DevicesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  late StreamSubscription<List<ScanResult>> _scanResultsSubscription;
  List startsWithSTS = [];
  List startsWithSTC = [];
  List otherObjects = [];

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
    'textOnPageLoadAnimation2': AnimationInfo(
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

  void updateState(Function() callback) {
    setState(() {
      callback();
    });
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _model = createModel(context, () => DevicesModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setDarkModeSetting(context, ThemeMode.dark);

      setState(() {
        _model.isBluetoothEnabled = widget.isBTEnabled;
      });

      // setState(() {
      //   _model.isScanning = true;
      // });

      if (_model.isBluetoothEnabled!) {
        _model.isFetchingConnectedDevices = true;
        _model.isFetchingDevices = true;
        final connectedDevices =
            FlutterBluePlus.connectedDevices; // autoconnect

        _scanResultsSubscription =
            FlutterBluePlus.scanResults.listen((results) {
          for (ScanResult r in results) {
            // if the device is already in the list, replace it with the new one
            if (_model.foundDevices
                .any((element) => element.id == r.device.remoteId.toString())) {
              setState(() {
                _model.foundDevices.removeWhere(
                    (element) => element.id == r.device.remoteId.toString());
              });
            }

            // if (_model.isScanning == false) {
            //   _scanResultsSubscription.cancel();
            //   return;
            // }

            if (r.device.platformName.isNotEmpty &&
                (r.device.platformName.startsWith("STS") ||
                    r.device.platformName.startsWith("STC"))) {
              setState(() {
                _model.foundDevices.add(BTDevicesStruct(
                  name: r.device.platformName,
                  id: r.device.remoteId.toString(),
                  rssi: r.rssi,
                  type: "BLE",
                  connectable: r.advertisementData.connectable,
                ));

                _model.foundDevices.sort((a, b) => b.rssi.compareTo(a.rssi));
                // sort the STS by rssi, then STC by rssi, then everything else by rssi
                startsWithSTS = _model.foundDevices
                    .where((element) => element.name.startsWith('STS'))
                    .toList();
                startsWithSTC = _model.foundDevices
                    .where((element) => element.name.startsWith('STC'))
                    .toList();
                otherObjects = _model.foundDevices
                    .where((element) =>
                        !element.name.startsWith('STS') &&
                        !element.name.startsWith('STC'))
                    .toList();
                startsWithSTS.sort((a, b) => b.rssi.compareTo(a.rssi));
                startsWithSTC.sort((a, b) => b.rssi.compareTo(a.rssi));
                otherObjects.sort((a, b) => b.rssi.compareTo(a.rssi));

                _model.foundDevices = [
                  ...startsWithSTS,
                  ...startsWithSTC,
                  ...otherObjects
                ];
                if (_model.autoconnect) {
                  if (connectedDevices.contains(r.device) == false &&
                      r.advertisementData.connectable == true &&
                      (r.device.platformName.startsWith("STS") ||
                          r.device.platformName.startsWith("STC"))) {
                    try {
                      print('connecting to ${r.device.platformName}');
                      r.device.connect();
                      print("connected to ${r.device.platformName}");
                    } catch (e) {
                      // print(e);
                      print("failed to connect to ${r.device.platformName}");
                    }
                  }
                }
              });

              print(r.device.platformName);

              // connect the device
            }
          }
        });

        print("starting scan");

        try {
          // await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
          await FlutterBluePlus.startScan();
        } catch (e) {
          print(e);
        }

        // Wait for the scan to complete
        await Future.delayed(Duration(seconds: 20));

        // Cancel the subscription
        await _scanResultsSubscription.cancel();

        // setState(() {
        //   _model.isScanning = false;
        // });

        _model.fetchedConnectedDevices = await actions.getConnectedDevices(
          valueOrDefault<String>(
            _model.choiceChipsValue,
            'STS-STC',
          ),
        );

        setState(() {
          _model.isFetchingConnectedDevices = false;
          _model.isFetchingDevices = false;
        });

        setState(() {
          // _model.foundDevices =
          //     _model.fetchedDevices!.toList().cast<BTDevicesStruct>();
          _model.connectedDevices =
              _model.fetchedConnectedDevices!.toList().cast<BTDevicesStruct>();
        });
      }
    });

    _model.textController ??= TextEditingController();
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print('FloatingActionButton pressed ...');
            },
            backgroundColor: FlutterFlowTheme.of(context).primary,
            elevation: 8.0,
            child: FlutterFlowIconButton(
              borderColor: FlutterFlowTheme.of(context).primary,
              borderRadius: 20.0,
              borderWidth: 1.0,
              buttonSize: 46.0,
              fillColor: FlutterFlowTheme.of(context).accent1,
              icon: Icon(
                Icons.replay,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
              showLoadingIndicator: true,
              onPressed: _model.isFetchingDevices
                  ? null
                  : () async {
                      var _shouldSetState = false;
                      if (_model.isFetchingDevices == true) {
                        unawaited(
                          () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Wait for current scan to end',
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'DM Sans',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                ),
                                duration: Duration(milliseconds: 4000),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).tertiary,
                              ),
                            );
                          }(),
                        );
                        if (_shouldSetState) setState(() {});
                        return;
                      }
                      setState(() {
                        _model.isFetchingConnectedDevices = true;
                        _model.isFetchingDevices = true;
                      });

                      // await actions.findDevices(
                      //     _model.choiceChipsValue!, setState, _model.foundDevices);

                      _model.connDevicesRefresh =
                          await actions.getConnectedDevices(
                        valueOrDefault<String>(
                          _model.choiceChipsValue,
                          'STS-STC',
                        ),
                      );

                      setState(() {
                        _model.connectedDevices = _model.connDevicesRefresh!
                            .toList()
                            .cast<BTDevicesStruct>();
                      });

                      //-------------------------------------------------------------

                      _scanResultsSubscription =
                          FlutterBluePlus.scanResults.listen((results) {
                        for (ScanResult r in results) {
                          // if the device is already in the list, replace it with the new one
                          if (_model.foundDevices.any((element) =>
                              element.id == r.device.remoteId.toString())) {
                            setState(() {
                              _model.foundDevices.removeWhere((element) =>
                                  element.id == r.device.remoteId.toString());
                            });
                          }

                          if (r.device.platformName.isNotEmpty &&
                                  r.device.platformName.startsWith("STS") ||
                              r.device.platformName.startsWith("STC")) {
                            setState(() {
                              _model.foundDevices.add(BTDevicesStruct(
                                name: r.device.platformName,
                                id: r.device.remoteId.toString(),
                                rssi: r.rssi,
                                type: "BLE",
                                connectable: r.advertisementData.connectable,
                              ));

                              _model.foundDevices
                                  .sort((a, b) => b.rssi.compareTo(a.rssi));
                              // sort the STS by rssi, then STC by rssi, then everything else by rssi
                              startsWithSTS = _model.foundDevices
                                  .where((element) =>
                                      element.name.startsWith('STS'))
                                  .toList();
                              startsWithSTC = _model.foundDevices
                                  .where((element) =>
                                      element.name.startsWith('STC'))
                                  .toList();
                              otherObjects = _model.foundDevices
                                  .where((element) =>
                                      !element.name.startsWith('STS') &&
                                      !element.name.startsWith('STC'))
                                  .toList();

                              startsWithSTS
                                  .sort((a, b) => b.rssi.compareTo(a.rssi));
                              startsWithSTC
                                  .sort((a, b) => b.rssi.compareTo(a.rssi));
                              otherObjects
                                  .sort((a, b) => b.rssi.compareTo(a.rssi));

                              _model.foundDevices = [
                                ...startsWithSTS,
                                ...startsWithSTC,
                                ...otherObjects
                              ];

                              if (_model.autoconnect) {
                                final connectedDevices = FlutterBluePlus
                                    .connectedDevices; // autoconnect
                                if (connectedDevices.contains(r.device) ==
                                        false &&
                                    r.advertisementData.connectable == true &&
                                    (r.device.platformName.startsWith("STS") ||
                                        r.device.platformName
                                            .startsWith("STC"))) {
                                  try {
                                    print(
                                        'connecting to ${r.device.platformName}');
                                    r.device.connect();
                                    print(
                                        "connected to ${r.device.platformName}");
                                  } catch (e) {
                                    // print(e);
                                    print(
                                        "failed to connect to ${r.device.platformName}");
                                  }
                                }
                              }
                            });

                            print(r.device.platformName);

                            // connect the device
                          }

                          // remove devices that are in the list but not in the scan results---------------------
                          _model.foundDevices.removeWhere((element) =>
                              !results.any((result) =>
                                  result.device.remoteId.toString() ==
                                  element.id));
                          //-----------------------------------------------------------------------------
                        }
                      });

                      print("starting scan");

                      try {
                        // await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
                        await FlutterBluePlus.startScan();
                      } catch (e) {
                        print(e);
                      }

                      // Wait for the scan to complete
                      await Future.delayed(Duration(seconds: 20));

                      // Cancel the subscription
                      await _scanResultsSubscription.cancel();

                      //-------------------------------------------------------------

                      // setState(() {
                      //   _model.foundDevices =
                      //       _model.devicesRefresh!.toList().cast<BTDevicesStruct>();
                      // });
                      _model.connDevicesRefresh =
                          await actions.getConnectedDevices(
                        valueOrDefault<String>(
                          _model.choiceChipsValue,
                          'STS-STC',
                        ),
                      );

                      setState(() {
                        _model.connectedDevices = _model.connDevicesRefresh!
                            .toList()
                            .cast<BTDevicesStruct>();
                      });

                      setState(() {
                        _model.isFetchingConnectedDevices = false;
                        _model.isFetchingDevices = false;
                      });

                      setState(() {});
                    },
            ),
          ),
          appBar: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.00, 0.00),
                  child: Text(
                    FFAppState().languageCode == 'POR'
                        ? 'Dispositivos'
                        : FFAppState().languageCode == 'ENG'
                            ? 'Devices'
                            : 'Dispositivos',
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Montserrat',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
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
                    CupertinoSlidingSegmentedControl(
                      children: {
                        'POR': Text(
                          'POR',
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'DM Sans',
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                        ),
                        'ENG': Text(
                          'ENG',
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'DM Sans',
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                        ),
                        'SPA': Text(
                          'SPA',
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'DM Sans',
                                color: FlutterFlowTheme.of(context).primaryText,
                              ),
                        ),
                      },
                      groupValue: FFAppState().languageCode,
                      onValueChanged: (newValue) async {
                        setState(() => _model.language = newValue!);
                        FFAppState().languageCode = newValue!;
                      },
                    ),
                  ],
                ),
              ),
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Icon(
              //       widget.isBTEnabled == true
              //           ? Icons.bluetooth
              //           : Icons.bluetooth_disabled,
              //       color: FlutterFlowTheme.of(context).secondaryText,
              //       size: 24.0,
              //     ),
              //     CupertinoSwitch(
              //       value: _model.switchValue ??= widget.isBTEnabled,
              //       onChanged: (newValue) async {
              //         setState(() => _model.switchValue = newValue);
              //         if (newValue) {
              //           _model.isTurningOn = await actions.turnOnBluetooth();
              //           await Future.delayed(
              //               const Duration(milliseconds: 1000));
              //           setState(() {
              //             _model.isBluetoothEnabled = true;
              //           });
              //           if (widget.isBTEnabled) {
              //             setState(() {
              //               _model.isFetchingConnectedDevices = true;
              //               _model.isFetchingDevices = true;
              //             });
              //             _model.fetchedConnectedDevicesSW =
              //                 await actions.getConnectedDevices(
              //               valueOrDefault<String>(
              //                 _model.choiceChipsValue,
              //                 'STS-STC',
              //               ),
              //             );
              //             setState(() {
              //               _model.isFetchingConnectedDevices = false;
              //               _model.connectedDevices = _model
              //                   .fetchedConnectedDevicesSW!
              //                   .toList()
              //                   .cast<BTDevicesStruct>();
              //             });
              //             // await actions.findDevices(_model.choiceChipsValue!,
              //             //     setState, _model.foundDevices);

              //             //------------------------------------------------------------------
              //             setState(() {
              //               _model.foundDevices.clear();
              //             });
              //             //-------------------------------------------------------------

              //             _scanResultsSubscription =
              //                 FlutterBluePlus.scanResults.listen((results) {
              //               for (ScanResult r in results) {
              //                 // if the device is already in the list, replace it with the new one
              //                 if (_model.foundDevices.any((element) =>
              //                     element.id == r.device.remoteId.toString())) {
              //                   setState(() {
              //                     _model.foundDevices.removeWhere((element) =>
              //                         element.id ==
              //                         r.device.remoteId.toString());
              //                   });
              //                 }

              //                 if (r.device.platformName.isNotEmpty &&
              //                     (r.device.platformName.startsWith("STS") ||
              //                         r.device.platformName
              //                             .startsWith("STC"))) {
              //                   setState(() {
              //                     _model.foundDevices.add(BTDevicesStruct(
              //                       name: r.device.platformName,
              //                       id: r.device.remoteId.toString(),
              //                       rssi: r.rssi,
              //                       type: "BLE",
              //                       connectable:
              //                           r.advertisementData.connectable,
              //                     ));

              //                     _model.foundDevices
              //                         .sort((a, b) => b.rssi.compareTo(a.rssi));
              //                     // sort the STS by rssi, then STC by rssi, then everything else by rssi
              //                     startsWithSTS = _model.foundDevices
              //                         .where((element) =>
              //                             element.name.startsWith('STS'))
              //                         .toList();
              //                     startsWithSTC = _model.foundDevices
              //                         .where((element) =>
              //                             element.name.startsWith('STC'))
              //                         .toList();
              //                     otherObjects = _model.foundDevices
              //                         .where((element) =>
              //                             !element.name.startsWith('STS') &&
              //                             !element.name.startsWith('STC'))
              //                         .toList();

              //                     startsWithSTS
              //                         .sort((a, b) => b.rssi.compareTo(a.rssi));
              //                     startsWithSTC
              //                         .sort((a, b) => b.rssi.compareTo(a.rssi));
              //                     otherObjects
              //                         .sort((a, b) => b.rssi.compareTo(a.rssi));

              //                     _model.foundDevices = [
              //                       ...startsWithSTS,
              //                       ...startsWithSTC,
              //                       ...otherObjects
              //                     ];

              //                     if (_model.autoconnect) {
              //                       final connectedDevices = FlutterBluePlus
              //                           .connectedDevices; // autoconnect
              //                       if (connectedDevices.contains(r.device) ==
              //                               false &&
              //                           r.advertisementData.connectable ==
              //                               true &&
              //                           (r.device.platformName
              //                                   .startsWith("STS") ||
              //                               r.device.platformName
              //                                   .startsWith("STC"))) {
              //                         try {
              //                           print(
              //                               'connecting to ${r.device.platformName}');
              //                           r.device.connect();
              //                           print(
              //                               "connected to ${r.device.platformName}");
              //                         } catch (e) {
              //                           // print(e);
              //                           print(
              //                               "failed to connect to ${r.device.platformName}");
              //                         }
              //                       }
              //                     }
              //                   });

              //                   print(r.device.platformName);

              //                   // connect the device
              //                 }
              //               }
              //             });

              //             print("starting scan");

              //             try {
              //               // await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15));
              //               await FlutterBluePlus.startScan();
              //             } catch (e) {
              //               print(e);
              //             }

              //             // Wait for the scan to complete
              //             await Future.delayed(Duration(seconds: 15));

              //             // Cancel the subscription
              //             await _scanResultsSubscription.cancel();

              //             //-------------------------------------------------------------
              //             //------------------------------------------------------------------
              //             setState(() {
              //               _model.isFetchingDevices = false;
              //               // _model.foundDevices = _model.fetchedDevicesSW!
              //               //     .toList()
              //               //     .cast<BTDevicesStruct>();
              //             });
              //           }

              //           setState(() {});
              //         } else {
              //           _model.isTurningOff = await actions.turnOffBluetooth();
              //           await Future.delayed(
              //               const Duration(milliseconds: 2000));
              //           setState(() {
              //             _model.isBluetoothEnabled = false;
              //           });
              //           if (widget.isBTEnabled) {
              //             setState(() {
              //               _model.isFetchingConnectedDevices = false;
              //               _model.isFetchingDevices = false;
              //             });
              //           }

              //           setState(() {});
              //         }
              //       },
              //       activeColor: FlutterFlowTheme.of(context).success,
              //       trackColor: FlutterFlowTheme.of(context).alternate,
              //       thumbColor: Color(0xFFFAFAFA),
              //     ),
              //   ],
              // ),
            ],
            centerTitle: true,
            elevation: 0.0,
          ),
          body: SafeArea(
            top: true,
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 10.0, 16.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        if (_model.isBluetoothEnabled ?? true)
                          Stack(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 8.0, 0.0, 4.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.9,
                                                    child: Autocomplete<String>(
                                                      initialValue:
                                                          TextEditingValue(),
                                                      optionsBuilder:
                                                          (textEditingValue) {
                                                        if (textEditingValue
                                                                .text ==
                                                            '') {
                                                          return const Iterable<
                                                              String>.empty();
                                                        }
                                                        return ['Option 1']
                                                            .where((option) {
                                                          final lowercaseOption =
                                                              option
                                                                  .toLowerCase();
                                                          return lowercaseOption
                                                              .contains(
                                                                  textEditingValue
                                                                      .text
                                                                      .toLowerCase());
                                                        });
                                                      },
                                                      optionsViewBuilder:
                                                          (context, onSelected,
                                                              options) {
                                                        return AutocompleteOptionsList(
                                                          textFieldKey: _model
                                                              .textFieldKey,
                                                          textController: _model
                                                              .textController!,
                                                          options:
                                                              options.toList(),
                                                          onSelected:
                                                              onSelected,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium,
                                                          textHighlightStyle:
                                                              TextStyle(),
                                                          elevation: 4.0,
                                                          optionBackgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryBackground,
                                                          optionHighlightColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryBackground,
                                                          maxHeight: 200.0,
                                                        );
                                                      },
                                                      onSelected:
                                                          (String selection) {
                                                        setState(() => _model
                                                                .textFieldSelectedOption =
                                                            selection);
                                                        FocusScope.of(context)
                                                            .unfocus();
                                                      },
                                                      fieldViewBuilder: (
                                                        context,
                                                        textEditingController,
                                                        focusNode,
                                                        onEditingComplete,
                                                      ) {
                                                        _model.textFieldFocusNode =
                                                            focusNode;
                                                        _model.textController =
                                                            textEditingController;
                                                        return TextFormField(
                                                          key: _model
                                                              .textFieldKey,
                                                          controller:
                                                              textEditingController,
                                                          focusNode: focusNode,
                                                          onEditingComplete:
                                                              onEditingComplete,
                                                          onChanged: (_) =>
                                                              EasyDebounce
                                                                  .debounce(
                                                            '_model.textController',
                                                            Duration(
                                                                milliseconds:
                                                                    200),
                                                            () async {
                                                              setState(() {
                                                                _model.filterName =
                                                                    _model
                                                                        .textController
                                                                        .text;
                                                              });
                                                            },
                                                          ),
                                                          obscureText: false,
                                                          decoration:
                                                              InputDecoration(
                                                            isDense: true,
                                                            labelText: FFAppState()
                                                                        .languageCode ==
                                                                    'POR'
                                                                ? 'Pesquisar'
                                                                : FFAppState()
                                                                            .languageCode ==
                                                                        'ENG'
                                                                    ? 'Search'
                                                                    : 'Pesquisar',
                                                            labelStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'DM Sans',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                    ),
                                                            hintStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium,
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            errorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            focusedErrorBorder:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .error,
                                                                width: 1.0,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            prefixIcon: Icon(
                                                              Icons
                                                                  .manage_search,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 24.0,
                                                            ),
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium,
                                                          validator: _model
                                                              .textControllerValidator
                                                              .asValidator(
                                                                  context),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (_model.connectedDevices.length !=
                                              0)
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 6.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    FFAppState().languageCode ==
                                                            'POR'
                                                        ? 'Dispositivos Conectados'
                                                        : FFAppState()
                                                                    .languageCode ==
                                                                'ENG'
                                                            ? 'Connected Devices'
                                                            : 'Dispositivos Conectados',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyLarge
                                                        .override(
                                                          fontFamily: 'DM Sans',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                  if (_model
                                                      .isFetchingConnectedDevices)
                                                    Text(
                                                      'Finding...',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodySmall,
                                                    ).animateOnPageLoad(
                                                        animationsMap[
                                                            'textOnPageLoadAnimation1']!),
                                                ],
                                              ),
                                            ),
                                          if (_model.connectedDevices.length !=
                                              0)
                                            Divider(
                                              thickness: 1.2,
                                              color: Color(0xFF353F49),
                                            ),
                                          if (_model.connectedDevices.length !=
                                              0)
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 0.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final displayConnectedDevices =
                                                      _model.connectedDevices
                                                          .toList();
                                                  if (displayConnectedDevices
                                                      .isEmpty) {
                                                    return Center(
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 50.0,
                                                        child:
                                                            NoPairedDevicesWidget(),
                                                      ),
                                                    );
                                                  }
                                                  return ListView.separated(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    physics:
                                                        ClampingScrollPhysics(),
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        displayConnectedDevices
                                                            .length,
                                                    separatorBuilder: (_, __) =>
                                                        SizedBox(height: 4.0),
                                                    itemBuilder: (context,
                                                        displayConnectedDevicesIndex) {
                                                      final displayConnectedDevicesItem =
                                                          displayConnectedDevices[
                                                              displayConnectedDevicesIndex];
                                                      return Visibility(
                                                        visible: functions.showSearchResults(
                                                                _model
                                                                    .textController
                                                                    .text,
                                                                displayConnectedDevicesItem
                                                                    .name) ??
                                                            true,
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            context.pushNamed(
                                                              'Device',
                                                              queryParameters: {
                                                                'deviceName':
                                                                    serializeParam(
                                                                  displayConnectedDevicesItem
                                                                      .name,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'deviceId':
                                                                    serializeParam(
                                                                  displayConnectedDevicesItem
                                                                      .id,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'deviceRssi':
                                                                    serializeParam(
                                                                  displayConnectedDevicesItem
                                                                      .rssi,
                                                                  ParamType.int,
                                                                ),
                                                                'hasWriteCharacteristics':
                                                                    serializeParam(
                                                                  true,
                                                                  ParamType
                                                                      .bool,
                                                                ),
                                                                'deviceType':
                                                                    serializeParam(
                                                                  displayConnectedDevicesItem
                                                                      .type,
                                                                  ParamType
                                                                      .String,
                                                                ),
                                                                'deviceConnectable':
                                                                    serializeParam(
                                                                  displayConnectedDevicesItem
                                                                      .connectable,
                                                                  ParamType
                                                                      .bool,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .accent2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          12.0,
                                                                          16.0,
                                                                          12.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0.0,
                                                                                0.0,
                                                                                8.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              displayConnectedDevicesItem.name,
                                                                              style: FlutterFlowTheme.of(context).bodyLarge,
                                                                            ),
                                                                          ),
                                                                          StrengthIndicatorWidget(
                                                                            key:
                                                                                Key('Key7fp_${displayConnectedDevicesIndex}_of_${displayConnectedDevices.length}'),
                                                                            rssi:
                                                                                displayConnectedDevicesItem.rssi,
                                                                            color:
                                                                                valueOrDefault<Color>(
                                                                              () {
                                                                                if (displayConnectedDevicesItem.rssi >= -90) {
                                                                                  return FlutterFlowTheme.of(context).success;
                                                                                } else if (displayConnectedDevicesItem.rssi < -90) {
                                                                                  return FlutterFlowTheme.of(context).tertiary;
                                                                                } else {
                                                                                  return FlutterFlowTheme.of(context).error;
                                                                                }
                                                                              }(),
                                                                              FlutterFlowTheme.of(context).success,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          displayConnectedDevicesItem
                                                                              .id,
                                                                          style:
                                                                              FlutterFlowTheme.of(context).labelSmall,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Text(
                                                                        displayConnectedDevicesItem
                                                                            .rssi
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'DM Sans',
                                                                              fontSize: 16.0,
                                                                              fontWeight: FontWeight.w600,
                                                                            ),
                                                                      ),
                                                                      Icon(
                                                                        Icons
                                                                            .arrow_forward_ios_rounded,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            20.0,
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
                                            ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 20.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  // if _model.foundDevices.length is equal to 0 or
                                                  // if all devices in _model.foundDevices are already connected
                                                  // then show 'No devices found'
                                                  if (_model.foundDevices
                                                          .length !=
                                                      0)
                                                    Expanded(
                                                      child: Text(
                                                        FFAppState().languageCode ==
                                                                'POR'
                                                            ? 'Dispositivos Encontrados'
                                                            : FFAppState()
                                                                        .languageCode ==
                                                                    'ENG'
                                                                ? 'Found Devices'
                                                                : 'Dispositivos Encontrados',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'DM Sans',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      if (_model
                                                          .isFetchingDevices)
                                                        Icon(
                                                          Icons.refresh_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24.0,
                                                        ),
                                                      if (_model
                                                          .isFetchingDevices)
                                                        Text(
                                                          'Scanning...',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium,
                                                        ).animateOnPageLoad(
                                                            animationsMap[
                                                                'textOnPageLoadAnimation2']!),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (_model.foundDevices.length != 0)
                                              Divider(
                                                thickness: 1.2,
                                                color: Color(0xFF353F49),
                                              ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 6.0, 0.0, 0.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final displayScannedDevices =
                                                      _model.foundDevices
                                                          .toList();
                                                  if (displayScannedDevices
                                                      .isEmpty) {
                                                    return Center(
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: 50.0,
                                                        child:
                                                            EmptyListWidget(),
                                                      ),
                                                    );
                                                  }
                                                  return RefreshIndicator(
                                                    onRefresh: () async {
                                                      setState(() {
                                                        _model.isFetchingDevices =
                                                            true;
                                                      });

                                                      setState(() {
                                                        _model.isFetchingDevices =
                                                            false;
                                                      });
                                                    },
                                                    child: ListView.separated(
                                                      padding: EdgeInsets.zero,
                                                      shrinkWrap: true,
                                                      physics:
                                                          ClampingScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          displayScannedDevices
                                                              .length,
                                                      separatorBuilder: (_,
                                                              __) =>
                                                          SizedBox(height: 4.0),
                                                      itemBuilder: (context,
                                                          displayScannedDevicesIndex) {
                                                        final displayScannedDevicesItem =
                                                            displayScannedDevices[
                                                                displayScannedDevicesIndex];
                                                        return Visibility(
                                                          visible: !functions
                                                                  .isConnectedDeviceInList(
                                                                      _model
                                                                          .connectedDevices
                                                                          .toList(),
                                                                      BTDevicesStruct(
                                                                        name: displayScannedDevicesItem
                                                                            .name,
                                                                        id: displayScannedDevicesItem
                                                                            .id,
                                                                        rssi: displayScannedDevicesItem
                                                                            .rssi,
                                                                        type: displayScannedDevicesItem
                                                                            .type,
                                                                        connectable:
                                                                            displayScannedDevicesItem.connectable,
                                                                      ))! &&
                                                              functions.showSearchResults(
                                                                  _model
                                                                      .textController
                                                                      .text,
                                                                  displayScannedDevicesItem
                                                                      .name)!,
                                                          child: Builder(
                                                            builder:
                                                                (context) =>
                                                                    InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                setState(() {
                                                                  _model.isConnectingToDevice =
                                                                      true;
                                                                });
                                                                showAlignedDialog(
                                                                  context:
                                                                      context,
                                                                  isGlobal:
                                                                      false,
                                                                  avoidOverflow:
                                                                      true,
                                                                  targetAnchor: AlignmentDirectional(
                                                                          0.0,
                                                                          0.0)
                                                                      .resolve(
                                                                          Directionality.of(
                                                                              context)),
                                                                  followerAnchor: AlignmentDirectional(
                                                                          0.0,
                                                                          0.0)
                                                                      .resolve(
                                                                          Directionality.of(
                                                                              context)),
                                                                  builder:
                                                                      (dialogContext) {
                                                                    return Material(
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          GestureDetector(
                                                                        onTap: () => _model.unfocusNode.canRequestFocus
                                                                            ? FocusScope.of(context).requestFocus(_model.unfocusNode)
                                                                            : FocusScope.of(context).unfocus(),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              300.0,
                                                                          child:
                                                                              ConnectingDialogWidget(
                                                                            isConnectingToDeviceLoading:
                                                                                false,
                                                                            deviceName:
                                                                                displayScannedDevicesItem.name,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    setState(
                                                                        () {}));

                                                                _model.hasWrite =
                                                                    await actions
                                                                        .connectDevice(
                                                                  displayScannedDevicesItem,
                                                                );
                                                                if (_model
                                                                    .hasWrite!) {
                                                                  setState(() {
                                                                    _model.addToConnectedDevices(
                                                                        displayScannedDevicesItem);
                                                                  });
                                                                  setState(() {
                                                                    _model.isConnectingToDevice =
                                                                        false;
                                                                  });
                                                                  setState(() {
                                                                    // _model.isScanning =
                                                                    //     false;
                                                                    _model.isFetchingDevices =
                                                                        false;
                                                                    _model.isFetchingConnectedDevices =
                                                                        false;
                                                                  });

                                                                  Navigator.pop(
                                                                      context);
                                                                  context
                                                                      .pushNamed(
                                                                    'Device',
                                                                    queryParameters:
                                                                        {
                                                                      'deviceName':
                                                                          serializeParam(
                                                                        displayScannedDevicesItem
                                                                            .name,
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'deviceId':
                                                                          serializeParam(
                                                                        displayScannedDevicesItem
                                                                            .id,
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'deviceRssi':
                                                                          serializeParam(
                                                                        displayScannedDevicesItem
                                                                            .rssi,
                                                                        ParamType
                                                                            .int,
                                                                      ),
                                                                      'hasWriteCharacteristics':
                                                                          serializeParam(
                                                                        _model
                                                                            .hasWrite,
                                                                        ParamType
                                                                            .bool,
                                                                      ),
                                                                      'deviceType':
                                                                          serializeParam(
                                                                        displayScannedDevicesItem
                                                                            .type,
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'deviceConnectable':
                                                                          serializeParam(
                                                                        displayScannedDevicesItem
                                                                            .connectable,
                                                                        ParamType
                                                                            .bool,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );
                                                                } else {
                                                                  Navigator.pop(
                                                                      context);
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content:
                                                                          Text(
                                                                        'Failed to connect to device',
                                                                        style: GoogleFonts
                                                                            .getFont(
                                                                          'DM Sans',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                        ),
                                                                      ),
                                                                      duration: Duration(
                                                                          milliseconds:
                                                                              4000),
                                                                      backgroundColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .error,
                                                                    ),
                                                                  );
                                                                }
                                                                setState(() {});
                                                              },
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
                                                                child:
                                                                    Container(
                                                                  width: double
                                                                      .infinity,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .accent2,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            6.0),
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16.0,
                                                                            12.0,
                                                                            16.0,
                                                                            12.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      children: [
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                                                                                  child: Text(
                                                                                    displayScannedDevicesItem.name,
                                                                                    style: FlutterFlowTheme.of(context).bodyLarge,
                                                                                  ),
                                                                                ),
                                                                                StrengthIndicatorWidget(
                                                                                  key: Key('Key53d_${displayScannedDevicesIndex}_of_${displayScannedDevices.length}'),
                                                                                  rssi: displayScannedDevicesItem.rssi,
                                                                                  color: valueOrDefault<Color>(
                                                                                    () {
                                                                                      if (displayScannedDevicesItem.rssi >= -90) {
                                                                                        return FlutterFlowTheme.of(context).success;
                                                                                      } else if (displayScannedDevicesItem.rssi < -90) {
                                                                                        return FlutterFlowTheme.of(context).tertiary;
                                                                                      } else {
                                                                                        return FlutterFlowTheme.of(context).error;
                                                                                      }
                                                                                    }(),
                                                                                    FlutterFlowTheme.of(context).success,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                                                                              child: Text(
                                                                                displayScannedDevicesItem.id,
                                                                                style: FlutterFlowTheme.of(context).labelSmall,
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Text(
                                                                                  'Connectable:',
                                                                                  style: FlutterFlowTheme.of(context).labelSmall,
                                                                                ),
                                                                                Text(
                                                                                  displayScannedDevicesItem.connectable.toString(),
                                                                                  style: FlutterFlowTheme.of(context).labelSmall,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Text(
                                                                              displayScannedDevicesItem.rssi.toString(),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'DM Sans',
                                                                                    fontSize: 16.0,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                            ),
                                                                            Icon(
                                                                              Icons.arrow_forward_ios_rounded,
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              size: 20.0,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
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
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        if (!_model.isBluetoothEnabled!)
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(),
                            child: Align(
                              alignment: AlignmentDirectional(0.00, 0.00),
                              child: Text(
                                'Turn on bluetooth to connect with any device',
                                style: FlutterFlowTheme.of(context).labelMedium,
                              ),
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
