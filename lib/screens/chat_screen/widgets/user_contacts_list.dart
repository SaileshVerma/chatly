import 'package:chatly/bloc/contacts/contacts.dart';
import 'package:chatly/bloc/current_contact/current_contact_bloc.dart';
import 'package:chatly/bloc/current_contact/current_contact_event.dart';
import 'package:chatly/screens/chat_screen/chat_screen.dart';
import 'package:chatly/utils/constants/enums.dart';
import 'package:chatly/widgets/custom_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserContactList extends StatelessWidget {
  const UserContactList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactState>(
      buildWhen: (previous, current) =>
          previous.loadingState != current.loadingState ||
          previous.contacts != current.contacts,
      builder: (ctx, state) {
        if (state.loadingState == LoadingStatus.loading) {
          return const SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        if (state.contacts.isEmpty) {
          return const Column(
            children: [
              Text(
                "Add Your Contacts First",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Note: added contacts will be visible here,",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "click on add contact button on app bar",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }
        return ListView.builder(
          itemCount: state.contacts.length,
          itemBuilder: (ctx, i) {
            final user = state.contacts[i];
            return Column(
              children: [
                ListTile(
                  leading: CustomProfileAvatar(
                    name: user.name ?? '@@',
                    radius: 20,
                  ),
                  title: Text(user.name ?? ''),
                  subtitle: Text(user.number),
                  onTap: () {
                    ctx.read<CurrentContactBloc>().add(
                          UpdateCurrentContact(user),
                        );

                    scaffoldKey.currentState?.closeDrawer();
                  },
                ),
                const Divider(
                  color: Colors.white,
                  endIndent: 10,
                  indent: 10,
                  thickness: 0.6,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
