# Contexto

A simple library to avoid prop drilling in Flutter using a context system similar to Context API from React.

## ✨ Features

- Provision of status via `AppContext.provider`.
- Easy access to status with `useContext<T>(context)`.
- Dispatch function with `useDispatch<T>(context)`.
- Automatic updates for dependent widgets.

## 📦 Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  contexto: ^1.0.0
```

Run the command to install the package:

```sh
dart pub get
```

## 🚀 How to use

### Creating a Context Provider

Wrap the widgets that need to access the state or value inside an `AppContext.provider`.

```dart
import 'package:contexto/contexto.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppContext.provider<int>(
        value: 0,
        child: CounterScreen(),
      ),
    );
  }
}
```

### Accessing and updating values

Use `useContext<T>(context)` to access the state/value and `useDispatch<T>(context)` to update it.

```dart
class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counter = useContext<int>(context);
    final setCounter = useDispatch<int>(context);
    
    return Scaffold(
      appBar: AppBar(title: Text("Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Value: \$counter", style: TextStyle(fontSize: 24)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => setCounter(counter - 1),
                  icon: Icon(Icons.remove),
                ),
                IconButton(
                  onPressed: () => setCounter(counter + 1),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

## 🛠 API

### `AppContext.provider<T>`

A provider that makes a value available to descendant widgets without the need for prop drilling.

**Parameters:**

- `value` (T): Initial value.
- `child` (Widget): The child widget that will access the value.

### `useContext<T>(context)`

Returns the value of type `T` from the nearest provider.

**Use:**

```dart
final value = useContext<MyType>(context);
```

### `useDispatch<T>(context)`

Returns a function to update the value of type `T` in the nearest provider.

**Use:**

```dart
final dispatch = useDispatch<int>(context);
dispatch(42); // Updates the state to 42
```

## 🧪 Tests

To run the tests, execute the command:

```sh
dart test
```

## 🚀 Contributing

Contributions are welcome! Please submit pull requests with any improvements or bug fixes.

## 📝 License

This project is licensed under the BSD 3 License - see the [LICENSE](LICENSE) file for details.

