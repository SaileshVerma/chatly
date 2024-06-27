import 'package:chatly/utils/constants/routes.dart';
import 'package:chatly/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              Text("Signup User"),
              CustomTextField(
                label: 'Name:',
                hintText: "Enter Your Name",
              ),
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
                      )),
                ],
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0))),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.chat,
                    (route) => false,
                  );
                },
                child: const Text(
                  'SignUp',
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
