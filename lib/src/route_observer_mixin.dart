import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

mixin RouteObserverMixin<T extends StatefulWidget> on State<T>, RouteAware {
  GlobalRouteObserver? _routeObserver;
  ModalRoute<dynamic>? _route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final route = ModalRoute.of(context);
    final routeObserver = route == null
        ? null
        : Provider.of<GlobalRouteObserver>(context, listen: false);
    if (_routeObserver == routeObserver && _route == route) {
      return;
    }

    _routeObserver?.unsubscribe(this);
    _routeObserver = routeObserver;
    _route = route;
    if (routeObserver != null && route != null) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    _routeObserver?.unsubscribe(this);
    super.dispose();
  }
}
