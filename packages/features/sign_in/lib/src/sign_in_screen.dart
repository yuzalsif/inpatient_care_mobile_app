import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_in/src/sign_in_cubit.dart';
import 'package:user_repository/user_repository.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    required this.userRepository,
    required this.onSignInSuccess,
    super.key,
  });

  final VoidCallback onSignInSuccess;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (_) => SignInCubit(
        userRepository: userRepository,
      ),
      child: SignInView(
        onSignInSuccess: onSignInSuccess,
      ),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({
    required this.onSignInSuccess,
    super.key,
  });

  final VoidCallback onSignInSuccess;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _releaseFocus(context),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.mediumLarge,
            ),
            child: _SignInForm(
              onSignInSuccess: onSignInSuccess,
            ),
          ),
        ),
      ),
    );
  }

  void _releaseFocus(BuildContext context) => FocusScope.of(context).unfocus();
}

class _SignInForm extends StatefulWidget {
  const _SignInForm({
    required this.onSignInSuccess,
    super.key,
  });

  final VoidCallback onSignInSuccess;

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _urlFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SignInCubit>();
    _usernameFocusNode.addListener(() {
      if (!_usernameFocusNode.hasFocus) {
        cubit.onUsernameUnfocused();
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        cubit.onPasswordUnfocused();
      }
    });
    _urlFocusNode.addListener(() {
      if (!_urlFocusNode.hasFocus) {
        cubit.onUrlUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _urlFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        if (state.submissionStatus == SubmissionStatus.success) {
          widget.onSignInSuccess();
          return;
        }

        final hasSubmissionError = state.submissionStatus ==
                SubmissionStatus.genericError ||
            state.submissionStatus == SubmissionStatus.invalidCredentialsError;

        if (hasSubmissionError) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              state.submissionStatus == SubmissionStatus.invalidCredentialsError
                  ? const SnackBar(
                      content: Text('Invalid email and/ username'),
                    )
                  : const GenericErrorSnackBar(),
            );
        }
      },
      builder: (context, state) {
        final userNameError =
            state.username.isNotValid ? state.username.error : null;
        final passwordError =
            state.password.isNotValid ? state.password.error : null;
        final urlError = state.baseUrl.isNotValid ? state.baseUrl.error : null;
        final isSubmissionInProgress =
            state.submissionStatus == SubmissionStatus.inProgress;

        final cubit = context.read<SignInCubit>();
        return Column(
          children: <Widget>[
            TextField(
              focusNode: _usernameFocusNode,
              onChanged: cubit.onUsernameChanged,
              textInputAction: TextInputAction.next,
              autocorrect: false,
              decoration: InputDecoration(
                // suffixIcon: const Icon(
                //   Icons.user,
                // ),
                enabled: !isSubmissionInProgress,
                labelText: 'Username',
                errorText: userNameError == null
                    ? null
                    : (userNameError == UsernameValidationError.empty
                        ? 'Your username can not be empty.'
                        : null),
              ),
            ),
            const SizedBox(
              height: Spacing.large,
            ),
            TextField(
              focusNode: _passwordFocusNode,
              onChanged: cubit.onPasswordChanged,
              obscureText: true,
              onEditingComplete: cubit.onSubmit,
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.password,
                ),
                enabled: !isSubmissionInProgress,
                labelText: 'Password',
                errorText: passwordError == null
                    ? null
                    : (passwordError == PasswordValidationError.empty
                        ? 'Your password can not be empty.'
                        : null),
              ),
            ),
            const SizedBox(
              height: Spacing.large,
            ),
            TextField(
              focusNode: _urlFocusNode,
              onChanged: cubit.onUrlChanged,
              textInputAction: TextInputAction.next,
              autocorrect: false,
              decoration: InputDecoration(
                enabled: !isSubmissionInProgress,
                labelText: 'Url',
                errorText: urlError == null
                    ? null
                    : (urlError == UrlValidationError.empty
                    ? 'Base url can not be empty.'
                    : 'Invalid Url'),
              ),
            ),
            const SizedBox(
              height: Spacing.small,
            ),
            isSubmissionInProgress
                ? ExpandedElevatedButton.inProgress(
                    label: 'Sign In',
                  )
                : ExpandedElevatedButton(
                    onTap: cubit.onSubmit,
                    label: 'Sign In',
                    icon: const Icon(
                      Icons.login,
                    ),
                  ),
          ],
        );
      },
    );
  }
}
