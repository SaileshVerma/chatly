import 'package:flutter/material.dart';
import 'package:chatly/screens/login_screen/widgets/login_action_button.dart';
import 'package:chatly/screens/login_screen/widgets/login_number_field.dart';
import 'package:chatly/screens/login_screen/widgets/login_password_field.dart';
import 'package:chatly/utils/constants/routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                const Text("Login User"),
                const LoginPhoneNumberField(),
                const LoginPasswordField(),
                Row(
                  children: [
                    const Text("New to the Chatly?"),
                    TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 2.0)),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.signUp);
                      },
                      child: const Text(
                        "Let's SignUp",
                        style: TextStyle(color: Colors.blue),
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
    );
  }
}
