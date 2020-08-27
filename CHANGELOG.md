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