import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'onboarding_model.dart';
export 'onboarding_model.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({Key? key}) : super(key: key);

  @override
  _OnboardingWidgetState createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  late OnboardingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OnboardingModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setDarkModeSetting(context, ThemeMode.dark);
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
        body: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).primaryBackground,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.network(
                'https://images.unsplash.com/photo-1521618755572-156ae0cdd74d?auto=format&fit=crop&q=80&w=2076&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              ).image,
            ),
          ),
          child: Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              color: Color(0xA1262D34),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'WP Tracker\nConfigurator',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context)
                            .headlineLarge
                            .override(
                              fontFamily: 'Montserrat',
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 36.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Wireless Precision',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).titleLarge.override(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 8.0, 24.0, 0.0),
                      child: Text(
                        'Soluções de Monitoramento e Gestão de Ativos',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'DM Sans',
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 44.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          context.pushNamed('Entry');
                        },
                        text: 'Entrar',
                        options: FFButtonOptions(
                          width: 200.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'DM Sans',
                                    color: Colors.white,
                                  ),
                          elevation: 2.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(40.0),
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
