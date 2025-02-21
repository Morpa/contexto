import 'package:contexto/contexto.dart';
import 'package:flutter/material.dart';

class AppState {
  final int counter;
  final String name;

  AppState({required this.counter, required this.name});
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Counter and Name')),
        body: AppContext.provider<AppState>(
          value: AppState(counter: 0, name: ''),
          child: const Column(
            children: [
              NameInput(),
              Counter(),
              DisplayInfo(),
            ],
          ),
        ),
      ),
    );
  }
}

class NameInput extends StatelessWidget {
  const NameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = useContext<AppState>(context);
    final setState = useDispatch<AppState>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Type your name',
          border: OutlineInputBorder(),
        ),
        onChanged: (newName) {
          setState(
            AppState(
              counter: appState.counter,
              name: newName,
            ),
          );
        },
      ),
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = useContext<AppState>(context);
    final setState = useDispatch<AppState>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(
              AppState(
                counter: appState.counter - 1,
                name: appState.name,
              ),
            );
          },
          child: const Text('-'),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '${appState.counter}',
            style: const TextStyle(fontSize: 24),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(
              AppState(
                counter: appState.counter + 1,
                name: appState.name,
              ),
            );
          },
          child: const Text('+'),
        ),
      ],
    );
  }
}

class DisplayInfo extends StatelessWidget {
  const DisplayInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = useContext<AppState>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Name: ${appState.name.isEmpty ? "Not informed" : appState.name}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Counter: ${appState.counter}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
