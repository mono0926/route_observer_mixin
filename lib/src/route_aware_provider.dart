import 'dart:async';

import 'package:disposable_provider/disposable_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

class RouteAwareProvider extends SingleChildStatelessWidget {
  const RouteAwareProvider({
    Key key,
    Widget child,
  }) : super(
          key: key,
          child: child,
        );

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return _RouteAwareWidget(
      child: child,
    );
  }

  /// Thin wrapper of Provider.of
  static RouteAwareObserver of(BuildContext context) {
    try {
      return Provider.of<RouteAwareObserver>(context, listen: false);
      // ignore: avoid_catches_without_on_clauses
    } catch (error) {
      throw FlutterError(
        '''
        TickerProvider.of() called with a context that does not contain
        a Disposable of type TickerProvider.
        The context used was: $context
        Error: $error
        ''',
      );
    }
  }
}

class _RouteAwareWidget extends SingleChildStatefulWidget {
  const _RouteAwareWidget({
    Key key,
    Widget child,
  }) : super(
          key: key,
          child: child,
        );
  @override
  _RouteAwareWidgetState createState() => _RouteAwareWidgetState();
}

class _RouteAwareWidgetState extends SingleChildState<_RouteAwareWidget>
    with RouteAware, RouteObserverMixin {
  final _observer = RouteAwareObserver();

  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return Provider.value(
      value: _observer,
      child: child,
    );
  }

  @override
  void dispose() {
    _observer.dispose();
    super.dispose();
  }

  @override
  void didPushNext() =>
      _observer._streamController.add(RouteAwareEvent.didPushNext);

  @override
  void didPop() => _observer._streamController.add(RouteAwareEvent.didPop);

  @override
  void didPopNext() =>
      _observer._streamController.add(RouteAwareEvent.didPopNext);

  // This doesn't make sense because stream listener cannot listen before
  // didPush is called.
  @override
  void didPush() => _observer._streamController.add(RouteAwareEvent.didPush);
}

class RouteAwareObserver with Disposable {
  final _streamController = StreamController<RouteAwareEvent>.broadcast();

  Stream<RouteAwareEvent> get stream => _streamController.stream;

  @override
  void dispose() {
    _streamController.close();
  }
}

/// `didPush` of [RouteAware] isn't supported.
enum RouteAwareEvent {
  didPushNext,
  didPop,
  didPopNext,
  didPush,
}
