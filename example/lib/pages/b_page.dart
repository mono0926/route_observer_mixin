import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import '../log_view.dart';

class BPage extends StatelessWidget {
  const BPage._({Key? key}) : super(key: key);

  static Widget wrapped() {
    return MultiProvider(
      providers: [
        // Wrap by RouteAwareProvider
        const RouteAwareProvider(),
        StateNotifierProvider<BPageController, BPageState>(
          create: (context) => BPageController(),
        )
      ],
      child: const BPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('B Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.select(
                (BPageState s) =>
                    'Last Event: ${EnumToString.convertToString(s.event)}',
              ),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('NEXT'),
              onPressed: () {
                Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: const Text('C Page'),
                      ),
                    ),
                    settings: const RouteSettings(name: 'C'),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('LOG LATEST NAVIGATION'),
              onPressed: () {
                final route =
                    RouteObserverProvider.of(context).navigation.valueOrNull;
                context.read<Logger>().log('route: $route');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BPageController extends StateNotifier<BPageState> with LocatorMixin {
  BPageController() : super(const BPageState());

  RouteAwareObserver get _routeAwareObserver => read();
  Logger get _logger => read();

  @override
  void initState() {
    super.initState();
    // RouteAwareObserver doesn't support `didPush` event,
    // but `initState` is called at about the same time.
    _logger.log('B: ${EnumToString.convertToString(state.event)}');
    // Listen RouteAwareObserver RouteAwareEvent stream
    _routeAwareObserver.stream.listen((event) {
      state = BPageState(event);
      _logger.log('B: ${EnumToString.convertToString(state.event)}');
    });
  }
}

class BPageState {
  // `didPush` of [RouteAware] isn't supported, so set by hand initially.
  const BPageState([this.event = RouteAwareEvent.didPush]);

  final RouteAwareEvent event;
}
