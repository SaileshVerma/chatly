import 'package:chatly/bloc/signup/signup_event.dart';
import 'package:chatly/bloc/signup/signups.dart';
import 'package:chatly/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneNumberField extends StatelessWidget {
  const PhoneNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignupState>(
      buildWhen: (previous, current) => previous.number != current.number,
      builder: (ctx, state) => CustomTextField(
        label: 'Phone No:',
        hintText: "Enter Your Contact Number",
        onChanged: (val) => {
          ctx.read<SignUpBloc>().add(SignupPhoneNumberChanged(val)),
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Phone number is required';
          } else if (value.length != 10) {
            return 'Enter a valid phone number';
          }
          return null;
        },
      ),
    );
  }
}
