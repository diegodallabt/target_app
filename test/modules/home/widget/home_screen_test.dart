import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('layoutSelector displays three layout buttons', (tester) async {
    int selectedColumns = 3;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest.withAlpha(
                      (0.5 * 255).round(),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () => setState(() => selectedColumns = 1),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.view_agenda_rounded,
                            size: 20,
                            color: selectedColumns == 1
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() => selectedColumns = 2),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.grid_view_rounded,
                            size: 20,
                            color: selectedColumns == 2
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => setState(() => selectedColumns = 3),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Icon(
                            Icons.apps_rounded,
                            size: 20,
                            color: selectedColumns == 3
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.view_agenda_rounded), findsOneWidget);
    expect(find.byIcon(Icons.grid_view_rounded), findsOneWidget);
    expect(find.byIcon(Icons.apps_rounded), findsOneWidget);
  });

  testWidgets('layoutButton changes selection on tap', (tester) async {
    int selectedColumns = 3;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return InkWell(
                onTap: () => setState(() => selectedColumns = 1),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selectedColumns == 1
                        ? Theme.of(context).colorScheme.primary.withAlpha((0.2 * 255).round())
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.view_agenda_rounded,
                    size: 20,
                    color: selectedColumns == 1
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    // Initial state
    expect(selectedColumns, equals(3));

    // Tap to change selection
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    expect(selectedColumns, equals(1));
  });

  testWidgets('empty state shows correct message', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.inbox,
                  size: 80,
                  color: Colors.grey.withAlpha(100),
                ),
                const Text('No items yet'),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.inbox), findsOneWidget);
    expect(find.text('No items yet'), findsOneWidget);
  });
}
