import 'package:chatly/bloc/login/login.dart';
import 'package:chatly/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPhoneNumberField extends StatelessWidget {
  const LoginPhoneNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) {
        return previous.number != current.number;
      },
      builder: (ctx, state) => CustomTextField(
        label: 'Phone No:',
        hintText: "Enter Your Contact Number",
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Phone number is required';
          } else if (value.length != 10) {
            return 'Enter a valid phone number';
          }
          return null;
        },
        onChanged: (val) => {
          ctx.read<LoginBloc>().add(LoginPhoneNumberChanged(val)),
        },
      ),
    );
  }
}
