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
                builder: (context) => const BPage(),
              ),
            );
          },
          child: const Text('B Page'),
        ),
      ),
    );
  }

  @override
  void didPopNext() => _logger.log('A: didPopNext');

  @override
  void didPush() => _logger.log('A: didPush');

  @override
  void didPop() => _logger.log('A: didPop');

  @override
  void didPushNext() => _logger.log('A: didPushNext');
}
