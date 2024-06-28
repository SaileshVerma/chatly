import 'package:chatly/bloc/chat/chats.dart';
import 'package:chatly/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNameField extends StatelessWidget {
  const AddNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) {
        return previous.name != current.name;
      },
      builder: (ctx, state) => CustomTextField(
        label: 'Contact Name',
        hintText: 'Enter Contact Name',
        onChanged: (val) {
          ctx.read<ChatBloc>().add(ContactNameChanged(val));
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
