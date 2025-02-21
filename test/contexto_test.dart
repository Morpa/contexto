import 'package:contexto/contexto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppContext', () {
    group('useContext', () {
      testWidgets('should get value correctly', (tester) async {
        const initialValue = 'test';
        var value = '';

        await tester.pumpWidget(
          MaterialApp(
            home: AppContext.provider<String>(
              value: initialValue,
              child: Builder(
                builder: (context) {
                  value = useContext<String>(context);
                  return const SizedBox();
                },
              ),
            ),
          ),
        );

        expect(value, equals(initialValue));
      });

      testWidgets('should throw when provider not found', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                expect(
                  () => useContext<String>(context),
                  throwsException,
                );
                return const SizedBox();
              },
            ),
          ),
        );
      });
    });

    group('useDispatch', () {
      testWidgets('should update value correctly', (tester) async {
        const initialValue = 'test';
        const newValue = 'updated';
        var value = '';

        await tester.pumpWidget(
          MaterialApp(
            home: AppContext.provider<String>(
              value: initialValue,
              child: Builder(
                key: const Key('test-builder'),
                builder: (context) {
                  value = useContext<String>(context);
                  final dispatch = useDispatch<String>(context);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    dispatch(newValue);
                  });
                  return const SizedBox();
                },
              ),
            ),
          ),
        );

        expect(value, equals(initialValue));
        await tester.pump();
        value = useContext<String>(
          tester.element(find.byKey(const Key('test-builder'))),
        );
        expect(value, equals(newValue));
      });

      testWidgets('should throw when provider not found', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                expect(
                  () => useDispatch<String>(context),
                  throwsException,
                );
                return const SizedBox();
              },
            ),
          ),
        );
      });
    });
  });
}
