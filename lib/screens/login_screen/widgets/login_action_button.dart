import 'package:chatly/utils/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:chatly/bloc/login/login.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginActionButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginActionButton({
    required this.formKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (ctx, state) => OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.chat,
              (route) => false,
            );
          }
        },
        child: const Text(
          'Login',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}
