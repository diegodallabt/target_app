import 'package:flutter_test/flutter_test.dart';
import 'package:target_app/core/utils/id_generator.dart';

void main() {
  group('IdGenerator', () {
    test('generateId should return a 24 character string', () {
      final id = IdGenerator.generateId();

      expect(id, isNotEmpty);
      expect(id.length, equals(24));
    });

    test('generateId should return unique IDs', () {
      final id1 = IdGenerator.generateId();
      final id2 = IdGenerator.generateId();
      final id3 = IdGenerator.generateId();

      expect(id1, isNot(equals(id2)));
      expect(id1, isNot(equals(id3)));
      expect(id2, isNot(equals(id3)));
    });

    test('generateId should return hexadecimal characters only', () {
      final id = IdGenerator.generateId();
      final hexPattern = RegExp(r'^[0-9a-f]{24}$');

      expect(hexPattern.hasMatch(id), isTrue);
    });

    test('generateId should generate multiple unique IDs in sequence', () {
      final ids = List.generate(100, (_) => IdGenerator.generateId());
      final uniqueIds = ids.toSet();

      expect(uniqueIds.length, equals(100));
    });
  });
}
