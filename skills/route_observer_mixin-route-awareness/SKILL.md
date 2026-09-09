---
name: route_observer_mixin-route-awareness
description: >-
  Use when tracking Flutter screen navigation lifecycle events (screen focus, push, pop, backgrounding)
  using route_observer_mixin without boilerplate subscription management.
---

# route_observer_mixin Screen Tracking Guide

`route_observer_mixin` eliminates manual registration and disposal of Flutter `RouteObserver` and `RouteAware` subscriptions. It provides clean, declarative hooks for page lifecycle transitions (`didPush`, `didPop`, `didPushNext`, `didPopNext`).

## Guidelines

- **Setup in Navigator**:
  - Wrap your app with `RouteObserverProvider` above `MaterialApp` (or provide it via `provider` / `riverpod`).
  - Pass `RouteObserverProvider.of(context)` (or the provider's instance) to `MaterialApp.navigatorObservers`.
- **Implementing in State**:
  - Add `with RouteAware, RouteObserverMixin` to the target `State<MyWidget>` class.
  - Implement lifecycle methods:
    - `didPush()`: Called when the screen has been pushed and is now visible.
    - `didPopNext()`: Called when the top route has been popped off, and this screen becomes visible again.
    - `didPushNext()`: Called when a new route is pushed on top of this screen (this screen becomes obscured).
    - `didPop()`: Called when this screen has been popped off the navigator.
- **Analytics & Tracking**:
  - Track screen views inside `didPush()` and `didPopNext()` to accurately capture when the user returns to a previously viewed page.
- **Lifecycle Cleanup**:
  - Do not manually call `routeObserver.unsubscribe(this)`. `RouteObserverMixin` automatically manages subscription registration in `didChangeDependencies` and unsubscription in `dispose`.

## Examples

### 1. App Setup

```dart
import 'package:flutter/material.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

void main() {
  runApp(
    RouteObserverProvider(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        RouteObserverProvider.of(context),
      ],
      home: const HomeScreen(),
    );
  }
}
```

### 2. Page Implementation with Analytics Tracking

```dart
import 'package:flutter/material.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with RouteAware, RouteObserverMixin {

  @override
  void didPush() {
    super.didPush();
    // Screen is pushed for the first time
    _trackScreenView();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // User returned back to this screen from a pushed page
    _trackScreenView();
    _refreshContent();
  }

  @override
  void didPushNext() {
    super.didPushNext();
    // Another screen was pushed on top of this screen
    _pauseMediaPlayback();
  }

  void _trackScreenView() {
    debugPrint('Analytics: Screen viewed -> HomeScreen');
  }

  void _refreshContent() {
    debugPrint('Refreshing active screen data');
  }

  void _pauseMediaPlayback() {
    debugPrint('Pausing background video/audio');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const DetailScreen()),
          ),
          child: const Text('Go to Details'),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Details')),
      );
}
```

## Common Pitfalls & Anti-Patterns

- ❌ **Anti-pattern**: Manually managing `RouteObserver().subscribe(this, ModalRoute.of(context)!)` inside `didChangeDependencies`, which frequently leaks subscriptions if unsubscription is missed in `dispose`.
  - ✔️ **Correct**: Use `RouteObserverMixin`, which handles registration and unsubscription safely and deterministically.
- ❌ **Anti-pattern**: Only tracking screen view analytics in `initState`, which fails to capture when users navigate back to the page via the back button.
  - ✔️ **Correct**: Track screen views in both `didPush()` and `didPopNext()`.
