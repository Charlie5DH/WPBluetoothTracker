import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'no_paired_devices_model.dart';
export 'no_paired_devices_model.dart';

class NoPairedDevicesWidget extends StatefulWidget {
  const NoPairedDevicesWidget({Key? key}) : super(key: key);

  @override
  _NoPairedDevicesWidgetState createState() => _NoPairedDevicesWidgetState();
}

class _NoPairedDevicesWidgetState extends State<NoPairedDevicesWidget> {
  late NoPairedDevicesModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoPairedDevicesModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 8.0, 0.0),
                  child: Icon(
                    Icons.devices,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24.0,
                  ),
                ),
                Text(
                  'No paired devices',
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
