import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../core.dart';
import '../dto/authentication/token_dto.dart';

/// Takes care of all authentication related data ops.
@Injectable(as: AuthenticationRepository)
class ApiAuthenticationRepository implements AuthenticationRepository {
  /// Creates a new instance of [ApiAuthenticationRepository].
  ApiAuthenticationRepository()
      : _secureStorage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
            keyCipherAlgorithm:
                KeyCipherAlgorithm.RSA_ECB_OAEPwithSHA_256andMGF1Padding,
            storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
          ),
        );

  static const Duration _tokenLifeSpan = Duration(days: 2);

  static const String _key = 'token';

  /// The [FlutterSecureStorage] to manage secure storage of tokens.
  final FlutterSecureStorage _secureStorage;

  @override
  Future<Token> signIn({
    required String email,
    required String password,
  }) async {
    // Assume this was fetched from a login api call.
    final TokenDTO tokenDTO = TokenDTO(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
      expiresAt: DateTime.now().add(_tokenLifeSpan),
    );

    final Token token = tokenDTO.toEntity();
    await _saveTokenToStorage(token);
    return token;
  }

  @override
  Future<void> endSession(Token token) {
    _removeTokenFromStorage();
    // Returns the future from ending the session on the API.
    return Future<void>.value();
  }

  @override
  Future<Token> refreshToken(Token token) async {
    // Assume this has been fetched from an API.
    final Token token = Token(
      accessToken: 'accessToken',
      refreshToken: 'refreshToken',
      expiresAt: DateTime.now().add(_tokenLifeSpan),
    );
    await _saveTokenToStorage(token);
    return Future<Token>.value(token);
  }

  @override
  Future<Token?> getToken() {
    return _getTokenFromStorage();
  }

  /// Gets a [Token] from secure storage.
  Future<Token?> _getTokenFromStorage() async {
    final String? encoded = await _secureStorage.read(key: _key);
    if (encoded == null) {
      return null;
    }
    final TokenDTO tokenDTO = TokenDTO.fromJson(encoded);
    return tokenDTO.toEntity();
  }

  /// Saves the [token] to secure storage.
  Future<void> _saveTokenToStorage(Token token) {
    final TokenDTO tokenDTO = TokenDTO.fromEntity(token);
    return _secureStorage.write(key: _key, value: tokenDTO.toJson());
  }

  Future<void> _removeTokenFromStorage() {
    return _secureStorage.delete(key: _key);
  }
}
