import 'dart:convert';
import 'package:chatly/bloc/current_contact/current_contacts.dart';
import 'package:chatly/screens/chat_screen/widgets/app_bar_title_widget.dart';
import 'package:chatly/screens/chat_screen/widgets/receiver_message_bubble.dart';
import 'package:chatly/screens/chat_screen/widgets/sender_message_bubble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:chatly/bloc/contacts/contact_bloc.dart';
import 'package:chatly/bloc/contacts/contact_event.dart';
import 'package:chatly/bloc/contacts/contact_state.dart';
import 'package:chatly/screens/chat_screen/add_contact_widgets/add_contact_form.dart';
import 'package:chatly/screens/chat_screen/widgets/contacts_drawer.dart';
import 'package:chatly/models/message.dart';
import 'package:chatly/models/user.dart';
import 'package:chatly/repositories/user_repository.dart';

final scaffoldKey = GlobalKey<ScaffoldState>();

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> msgs = [];

  final TextEditingController _controller = TextEditingController();

  final WebSocketChannel _channel = WebSocketChannel.connect(
    Uri.parse('wss://echo.websocket.org/.sse'),
  );

  User? loggedInUser;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = await HiveService().getLoggedInUser();
      setState(() {
        loggedInUser = user;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _sendMessage(BuildContext context) {
    if (_controller.text.isNotEmpty) {
      final message = Message(
        content: _controller.text,
        timestamp: DateTime.now(),
        createdByNumber: loggedInUser?.number ?? "",
      );

      _channel.sink.add(
        json.encode(message.toJson()),
      );

      _controller.clear();
      // context.read<ChatBloc>().add(AddContactMessage(message));
      context.read<CurrentContactBloc>().add(
            AddCurrentContactMessage(
              currentLoggedInUserNumber: loggedInUser?.number ?? '',
              message: message,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: const DrawerMenuButton(),
        backgroundColor: Colors.orange,
        title: const AppBarTitleWidget(),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AddContactForm();
                },
              );
            },
            icon: const Icon(
              Icons.person_add,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: BlocBuilder<CurrentContactBloc, CurrentContactState>(
          buildWhen: (previous, current) =>
              previous.currentContact != current.currentContact,
          builder: (ctx, contactState) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: _channel.stream,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          snapshot.data.toString().contains('Request')
                              ? null
                              : msgs.add(
                                  Message.fromJson(
                                    json: json.decode(snapshot.data),
                                  ),
                                );

                          if (contactState.currentContact?.messages?.length ==
                                  0 ||
                              contactState.currentContact?.messages == null) {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          return ListView.builder(
                            itemCount:
                                contactState.currentContact?.messages?.length ??
                                    0,
                            // itemCount: 2,
                            itemBuilder: (ctx, i) {
                              final messageObject =
                                  contactState.currentContact?.messages?[i];

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: messageObject?.createdByNumber ==
                                        loggedInUser?.number
                                    ? SenderMessage(message: messageObject)
                                    : ReceiverMessage(
                                        message: messageObject,
                                        senderName:
                                            contactState.currentContact?.name ??
                                                '',
                                      ),
                              );
                            },
                          );
                        } else {
                          return Center(child: Text('No messages yet.'));
                        }
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Text("${loggedInUser?.name ?? "@@@@@@@@"}"),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            labelText: 'Send a message',
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          _sendMessage(ctx);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
      drawer: ChatDrawer(
        loggedInUser: loggedInUser,
      ),
    );
  }
}

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
