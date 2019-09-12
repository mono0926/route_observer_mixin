import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class RouteObserverProvider extends Provider<RouteObserver<ModalRoute>> {
  RouteObserverProvider({
    Key key,
    Widget child,
  }) : super(
          builder: (context) => RouteObserver<ModalRoute>(),
          key: key,
          child: child,
        );

  static RouteObserver<ModalRoute> of(BuildContext context) =>
      Provider.of<RouteObserver<ModalRoute>>(
        context,
        listen: false,
      );
}
