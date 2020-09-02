import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/riverpod.dart' as riverpod;
import 'package:rxdart/rxdart.dart';

final routeObserverProvider = riverpod.Provider(
  (ref) => GlobalRouteObserver(),
);

class RouteObserverProvider extends Provider<GlobalRouteObserver> {
  RouteObserverProvider({
    Key key,
    Create<GlobalRouteObserver> create,
    Widget child,
  }) : super(
          create: create ?? (context) => GlobalRouteObserver(),
          key: key,
          child: child,
        );

  static GlobalRouteObserver of(BuildContext context) => Provider.of(
        context,
        listen: false,
      );
}

class GlobalRouteObserver extends RouteObserver<ModalRoute> {
  BehaviorSubject<NavigationBehavior> _navigation;

  ValueStream<NavigationBehavior> get navigation =>
      (_navigation ??= BehaviorSubject()).stream;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    _navigation?.add(
      NavigationBehavior(
        type: NavigationBehaviorType.didPush,
        route: route,
        previousRoute: previousRoute,
      ),
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    _navigation?.add(
      NavigationBehavior(
        type: NavigationBehaviorType.didPop,
        route: route,
        previousRoute: previousRoute,
      ),
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didRemove(route, previousRoute);
    _navigation?.add(
      NavigationBehavior(
        type: NavigationBehaviorType.didRemove,
        route: route,
        previousRoute: previousRoute,
      ),
    );
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _navigation?.add(
      NavigationBehavior(
        type: NavigationBehaviorType.didReplace,
        route: newRoute,
        previousRoute: oldRoute,
      ),
    );
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    _navigation?.add(
      NavigationBehavior(
        type: NavigationBehaviorType.didStartUserGesture,
        route: route,
        previousRoute: previousRoute,
      ),
    );
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    _navigation?.add(
      NavigationBehavior(
        type: NavigationBehaviorType.didStopUserGesture,
        route: null,
        previousRoute: null,
      ),
    );
  }
}

enum NavigationBehaviorType {
  didPush,
  didPop,
  didRemove,
  didReplace,
  didStartUserGesture,
  didStopUserGesture,
}

class NavigationBehavior {
  NavigationBehavior({
    @required this.type,
    @required this.route,
    @required this.previousRoute,
  });
  final NavigationBehaviorType type;
  final Route<dynamic> route;
  final Route<dynamic> previousRoute;

  @override
  String toString() {
    return 'GlobalRouteEvent{'
        'type: $type, '
        'route: $route, '
        'previousRoute: $previousRoute'
        '}';
  }
}
