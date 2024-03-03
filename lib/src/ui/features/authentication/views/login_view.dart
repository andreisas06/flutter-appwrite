import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core.dart';
import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/sizes_constants.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../cubit/login_cubit.dart';
import 'forgot_password_page.dart';

final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

/// The view for signing in.
///
/// Because the LoginView is the first page to be shown after the app has
/// started, a PopScope is used to prevent the user from being able to go back.
/// This is necessary because of the way we setup go_router_builder.
class LoginView extends StatelessWidget {
  /// Creates a new instance of [LoginView].
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginCubit loginCubit = context.read<LoginCubit>();
    final AppLocalizations l10n = context.l10n;
    return Scaffold(
      body: MultiBlocListener(
        listeners: <BlocListener<StateStreamable<dynamic>, dynamic>>[
          BlocListener<LoginCubit, LoginState>(
            listenWhen: (LoginState previous, LoginState current) =>
                (previous.isLoading && !current.isLoading) &&
                (current.authErrorCode != null ||
                    current.tokenErrorCode != null),
            listener: (BuildContext context, LoginState state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(Sizes.s32),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Sizes.s384,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    child: Image.asset(
                      Assets.baseflowLogo.path,
                      semanticLabel: l10n.appBarTitle,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const GutterLarge(),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (BuildContext context, LoginState state) {
                      return Form(
                        key: _loginFormKey,
                        child: AutofillGroup(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              TextFormField(
                                onChanged: loginCubit.updateEmail,
                                initialValue: AppConfig.defaultUsername,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                autofillHints: const <String>[
                                  AutofillHints.email,
                                ],
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  hintText: l10n.email,
                                ),
                                validator: FormBuilderValidators.compose(
                                  <FormFieldValidator<String>>[
                                    FormBuilderValidators.required(
                                      errorText: l10n.emailRequired,
                                    ),
                                    FormBuilderValidators.email(
                                      errorText: l10n.emailInvalid,
                                    ),
                                  ],
                                ),
                              ),
                              const Gutter(),
                              TextFormField(
                                onChanged: loginCubit.updatePassword,
                                initialValue: AppConfig.defaultPassword,
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                textInputAction: TextInputAction.go,
                                autofillHints: const <String>[
                                  AutofillHints.password,
                                ],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  hintText: l10n.password,
                                ),
                                validator: FormBuilderValidators.required(
                                  errorText: l10n.passwordRequired,
                                ),
                                onFieldSubmitted: (_) {
                                  if (_loginFormKey.currentState!.validate()) {
                                    loginCubit.signIn();
                                  }
                                },
                              ),
                              const Gutter(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => context.goNamed(
                                    ForgotPasswordPage.name,
                                  ),
                                  child: Text(l10n.forgotPassword),
                                ),
                              ),
                              const Gutter(),
                              BlocSelector<LoginCubit, LoginState, bool>(
                                selector: (LoginState state) => state.isLoading,
                                builder:
                                    (BuildContext context, bool isLoading) {
                                  return FilledButton(
                                    onPressed: isLoading
                                        ? null
                                        : () {
                                            if (_loginFormKey.currentState!
                                                .validate()) {
                                              loginCubit.signIn();
                                            }
                                          },
                                    child: isLoading
                                        ? const SizedBox.square(
                                            dimension: 24,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                            ),
                                          )
                                        : Text(l10n.signIn),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
