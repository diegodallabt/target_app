import 'package:uuid/uuid.dart';

class IdGenerator {
  static const _uuid = Uuid();

  static String generateId() {
    final uuid = _uuid.v4().replaceAll('-', '');
    return uuid.substring(0, 24);
  }

  static String generateUuid() {
    return _uuid.v4();
  }
}
