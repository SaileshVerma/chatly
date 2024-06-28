import 'package:flutter/material.dart';
import 'package:chatly/screens/login_screen/widgets/login_action_button.dart';
import 'package:chatly/screens/login_screen/widgets/login_number_field.dart';
import 'package:chatly/screens/login_screen/widgets/login_password_field.dart';
import 'package:chatly/utils/constants/routes.dart';
import 'dart:math' as math;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: Colors.orangeAccent,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Image.network(
              'https://raw.githubusercontent.com/SaileshVerma/chatly/base/assets/images/bg22.png',
              fit: BoxFit.cover,
              width: size.width,
            ),
          ),
          Container(
            color: Colors.white70,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Welcome to CHATLY",
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Text(
                      "LOGIN",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          LoginPhoneNumberField(),
                          LoginPasswordField(),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Text(
                          "New to the Chatly?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0)),
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.signUp);
                          },
                          child: const Text(
                            "Let's SignUp",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    LoginActionButton(formKey: formKey),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image.network(
                'https://raw.githubusercontent.com/SaileshVerma/chatly/base/assets/images/bg22.png',
                fit: BoxFit.cover,
                width: size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
