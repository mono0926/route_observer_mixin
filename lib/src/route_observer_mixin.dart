import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

mixin RouteObserverMixin<T extends StatefulWidget> on State<T>, RouteAware {
  late GlobalRouteObserver _routeObserver;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _routeObserver = Provider.of(context, listen: false)
      ..subscribe(
        this,
        ModalRoute.of(context)!,
      );
  }

  @override
  void dispose() {
    _routeObserver.unsubscribe(this);
    super.dispose();
  }
}
