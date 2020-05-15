import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import '../log_view.dart';
import 'b_page.dart';

class APage extends StatefulWidget {
  const APage({Key key}) : super(key: key);

  @override
  _APageState createState() => _APageState();
}

// 3. Add `with RouteAware, RouteObserverMixin` to State
//    and override RouteAware methods.
class _APageState extends State<APage> with RouteAware, RouteObserverMixin {
  Logger get _logger => Provider.of<Logger>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A Page'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => BPage.wrapped(),
              ),
            );
          },
          child: const Text('B Page'),
        ),
      ),
    );
  }

  /// Called when the top route has been popped off, and the current route
  /// shows up.
  @override
  void didPopNext() => _logger.log('A: didPopNext');

  /// Called when the current route has been pushed.
  @override
  void didPush() => _logger.log('A: didPush');

  /// Called when the current route has been popped off.
  @override
  void didPop() => _logger.log('A: didPop');

  /// Called when a new route has been pushed, and the current route is no
  /// longer visible.
  @override
  void didPushNext() => _logger.log('A: didPushNext');
}
