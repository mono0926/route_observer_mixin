import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogView extends StatelessWidget {
  const LogView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final logger = Provider.of<Logger>(context);
    const color = Colors.black;
    return WidgetsApp(
      debugShowCheckedModeBanner: false,
      color: color,
      builder: (_, __) => ColoredBox(
        color: color,
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: logger.logs.reversed
              .map((log) => Text(
                    log,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class Logger extends ChangeNotifier {
  final _logs = <String>[];

  List<String> get logs => _logs;

  void log(String log) {
    // ignore: avoid_print
    print(log);
    _logs.add(log);
    WidgetsBinding.instance.addPostFrameCallback((_) => notifyListeners());
  }
}
