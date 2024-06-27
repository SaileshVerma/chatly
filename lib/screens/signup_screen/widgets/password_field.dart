import 'package:chatly/bloc/signup/signups.dart';
import 'package:chatly/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignupState>(
      builder: (ctx, state) => CustomTextField(
        label: 'Password:',
        hintText: "Enter Your Password",
        onChanged: (_) => {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password is required';
          } else if (value.length < 3) {
            return 'Should be more than 3 characters';
          }

          return null;
        },
      ),
    );
  }
}
