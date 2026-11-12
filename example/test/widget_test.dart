import 'package:example/log_view.dart';
import 'package:example/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

void main() {
  testWidgets('Example app navigation smoke test', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          RouteObserverProvider(),
          ChangeNotifierProvider(create: (_) => Logger()),
        ],
        child: const App(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('A Page'), findsOneWidget);
    expect(find.text('A: didPush'), findsOneWidget);

    await tester.tap(find.text('B Page'));
    await tester.pumpAndSettle();

    expect(find.text('B Page'), findsOneWidget);
    expect(find.text('Last Event: didPush'), findsOneWidget);
  });
}
