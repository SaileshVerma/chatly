import 'package:chatly/utils/constants/routes.dart';
import 'package:chatly/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Welcome to Chatly"),
              Text("Login User"),
              CustomTextField(
                label: 'Phone No:',
                hintText: "Enter Your Contact Number",
              ),
              CustomTextField(
                label: 'Password:',
                hintText: "Enter Your Password",
              ),
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
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0))),
                onPressed: () {},
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
