import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core.dart';

part 'login_state.dart';

/// Cubit for managing the login page.
class LoginCubit extends Cubit<LoginState> {
  /// Creates a new instance of [LoginCubit].
  LoginCubit(this._authenticationService) : super(const LoginState());

  final AuthenticationService _authenticationService;

  /// Update the email when the form changes.
  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  /// Update the password when the form changes.
  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  /// Signs in the user.
  Future<void> signIn() async {
    final String email = state.email;
    final String password = state.password;

    await Future<void>.delayed(const Duration(seconds: 1));
    try {
      await _authenticationService.signIn(email: email, password: password);
      emit(state.copyWith(isLoading: false, loginSuccessful: true));
    } on AuthenticationException catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          loginSuccessful: false,
          authErrorCode: e.errorCode,
        ),
      );
    }
  }
}
