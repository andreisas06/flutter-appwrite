import 'dart:async';

import 'package:injectable/injectable.dart';

import '../entities/auth/token.dart';
import '../exceptions/authentication_exception.dart';
import '../repositories/authentication_repository.dart';
import '../types/authentication_status.dart';

/// Takes care of all authentication related business logic.
@lazySingleton
class AuthenticationService {
  /// Creates a new instance of [AuthenticationService].
  AuthenticationService(this._authenticationRepository)
      : _authStatusController = StreamController<AuthenticationStatus>();

  final AuthenticationRepository _authenticationRepository;

  final StreamController<AuthenticationStatus> _authStatusController;

  /// A stream of [AuthenticationStatus] to listen to.
  Stream<AuthenticationStatus> get authStatusStream =>
      _authStatusController.stream;

  Token? _token;
  Timer? _tokenTimer;
  int _counter = 0;

  /// Signs in the user with the given [email] and [password].
  Future<void> signIn({required String email, required String password}) async {
    _token = await _authenticationRepository.signIn(
      email: email,
      password: password,
    );
    _authStatusController.add(AuthenticationStatus.authenticated);
    unawaited(startTokenLifecycle());
  }

  /// Logs out the currently user.
  Future<void> logout() async {
    if (_token == null) {
      return _authStatusController.add(AuthenticationStatus.unauthenticated);
    }
    await _authenticationRepository.endSession(_token!);
    _token = null;
    _authStatusController.add(AuthenticationStatus.unauthenticated);
  }

  /// Start a timer for the given token and periodically refresh it when
  /// needed and allowed.
  Future<void> startTokenLifecycle() async {
    _token = await _authenticationRepository.getToken();
    if (_token == null) return;
    _authStatusController.add(AuthenticationStatus.authenticated);
    final Duration diff = _token!.expiresAt.difference(DateTime.now());
    _counter = diff.inSeconds;
    _tokenTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _counter--;
      if (_counter <= 0) _refreshToken();
    });
  }

  Future<void> _refreshToken() async {
    try {
      _token = await _authenticationRepository.refreshToken(_token!);
      _counter = _token!.expiresAt.difference(DateTime.now()).inSeconds;
    } on AuthenticationException {
      _tokenTimer?.cancel();
      _tokenTimer = null;
      _counter = 0;
      _authStatusController.add(AuthenticationStatus.unauthenticated);
    }
  }
}
