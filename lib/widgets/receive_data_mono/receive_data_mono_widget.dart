import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'receive_data_mono_model.dart';
export 'receive_data_mono_model.dart';

class ReceiveDataMonoWidget extends StatefulWidget {
  const ReceiveDataMonoWidget({
    Key? key,
    required this.receivedData,
  }) : super(key: key);

  final List<String>? receivedData;

  @override
  _ReceiveDataMonoWidgetState createState() => _ReceiveDataMonoWidgetState();
}

class _ReceiveDataMonoWidgetState extends State<ReceiveDataMonoWidget> {
  late ReceiveDataMonoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReceiveDataMonoModel());
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
                      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                      scrollDirection: Axis.vertical,
                      itemCount: listdata.length,
                      separatorBuilder: (_, __) => SizedBox(height: 3),
                      itemBuilder: (context, listdataIndex) {
                        final listdataItem = listdata[listdataIndex];
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 3, 0),
                            ),
                            Text(listdataItem,
                                style: TextStyle(
                                    fontFamily: 'robotoMono', fontSize: 14)),
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
