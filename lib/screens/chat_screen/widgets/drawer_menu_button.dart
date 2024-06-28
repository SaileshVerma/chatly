import 'package:chatly/bloc/contacts/contacts.dart';
import 'package:chatly/screens/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerMenuButton extends StatelessWidget {
  const DrawerMenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      builder: (ctx, state) => IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        onPressed: () {
          ctx.read<ContactBloc>().add(const GetCurrentUserContactList());
          scaffoldKey.currentState?.openDrawer();
        },
      ),
    );
  }
}
