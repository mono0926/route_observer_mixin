import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

class const _TrackPage({
  required final List<String> events,
  required final String label,
}) extends StatefulWidget {
  @override
  State<_TrackPage> createState() => _TrackPageState();
}

class _TrackPageState()
    extends State<_TrackPage>
    with RouteAware, RouteObserverMixin {
  @override
  Widget build(BuildContext context) => Text(widget.label);

  @override
  void didPush() => widget.events.add('${widget.label}:didPush');

  @override
  void didPushNext() => widget.events.add('${widget.label}:didPushNext');

  @override
  void didPopNext() => widget.events.add('${widget.label}:didPopNext');

  @override
  void didPop() => widget.events.add('${widget.label}:didPop');
}

Route<void> _route(String name, Widget child) {
  return PageRouteBuilder<void>(
    settings: RouteSettings(name: name),
    pageBuilder: (context, animation, secondaryAnimation) => child,
  );
}

void main() {
  testWidgets(
    'RouteObserverMixin receives didPush, didPushNext, didPopNext, and didPop',
    (tester) async {
      final events = <String>[];
      final navigatorKey = GlobalKey<NavigatorState>();
      final navigationBehaviors = <NavigationBehavior>[];

      await tester.pumpWidget(
        RouteObserverProvider(
          create: (_) =>
              GlobalRouteObserver()..navigation.listen(navigationBehaviors.add),
          child: Builder(
            builder: (context) {
              return WidgetsApp(
                navigatorKey: navigatorKey,
                color: const Color(0xFF000000),
                navigatorObservers: [RouteObserverProvider.of(context)],
                onGenerateRoute: (_) => _route(
                  'A',
                  _TrackPage(events: events, label: 'A'),
                ),
              );
            },
          ),
        ),
      );

      expect(events, ['A:didPush']);
      expect(
        navigationBehaviors.map((e) => e.type),
        [NavigationBehaviorType.didPush],
      );

      navigatorKey.currentState!.push<void>(
        _route('B', _TrackPage(events: events, label: 'B')),
      );
      await tester.pumpAndSettle();

      expect(events, ['A:didPush', 'A:didPushNext', 'B:didPush']);
      expect(
        navigationBehaviors.last.type,
        NavigationBehaviorType.didPush,
      );

      navigatorKey.currentState!.pop<void>();
      await tester.pumpAndSettle();

      expect(
        events,
        [
          'A:didPush',
          'A:didPushNext',
          'B:didPush',
          'A:didPopNext',
          'B:didPop',
        ],
      );
      expect(
        navigationBehaviors.last.type,
        NavigationBehaviorType.didPop,
      );
    },
  );

  testWidgets(
    'RouteAwareProvider emits RouteAwareEvent on route transitions',
    (tester) async {
      final events = <RouteAwareEvent>[];
      final navigatorKey = GlobalKey<NavigatorState>();

      await tester.pumpWidget(
        RouteObserverProvider(
          child: Builder(
            builder: (context) {
              return WidgetsApp(
                navigatorKey: navigatorKey,
                color: const Color(0xFF000000),
                navigatorObservers: [RouteObserverProvider.of(context)],
                onGenerateRoute: (_) => _route(
                  'home',
                  RouteAwareProvider(
                    child: Builder(
                      builder: (context) {
                        RouteAwareProvider.of(context).stream
                            .listen(events.add);
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );

      navigatorKey.currentState!.push<void>(
        _route('detail', const SizedBox.shrink()),
      );
      await tester.pumpAndSettle();

      expect(events, [RouteAwareEvent.didPushNext]);

      navigatorKey.currentState!.pop<void>();
      await tester.pumpAndSettle();

      expect(events, [RouteAwareEvent.didPushNext, RouteAwareEvent.didPopNext]);
    },
  );

  testWidgets(
    'RouteAwareProvider.of throws FlutterError when missing',
    (tester) async {
      late BuildContext capturedContext;

      await tester.pumpWidget(
        Builder(
          builder: (context) {
            capturedContext = context;
            return const SizedBox.shrink();
          },
        ),
      );

      expect(
        () => RouteAwareProvider.of(capturedContext),
        throwsFlutterError,
      );
    },
  );

  test('routeObserverProvider provides GlobalRouteObserver', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final observer = container.read(routeObserverProvider);
    expect(observer, isA<GlobalRouteObserver>());
  });
}
