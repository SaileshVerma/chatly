import 'package:chatly/screens/chat_screen/chat_screen.dart';
import 'package:chatly/screens/home_screen/home_screen.dart';
import 'package:chatly/screens/login_screen/login_screen.dart';
import 'package:chatly/screens/signup_screen/signup_screen.dart';
import 'package:chatly/utils/constants/routes.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    Widget page;
    int transitionDuration = 300;
    int reverseTransitionDuration = 300;

    switch (settings.name) {
      case (Routes.login):
        page = const LoginScreen();
        break;

      case (Routes.signUp):
        page = const SignUpScreen();
        break;

      case (Routes.root):
        page = const HomeScreen(
          title: "",
        );
        break;

      default:
        page = const ChatScreen();
        break;
    }

    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: transitionDuration),
      reverseTransitionDuration: Duration(
        milliseconds: reverseTransitionDuration,
      ),
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
    );
  }
}
