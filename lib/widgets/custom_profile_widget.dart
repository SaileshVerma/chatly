import 'package:chatly/utils/helpers/profile_pic_helper.dart';
import 'package:flutter/material.dart';

class CustomProfileAvatar extends StatelessWidget {
  final String name;
  final double radius;
  const CustomProfileAvatar({
    required this.name,
    required this.radius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(1.8),
        child: CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(
            getProfilePicAsset(name),
          ),
        ),
      ),
    );
  }
}
