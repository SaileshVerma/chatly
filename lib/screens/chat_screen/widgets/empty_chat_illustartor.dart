import 'package:chatly/screens/chat_screen/chat_screen.dart';
import 'package:flutter/material.dart';

class EmptyChatIllustrator extends StatelessWidget {
  const EmptyChatIllustrator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          '../assets/images/nochat.png',
          height: 80,
        ),
        const Text('No Message Found! '),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Lets Starts",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black45,
                  ),
                ),
                Icon(
                  Icons.add,
                  color: Colors.orange,
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
