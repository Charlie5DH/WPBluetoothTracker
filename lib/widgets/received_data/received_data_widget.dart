import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'received_data_model.dart';
export 'received_data_model.dart';

class ReceivedDataWidget extends StatefulWidget {
  const ReceivedDataWidget({
    Key? key,
    required this.receivedData,
  }) : super(key: key);

  final List<String>? receivedData;

  @override
  _ReceivedDataWidgetState createState() => _ReceivedDataWidgetState();
}

class _ReceivedDataWidgetState extends State<ReceivedDataWidget> {
  late ReceivedDataModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReceivedDataModel());
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
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Builder(
                  builder: (context) {
                    final listdata = widget.receivedData!.toList();
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listdata.length,
                      separatorBuilder: (_, __) => SizedBox(height: 3.0),
                      itemBuilder: (context, listdataIndex) {
                        final listdataItem = listdata[listdataIndex];
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 5.0, 0.0),
                              child: Icon(
                                Icons.arrow_right,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 20.0,
                              ),
                            ),
                            Text(
                              listdataItem,
                              style: FlutterFlowTheme.of(context).bodyMedium,
                            ),
                          ],
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
