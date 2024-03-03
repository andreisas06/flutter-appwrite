import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../assets/generated/assets.gen.dart';
import '../../../constants/sizes_constants.dart';
import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/generated/app_localizations.dart';
import '../../../localizations/l10n.dart';
import '../cubit/forgot_password_cubit.dart';

final GlobalKey<FormState> _forgotPasswordFormKey = GlobalKey<FormState>();

/// Form for resetting the password.
class ForgotPasswordView extends StatelessWidget {
  /// Creates a new instance of [ForgotPasswordView].
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = context.l10n;
    final ForgotPasswordCubit cubit = context.read<ForgotPasswordCubit>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Align(
          child: SizedBox(
            height: context.height,
            width: context.width > 600 ? 600 : context.width,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.s24),
                child: Column(
                  children: <Widget>[
                    FractionallySizedBox(
                      widthFactor: 0.5, // Adjust as needed
                      child: Image.asset(
                        Assets.baseflowLogo.path,
                        semanticLabel: l10n.appBarTitle,
                        fit: BoxFit.contain,
                      ),
                    ),
                    BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
                      builder:
                          (BuildContext context, ForgotPasswordState state) {
                        return Form(
                          key: _forgotPasswordFormKey,
                          child: AutofillGroup(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                TextFormField(
                                  onChanged: cubit.updateEmail,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const <String>[
                                    AutofillHints.email,
                                  ],
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                  onFieldSubmitted: (_) {
                                    if (_forgotPasswordFormKey.currentState!
                                        .validate()) {
                                      cubit.sendPasswordResetEmail();
                                    }
                                  },
                                ),
                                const GutterLarge(),
                                BlocBuilder<ForgotPasswordCubit,
                                    ForgotPasswordState>(
                                  builder: (
                                    BuildContext context,
                                    ForgotPasswordState state,
                                  ) {
                                    if (state.isLoading) {
                                      return const FilledButton(
                                        onPressed: null,
                                        child: SizedBox.square(
                                          dimension: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                          ),
                                        ),
                                      );
                                    }
                                    if (state.emailSentSuccessfully) {
                                      return const FilledButton(
                                        onPressed: null,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.check),
                                            Gutter(),
                                            Text('Email sent'),
                                          ],
                                        ),
                                      );
                                    }
                                    return FilledButton(
                                      onPressed: () {
                                        if (_forgotPasswordFormKey.currentState!
                                            .validate()) {
                                          cubit.sendPasswordResetEmail();
                                        }
                                      },
                                      child: Text(l10n.resetPassword),
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
      ),
    );
  }
}
