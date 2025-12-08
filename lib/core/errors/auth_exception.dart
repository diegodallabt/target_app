abstract class AuthException implements Exception {
  final String message;
  final String _code;

  AuthException(this.message, this._code);

  String get code => _code;

  @override
  String toString() => 'AuthException($code): $message';
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException()
      : super(
          'Usuário ou senha inválidos',
          'INVALID_CREDENTIALS',
        );
}

class UserAlreadyExistsException extends AuthException {
  UserAlreadyExistsException()
      : super(
          'Este nome de usuário já está em uso',
          'USER_ALREADY_EXISTS',
        );
}

class InvalidUsernameException extends AuthException {
  InvalidUsernameException(int minLength)
      : super(
          'O nome de usuário deve ter no mínimo $minLength caracteres',
          'INVALID_USERNAME',
        );
}

class InvalidPasswordException extends AuthException {
  InvalidPasswordException(int minLength)
      : super(
          'A senha deve ter no mínimo $minLength caracteres',
          'INVALID_PASSWORD',
        );
}

class InvalidNameException extends AuthException {
  InvalidNameException(int minLength)
      : super(
          'O nome deve ter no mínimo $minLength caracteres',
          'INVALID_NAME',
        );
}

class PasswordsDoNotMatchException extends AuthException {
  PasswordsDoNotMatchException()
      : super(
          'As senhas não coincidem',
          'PASSWORDS_DO_NOT_MATCH',
        );
}

class UserNotFoundException extends AuthException {
  UserNotFoundException()
      : super(
          'Usuário não encontrado',
          'USER_NOT_FOUND',
        );
}

class SessionExpiredException extends AuthException {
  SessionExpiredException()
      : super(
          'Sessão expirada. Faça login novamente',
          'SESSION_EXPIRED',
        );
}

class AuthStorageException extends AuthException {
  AuthStorageException()
      : super(
          'Erro ao acessar o armazenamento',
          'STORAGE_ERROR',
        );
}
