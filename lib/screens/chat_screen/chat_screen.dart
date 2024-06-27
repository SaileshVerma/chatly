import 'dart:convert';

import 'package:chatly/repositories/user_repository.dart';
import 'package:chatly/utils/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse(
        'wss://echo.websocket.org/websocket'), // Replace with your WebSocket URL
  );
  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(json.encode({"hello": "world"}));

      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Chat'),
        actions: [
          TextButton(
            onPressed: () {
              HiveService().logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.login,
                (route) => false,
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _channel.stream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return ListView(
                      children: [
                        ListTile(
                          title: Text(snapshot.data.toString()),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: Text('No messages yet.'));
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Send a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final WebSocketChannel _channel = WebSocketChannel.connect(
//     Uri.parse(
//         'https://echo.websocket.org/WebSocket'), // Replace with your WebSocket URL
//   );

//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       _channel.sink.add(_controller.text);
//       _controller.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.amber,
//         title: const Text(
//           "Chatly",
//           style: TextStyle(
//             fontSize: 20,
//           ),
//         ),
//       ),
//       body: Container(
//         color: Colors.grey,
//         child: const Column(
//           children: [
//             ChatBubble(
//               type: Communicator.receiver,
//             ),
//             ChatBubble(
//               type: Communicator.sender,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ChatBubble extends StatelessWidget {
//   final Communicator type;

//   const ChatBubble({
//     required this.type,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: type == Communicator.sender
//           ? Alignment.centerRight
//           : Alignment.centerLeft,
//       child: Container(
//         width: 200,
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 15.0,
//               backgroundColor: Colors.grey,
//               child: Container(
//                 child: Icon(Icons.person),
//               ),
//             ),
//             const SizedBox(
//               width: 10,
//             ),
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: const Text("hello"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

enum Communicator { sender, receiver }
