import 'package:chatly/utils/constants/enums.dart';
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
    return BlocConsumer<LoginBloc, LoginState>(
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
          context.read<LoginBloc>().add(LoginClearFieldOnNavigation());
        }
      },
      buildWhen: (previous, current) {
        return previous.errorMessage != current.errorMessage ||
            previous.formStatus != current.formStatus;
      },
      builder: (ctx, state) => OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.orange, strokeAlign: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            ctx.read<LoginBloc>().add(const LoginSubmitted());
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Login',
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
