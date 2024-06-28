import 'package:chatly/repositories/user_repository.dart';
import 'package:chatly/utils/constants/routes.dart';
import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        HiveService().logout();
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.login,
          (route) => false,
        );
      },
      child: const Row(
        children: [
          Text('Logout'),
          Icon(Icons.logout),
        ],
      ),
    );
  }
}
