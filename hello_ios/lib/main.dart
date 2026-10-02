import 'package:flutter/material.dart';

void main() {
  runApp(const HelloIosApp());
}

class HelloIosApp extends StatelessWidget {
  const HelloIosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello iOS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _count = 0;

  void _increment() => setState(() => _count++);
  void _decrement() => setState(() => _count--);
  void _reset() => setState(() => _count = 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello iOS 👋')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('You tapped the button this many times:'),
            const SizedBox(height: 12),
            Text(
              '$_count',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton.filledTonal(
                  onPressed: _decrement,
                  icon: const Icon(Icons.remove),
                  tooltip: 'Decrement',
                ),
                const SizedBox(width: 16),
                IconButton.filled(
                  onPressed: _increment,
                  icon: const Icon(Icons.add),
                  tooltip: 'Increment',
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton(onPressed: _reset, child: const Text('Reset')),
          ],
        ),
      ),
    );
  }
}
