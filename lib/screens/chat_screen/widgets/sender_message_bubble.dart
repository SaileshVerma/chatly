import 'package:chatly/models/message.dart';
import 'package:chatly/widgets/custom_profile_widget.dart';
import 'package:flutter/material.dart';

class SenderMessage extends StatelessWidget {
  final String currentLoggedInUsername;
  final Message? message;
  const SenderMessage({
    required this.currentLoggedInUsername,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 70,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.orange.shade300,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.zero,
          ),
        ),
        child: ListTile(
          trailing:
              CustomProfileAvatar(name: currentLoggedInUsername, radius: 18),
          title: const Text(
            'You',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
          subtitle: Text(
            message?.content ?? "",
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}
