import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import 'log_view.dart';
import 'pages/pages.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // 1. Wrap MaterialApp with RouteObserverProvider.
        RouteObserverProvider(
          // ignore: avoid_print
          create: (context) => GlobalRouteObserver()..navigation.listen(print),
        ),
        ChangeNotifierProvider(create: (context) => Logger())
      ],
      child: const App(),
    ),
  );

  // Of course, this is also ok.
  // I demonstrated that [MultiProvider] can be used for RouteObserverProvider👍

  /*
  runApp(
    RouteObserverProvider(
      child: const App(),
    ),
  );
  */
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: MaterialApp(
            // 2. Pass RouteObserverProvider.of(context) to navigatorObservers.
            navigatorObservers: [RouteObserverProvider.of(context)],
            home: const APage(),
          ),
        ),
        const SizedBox(
          height: 300,
          child: LogView(),
        ),
      ],
    );
  }
}
