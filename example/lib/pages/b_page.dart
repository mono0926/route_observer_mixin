import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import '../log_view.dart';

class BPage extends StatefulWidget {
  const BPage({Key key}) : super(key: key);

  @override
  _BPageState createState() => _BPageState();
}

class _BPageState extends State<BPage> with RouteAware, RouteObserverMixin {
  Logger get _logger => Provider.of<Logger>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('B Page'),
      ),
    );
  }

  @override
  void didPopNext() => _logger.log('B: didPopNext');

  @override
  void didPush() => _logger.log('B: didPush');

  @override
  void didPop() => _logger.log('B: didPop');

  @override
  void didPushNext() => _logger.log('B: didPushNext');
}
