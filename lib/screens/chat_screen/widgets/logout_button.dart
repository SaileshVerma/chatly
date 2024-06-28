import 'package:chatly/bloc/chat/chats.dart';
import 'package:chatly/bloc/contacts/contacts.dart';
import 'package:chatly/bloc/current_contact/current_contacts.dart';
import 'package:chatly/bloc/login/login.dart';
import 'package:chatly/bloc/signup/signups.dart';
import 'package:chatly/repositories/user_repository.dart';
import 'package:chatly/utils/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context
            .read<CurrentContactBloc>()
            .add(const ClearCurrentContactsStates());

        context.read<ChatBloc>().add(const ClearChatStates());
        context.read<ContactBloc>().add(const ClearContactsStates());
        context.read<SignUpBloc>().add(const SignupClearFieldOnNavigation());
        context.read<LoginBloc>().add(const LoginClearFieldOnNavigation());

        HiveService().logout();

        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        );
      },
      child: const Row(
        children: [
          Text(
            'Logout ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
          Icon(
            Icons.logout,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }
}
