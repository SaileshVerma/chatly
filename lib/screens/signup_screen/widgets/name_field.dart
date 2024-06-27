import 'package:chatly/bloc/signup/signup_event.dart';
import 'package:chatly/bloc/signup/signups.dart';
import 'package:chatly/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameField extends StatelessWidget {
  const NameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignupState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (ctx, state) => CustomTextField(
        label: 'Name:',
        hintText: "Enter Your Name",
        onChanged: (val) => {
          ctx.read<SignUpBloc>().add(SignupNameChanged(val)),
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Name is required';
          }

          return null;
        },
      ),
    );
  }
}
