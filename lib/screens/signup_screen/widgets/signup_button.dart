import 'package:chatly/bloc/signup/signups.dart';
import 'package:chatly/utils/constants/enums.dart';
import 'package:chatly/utils/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const SignUpButton({
    required this.formKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignupState>(
      listener: (context, state) {
        if (state.formStatus == FormStatus.failure &&
            state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage,
                ),
              ),
            );
        } else if (state.formStatus == FormStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.chat,
            (route) => false,
          );
          context.read<SignUpBloc>().add(const SignupClearFieldOnNavigation());
        }
      },
      listenWhen: (previous, current) {
        return (previous.errorMessage != current.errorMessage ||
            previous.formStatus != current.formStatus);
      },
      buildWhen: (previous, current) {
        return (previous.errorMessage != current.errorMessage ||
            previous.formStatus != current.formStatus);
      },
      builder: (context, state) => OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.orange, strokeAlign: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            context.read<SignUpBloc>().add(const SignupSubmitted());
          }
        },
        child: state.formStatus == FormStatus.inProgress
            ? const CircularProgressIndicator()
            : const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'SignUp',
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                    fontSize: 22.0,
                  ),
                ),
              ),
      ),
    );
  }
}
