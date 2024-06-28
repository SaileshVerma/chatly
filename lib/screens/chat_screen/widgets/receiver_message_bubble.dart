import 'package:chatly/models/message.dart';
import 'package:chatly/widgets/custom_profile_widget.dart';
import 'package:flutter/material.dart';

class ReceiverMessage extends StatelessWidget {
  final Message? message;
  final String senderName;

  const ReceiverMessage({
    required this.message,
    required this.senderName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 70,
        width: 200,

        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
            bottomLeft: Radius.zero,
          ),
        ),

        child: ListTile(
          leading: CustomProfileAvatar(name: senderName, radius: 18),
          title: Text(
            senderName,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
          subtitle: Text(message?.content ?? ""),
        ),

        // Column(
        //   children: [
        //     Text(messageObject?.content ?? ""),
        //     Text(
        //         messageObject?.createdByNumber ?? ""),
        //   ],
        // ),
      ),
    );
  }
}
