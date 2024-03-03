import 'repository_exception.dart';

/// [TokenException] providing the error codes for the token repository.
class TokenException extends RepositoryException<TokenExceptionCode> {
  /// Creates a new [TokenException].
  const TokenException({required super.errorCode});
}

/// [TokenExceptionCode] providing the error codes for different exceptions.
enum TokenExceptionCode {
  /// When the token can't be read from the device.
  localReadFailed,

  /// When the token can't be stored on the device.
  localSaveFailed,

  /// When the token can't be removed from the device.
  localRemoveFailed,
}
