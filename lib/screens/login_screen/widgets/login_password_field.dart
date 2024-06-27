import 'package:chatly/bloc/login/login.dart';
import 'package:chatly/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        return previous.password != current.password;
      },
      builder: (ctx, state) => CustomTextField(
        label: 'Password:',
        hintText: "Enter Your Password",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          }

          return null;
        },
        onChanged: (val) => {
          ctx.read<LoginBloc>().add(LoginPasswordChanged(val)),
        },
      ),
    );
  }
}
