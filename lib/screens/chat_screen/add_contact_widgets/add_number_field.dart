import 'package:chatly/bloc/chat/chats.dart';
import 'package:chatly/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNumberField extends StatelessWidget {
  const AddNumberField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) {
        return previous.number != current.number;
      },
      builder: (ctx, state) => CustomTextField(
        label: 'Contact Number',
        hintText: 'Enter Contact Number',
        onChanged: (val) {
          ctx.read<ChatBloc>().add(ContactNumberChanged(val));
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
