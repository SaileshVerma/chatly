import 'package:flutter/material.dart';
import 'package:chatly/screens/signup_screen/widgets/name_field.dart';
import 'package:chatly/screens/signup_screen/widgets/password_field.dart';
import 'package:chatly/screens/signup_screen/widgets/phone_field.dart';
import 'package:chatly/screens/signup_screen/widgets/signup_button.dart';
import 'package:chatly/utils/constants/routes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text("Welcome to Chatly"),
                const Text("Signup User"),
                NameField(),
                PhoneNumberField(),
                PasswordField(),
                Row(
                  children: [
                    const Text("Already have an account"),
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0)),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.login);
                      },
                      child: const Text(
                        "Let's Login",
                        style: TextStyle(color: Colors.blue),
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
    );
  }
}
