import 'package:chatly/bloc/contacts/contacts.dart';
import 'package:chatly/bloc/current_contact/current_contact_bloc.dart';
import 'package:chatly/bloc/current_contact/current_contact_event.dart';
import 'package:chatly/utils/constants/enums.dart';
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
          return const CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: state.contacts.length,
          itemBuilder: (ctx, i) {
            final user = state.contacts[i];
            return Column(
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: Text(user.name ?? ''),
                  subtitle: Text(user.number),
                  onTap: () {
                    ctx.read<CurrentContactBloc>().add(
                          UpdateCurrentContact(user),
                        );
                  },
                ),
                const Divider(),
              ],
            );
          },
        );
      },
    );
  }
}
