import 'package:chatly/bloc/chat/chats.dart';
import 'package:chatly/bloc/contacts/contact_bloc.dart';
import 'package:chatly/bloc/current_contact/current_contact_bloc.dart';
import 'package:chatly/bloc/login/login.dart';
import 'package:chatly/bloc/signup/signups.dart';
import 'package:chatly/models/user.dart';
import 'package:chatly/repositories/user_repository.dart';
import 'package:chatly/routes/app_router.dart';
import 'package:chatly/screens/chat_screen/chat_screen.dart';
import 'package:chatly/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ContactBloc(),
        ),
        BlocProvider(
          create: (ctx) => ChatBloc(),
        ),
        BlocProvider(
          create: (ctx) => SignUpBloc(),
        ),
        BlocProvider(
          create: (ctx) => LoginBloc(),
        ),
        BlocProvider(
          create: (ctx) => CurrentContactBloc(),
        ),
      ],
      child: FutureBuilder(
        future: HiveService().getLoggedInUser(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }

          final User? loggedInUser = snapshot.data;
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // home: const ChatScreen(),
            home:
                loggedInUser == null ? const LoginScreen() : const ChatScreen(),
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
