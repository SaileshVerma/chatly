import 'package:chatly/bloc/signup/signups.dart';
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
    return BlocBuilder<SignUpBloc, SignupState>(
      buildWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.formStatus != current.formStatus,
      builder: (ctx, state) => OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0))),
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            ctx.read<SignUpBloc>().add(const SignupSubmitted());

            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.chat,
              (route) => false,
            );
          }
        },
        child: const Text(
          'SignUp',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
