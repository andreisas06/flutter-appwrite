import '../entities/auth/token.dart';

/// A repository to handle authenticating a user.
abstract interface class AuthenticationRepository {
  /// Signs in a user with their given [email] and [password].
  ///
  /// Returns a [Token] if the sign in was successful.
  /// Throws an exception if the sign in failed.
  Future<Token> signIn({
    required String email,
    required String password,
  });

  /// Ends a users session by revoking the [token].
  Future<void> endSession(Token token);

  /// Refreshes the current [token].
  ///
  /// Returns a new [Token] if the refresh was successful.
  /// Throws an exception if the refresh failed.
  Future<Token> refreshToken(Token token);

  /// Fetches the [Token] from local storage.
  Future<Token?> getToken();
}
