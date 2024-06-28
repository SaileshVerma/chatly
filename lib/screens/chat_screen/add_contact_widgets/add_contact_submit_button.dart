import 'package:chatly/bloc/chat/chat_event.dart';
import 'package:chatly/bloc/chat/chats.dart';
import 'package:chatly/bloc/login/login.dart';
import 'package:chatly/utils/constants/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddDetailsSubmitButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const AddDetailsSubmitButton({required this.formKey, super.key});

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
          Navigator.of(context).pop();
          context.read<ChatBloc>().add(
                const ClearChatStates(),
              );
        }
      },
      buildWhen: (previous, current) {
        return previous.errorMessage != current.errorMessage ||
            previous.formStatus != current.formStatus;
      },
      builder: (ctx, state) => ElevatedButton(
        onPressed: () {
          if (formKey.currentState?.validate() ?? false) {
            ctx.read<ChatBloc>().add(const AddContactDetails());
          }

          // Navigator.of(context).pop();
        },
        child: const Text('Submit'),
      ),
    );
  }
}
