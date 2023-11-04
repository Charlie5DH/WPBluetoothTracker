import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/instant_timer.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'display_received_data_model.dart';
export 'display_received_data_model.dart';

class DisplayReceivedDataWidget extends StatefulWidget {
  const DisplayReceivedDataWidget({
    Key? key,
    required this.device,
  }) : super(key: key);

  final BTDevicesStruct? device;

  @override
  _DisplayReceivedDataWidgetState createState() =>
      _DisplayReceivedDataWidgetState();
}

class _DisplayReceivedDataWidgetState extends State<DisplayReceivedDataWidget> {
  late DisplayReceivedDataModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DisplayReceivedDataModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.receivedDataTimer = InstantTimer.periodic(
        duration: Duration(milliseconds: 1000),
        callback: (timer) async {
          _model.receivedData = await actions.receiveData(
            widget.device!,
          );
          setState(() {
            _model.data = _model.receivedData!;
          });
          setState(() {
            _model.addToDataList(_model.receivedData!);
          });
        },
        startImmediately: true,
      );
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Received data',
            style: FlutterFlowTheme.of(context).titleMedium.override(
                  fontFamily: 'DM Sans',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last Message: ',
                  style: FlutterFlowTheme.of(context).bodyLarge,
                ),
                Text(
                  _model.data,
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'DM Sans',
                        lineHeight: 1.4,
                      ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.5,
            color: FlutterFlowTheme.of(context).alternate,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Builder(
                  builder: (context) {
                    final receivedDataList = _model.dataList.toList();
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: receivedDataList.length,
                      itemBuilder: (context, receivedDataListIndex) {
                        final receivedDataListItem =
                            receivedDataList[receivedDataListIndex];
                        return Text(
                          valueOrDefault<String>(
                            functions.beautifyCSVLine(receivedDataListItem),
                            'none',
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
