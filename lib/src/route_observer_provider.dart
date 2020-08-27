import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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
  StreamController<GlobalRouteEvent> _event;

  Stream<GlobalRouteEvent> get event =>
      (_event ??= StreamController.broadcast()).stream;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    _event?.add(
      GlobalRouteEvent(
        type: GlobalRouteEventType.didPush,
        route: route,
        previousRoute: previousRoute,
      ),
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    _event?.add(
      GlobalRouteEvent(
        type: GlobalRouteEventType.didPop,
        route: route,
        previousRoute: previousRoute,
      ),
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didRemove(route, previousRoute);
    _event?.add(
      GlobalRouteEvent(
        type: GlobalRouteEventType.didRemove,
        route: route,
        previousRoute: previousRoute,
      ),
    );
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _event?.add(
      GlobalRouteEvent(
        type: GlobalRouteEventType.didReplace,
        route: newRoute,
        previousRoute: oldRoute,
      ),
    );
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    _event?.add(
      GlobalRouteEvent(
        type: GlobalRouteEventType.didStartUserGesture,
        route: route,
        previousRoute: previousRoute,
      ),
    );
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    _event?.add(
      GlobalRouteEvent(
        type: GlobalRouteEventType.didStopUserGesture,
        route: null,
        previousRoute: null,
      ),
    );
  }
}

enum GlobalRouteEventType {
  didPush,
  didPop,
  didRemove,
  didReplace,
  didStartUserGesture,
  didStopUserGesture,
}

class GlobalRouteEvent {
  GlobalRouteEvent({
    @required this.type,
    @required this.route,
    @required this.previousRoute,
  });
  final GlobalRouteEventType type;
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
