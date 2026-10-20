import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

mixin RouteObserverMixin<T extends StatefulWidget> on State<T>, RouteAware {
  GlobalRouteObserver? _routeObserver;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _routeObserver?.unsubscribe(this);
    final route = ModalRoute.of(context);
    if (route != null) {
      _routeObserver = Provider.of<GlobalRouteObserver>(context, listen: false)
        ..subscribe(this, route);
    }
  }

  @override
  void dispose() {
    _routeObserver?.unsubscribe(this);
    super.dispose();
  }
}
