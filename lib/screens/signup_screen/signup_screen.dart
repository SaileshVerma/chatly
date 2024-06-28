import 'package:flutter/material.dart';
import 'package:chatly/screens/signup_screen/widgets/name_field.dart';
import 'package:chatly/screens/signup_screen/widgets/password_field.dart';
import 'package:chatly/screens/signup_screen/widgets/phone_field.dart';
import 'package:chatly/screens/signup_screen/widgets/signup_button.dart';
import 'package:chatly/utils/constants/routes.dart';
import 'dart:math' as math;

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                '../assets/images/bg22.png',
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
                        "SIGNUP",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            NameField(),
                            PhoneNumberField(),
                            PasswordField(),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "Already have an account",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 2.0)),
                            onPressed: () {
                              Navigator.of(context).pushNamed(Routes.login);
                            },
                            child: const Text(
                              "Let's Login",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SignUpButton(
                        formKey: formKey,
                      )
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
                child: Image.asset(
                  '../assets/images/bg22.png',
                  fit: BoxFit.cover,
                  width: size.width,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
