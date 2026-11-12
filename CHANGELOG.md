## 1.9.1 - 2026-11-12

### Bug Fixes
- Fix formatting so that pub.dev static analysis passes (pana 160/160)

## 1.9.0 - 2026-11-12

### Features
- Upgrade SDK requirements to Dart `^3.14.0` and Flutter `>=3.50.0`
- Upgrade `disposable_provider` to `^2.5.0`, `provider` to `^6.1.5`, `riverpod` to `^3.5.0`, and `rxdart` to `^0.28.0`
- Migrate example app to `material_ui`

### Bug Fixes
- Avoid spurious `didPush` re-invocation in `RouteObserverMixin.didChangeDependencies` when neither `ModalRoute` nor `GlobalRouteObserver` has changed
- Update `RouteAwareObserver` to `implements Disposable` for Dart 3 class modifier compatibility

## 1.8.2 - 2026-10-20

### Bug Fixes
- Safely unsubscribe previous `GlobalRouteObserver` before re-subscribing in `didChangeDependencies` and guard against null `ModalRoute`
- Fix `RouteAwareProvider.of` error message

## 1.8.1

- Add AI Agent Skill (`route_observer_mixin-route-awareness`)
- Replace deprecated `@required` with language keyword `required`

## 1.8.0

- Use riverpod ^3.0.0

## 1.7.0

- Use riverpod '>=1.0.0-0 <3.0.0'

## 1.6.0

- Stable release

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
