library contexto;

import 'package:flutter/material.dart';

/// A generic class that provides a context for the application.
///
/// The `AppContext` class is used to create providers that can hold and manage
/// state of type [T] throughout the widget tree.
///
/// Example:
/// ```dart
/// AppContext<String>.provider(
///   value: 'Hello',
///   child: MyWidget(),
/// )
/// ```
///
/// See also:
///
///  * [AppProvider], which is created by this class's provider method.
class AppContext<T> {
  static AppProvider<T> provider<T>({
    required T value,
    required Widget child,
    Key? key,
  }) {
    return AppProvider<T>(
      key: key,
      initialValue: value,
      child: child,
    );
  }
}

/// A provider widget that manages a value of type [T] and makes it available to its descendants.
///
/// The [AppProvider] widget allows you to store and update a value of any type [T],
/// which can be accessed by descendant widgets through an [InheritedWidget].
///
/// Example:
/// ```dart
/// AppProvider<int>(
///   initialValue: 0,
///   child: MyWidget(),
/// )
/// ```
///
/// Parameters:
/// * [initialValue] - The initial value of type [T] to be stored in the provider.
/// * [child] - The widget below this widget in the tree.
///
/// The value can be updated using the [setValue] method, which will trigger a rebuild
/// of all dependent widgets.
class AppProvider<T> extends StatefulWidget {
  final T initialValue;
  final Widget child;

  const AppProvider({
    super.key,
    required this.initialValue,
    required this.child,
  });

  @override
  State<AppProvider<T>> createState() => _AppProviderState<T>();
}

class _AppProviderState<T> extends State<AppProvider<T>> {
  late T value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  void setValue(T newValue) {
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedContext<T>(
      context: AppContext<T>(),
      value: value,
      setValue: setValue,
      child: widget.child,
    );
  }
}

/// Returns the current value of type [T] from the nearest [AppContext.Provider].
///
/// This hook allows components to access the value stored in a [AppContext.Provider] higher up in the widget tree.
///
/// Throws an [Exception] if no [AppContext.Provider] of type [T] is found in the widget tree.
///
/// Example:
/// ```dart
/// final value = useContext<int>(context);
/// print(value); // Prints the current value stored in the nearest Provider<int>
/// ```
///
/// [T] The type of value to retrieve from the Provider
/// [context] The BuildContext used to find the nearest Provider
/// Returns the current value of type [T] from the provider
T useContext<T>(BuildContext context) {
  final provider =
      context.dependOnInheritedWidgetOfExactType<_InheritedContext<T>>();
  if (provider == null) {
    throw Exception("No AppContext.Provider found for type $T");
  }
  return provider.value;
}

/// Returns a function that dispatches values of type [T] to the nearest [AppContext.Provider].
///
/// This hook allows components to update the value in a [AppContext.Provider] higher up in the widget tree.
///
/// The returned function takes a value of type [T] and updates the provider's state.
///
/// Throws an [Exception] if no [AppContext.Provider] of type [T] is found in the widget tree.
///
/// Example:
/// ```dart
/// final dispatch = useDispatch<int>(context);
/// dispatch(42); // Updates the value in the nearest Provider<int>
/// ```
///
/// [T] The type of value managed by the target Provider
/// [context] The BuildContext used to find the nearest Provider
/// Returns a function that accepts and dispatches values of type [T]
Function(T) useDispatch<T>(BuildContext context) {
  final provider =
      context.dependOnInheritedWidgetOfExactType<_InheritedContext<T>>();
  if (provider == null) {
    throw Exception("No AppContext.Provider found for type $T");
  }
  return provider.setValue;
}

class _InheritedContext<T> extends InheritedWidget {
  final AppContext<T> context;
  final T value;
  final Function(T) setValue;

  const _InheritedContext({
    super.key,
    required this.context,
    required this.value,
    required this.setValue,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedContext<T> oldWidget) {
    return oldWidget.value != value;
  }
}
