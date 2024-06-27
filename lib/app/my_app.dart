import 'package:chatly/bloc/chat/chats.dart';
import 'package:chatly/bloc/login/login.dart';
import 'package:chatly/bloc/signup/signups.dart';
import 'package:chatly/routes/app_router.dart';
import 'package:chatly/screens/signup_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => ChatBloc(),
        ),
        BlocProvider(
          create: (ctx) => SignUpBloc(),
        ),
        BlocProvider(
          create: (ctx) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SignUpScreen(),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
