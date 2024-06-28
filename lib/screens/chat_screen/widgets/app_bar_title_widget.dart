import 'package:chatly/bloc/current_contact/current_contacts.dart';
import 'package:chatly/widgets/custom_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarTitleWidget extends StatelessWidget {
  const AppBarTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentContactBloc, CurrentContactState>(
        buildWhen: (previous, current) =>
            previous.currentContact != current.currentContact,
        builder: (ctx, state) {
          if (state.currentContact == null) {
            return const Text(
              "Chatly",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            );
          }

          return Visibility.maintain(
            visible: state.currentContact != null,
            child: ListTile(
              leading: CustomProfileAvatar(
                name: state.currentContact?.name ?? "",
                radius: 40,
              ),
              title: Text("${state.currentContact?.name}"),
              subtitle: Text("${state.currentContact?.number}"),
            ),
          );
        });
  }
}
