import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/index.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => appStateNotifier.showSplashImage
          ? Builder(
              builder: (context) => Container(
                color: Colors.transparent,
                child: Image.asset(
                  'assets/images/splash.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : OnboardingWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.showSplashImage
              ? Builder(
                  builder: (context) => Container(
                    color: Colors.transparent,
                    child: Image.asset(
                      'assets/images/splash.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : OnboardingWidget(),
        ),
        FFRoute(
          name: 'Entry',
          path: '/entry',
          builder: (context, params) => EntryWidget(),
        ),
        FFRoute(
          name: 'Devices',
          path: '/devices',
          builder: (context, params) => DevicesWidget(
            isBTEnabled: params.getParam('isBTEnabled', ParamType.bool),
          ),
        ),
        FFRoute(
          name: 'Device',
          path: '/device',
          builder: (context, params) => DeviceWidget(
            deviceName: params.getParam('deviceName', ParamType.String),
            deviceId: params.getParam('deviceId', ParamType.String),
            deviceRssi: params.getParam('deviceRssi', ParamType.int),
            hasWriteCharacteristics:
                params.getParam('hasWriteCharacteristics', ParamType.bool),
            deviceType: params.getParam('deviceType', ParamType.String),
            deviceConnectable:
                params.getParam('deviceConnectable', ParamType.bool),
          ),
        ),
        FFRoute(
          name: 'GravarLocalization',
          path: '/gravarLocalization',
          builder: (context, params) => GravarLocalizationWidget(
            nomeDispositivo:
                params.getParam('nomeDispositivo', ParamType.String),
            idDispositivo: params.getParam('idDispositivo', ParamType.String),
            rssiDispositivo: params.getParam('rssiDispositivo', ParamType.int),
            tipoDoDispositivo:
                params.getParam('tipoDoDispositivo', ParamType.String),
            conectable: params.getParam('conectable', ParamType.bool),
            serviceUUID: params.getParam('serviceUUID', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'Motor',
          path: '/motor',
          builder: (context, params) => MotorWidget(
            nomeDispositivo:
                params.getParam('nomeDispositivo', ParamType.String),
            idDispositivo: params.getParam('idDispositivo', ParamType.String),
            rssi: params.getParam('rssi', ParamType.int),
            characteristicUUID:
                params.getParam('characteristicUUID', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'ServiceCharacteristics',
          path: '/serviceCharacteristics',
          builder: (context, params) => ServiceCharacteristicsWidget(
            nomeDispositivo:
                params.getParam('nomeDispositivo', ParamType.String),
            idDispositivo: params.getParam('idDispositivo', ParamType.String),
            rssiDispositivo: params.getParam('rssiDispositivo', ParamType.int),
            serviceUuid: params.getParam('serviceUuid', ParamType.String),
            serviceName: params.getParam('serviceName', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'Timestamp',
          path: '/timestamp',
          builder: (context, params) => TimestampWidget(
            nomeDispositivo:
                params.getParam('nomeDispositivo', ParamType.String),
            idDispositivo: params.getParam('idDispositivo', ParamType.String),
            type: params.getParam('type', ParamType.String),
            serviceUUID: params.getParam('serviceUUID', ParamType.String),
            rssi: params.getParam('rssi', ParamType.int),
          ),
        ),
        FFRoute(
          name: 'LineStatus',
          path: '/lineStatus',
          builder: (context, params) => LineStatusWidget(
            nomeDispositivo:
                params.getParam('nomeDispositivo', ParamType.String),
            idDispositivo: params.getParam('idDispositivo', ParamType.String),
            rssi: params.getParam('rssi', ParamType.int),
            type: params.getParam('type', ParamType.String),
            serviceUUID: params.getParam('serviceUUID', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'DeviceInformation',
          path: '/deviceInformation',
          builder: (context, params) => DeviceInformationWidget(
            nomeDispositivo:
                params.getParam('nomeDispositivo', ParamType.String),
            idDispositivo: params.getParam('idDispositivo', ParamType.String),
            rssi: params.getParam('rssi', ParamType.int),
            type: params.getParam('type', ParamType.String),
            serviceUUID: params.getParam('serviceUUID', ParamType.String),
          ),
        ),
        FFRoute(
          name: 'Onboarding',
          path: '/onboarding',
          builder: (context, params) => OnboardingWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
    List<String>? collectionNamePath,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(param, type, isList,
        collectionNamePath: collectionNamePath);
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouter.of(context).location;
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}
