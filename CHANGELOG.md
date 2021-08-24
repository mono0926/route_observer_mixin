## 1.6.0-dev+1

- Update Provider

## 1.6.0-dev

- Update hooks_riverpod to v1

## 1.5.1

- Upgrade Provider

## 1.5.0

- Migrate to null safety

## 1.4.2

- Add routeObserverProvider for Riverpod

## 1.4.1

- Change `navigation` of `GlobalRouteObserver` to ValueStream

## 1.4.0

- Rename to NavigationBehavior from GlobalRouteEvent

## 1.3.0

- Rename event of GlobalRouteObserver to navigation

## 1.2.2

- Add didRemove/didReplace/didStartUserGesture/didStopUserGesture to GlobalRouteEventType

## 1.2.1

- Add GlobalRouteObserver, which extends RouteObserver<ModalRoute> and it exposes didPush/didPop stream.

## 1.2.0

- Add `RouteAwareProvider`, which offers RouteAwareEvent stream
  - Re-write [BPage example](https://github.com/mono0926/route_observer_mixin/blob/master/example/lib/pages/b_page.dart) by using `RouteAwareProvider`

## 1.1.1

- Fix didChangeDependencies

## 1.1.0

- Update provider to ^4.0.0

## 1.0.2

- Fix warning

## 1.0.1

- Fix provider usage (value -> builder)

## 1.0.0

- Add RouteObserverProvider/RouteObserverMixin and its example.
