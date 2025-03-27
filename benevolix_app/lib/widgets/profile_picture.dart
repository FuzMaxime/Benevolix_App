import 'package:benevolix_app/constants/color.dart';
import 'package:flutter/material.dart';

enum AvatarSize { small, medium, big }

class ProfilePicture extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String? id; // If the id is null, it's the current user
  final AvatarSize size;

  const ProfilePicture({
    super.key,
    required this.firstName,
    required this.lastName,
    this.size = AvatarSize.medium,
    this.id,
  });

  double getSize() {
    switch (size) {
      case AvatarSize.small:
        return 35.0;
      case AvatarSize.medium:
        return 50.0;
      case AvatarSize.big:
        return 75.0;
    }
  }

  double getFontSize() {
    switch (size) {
      case AvatarSize.small:
        return 14.0;
      case AvatarSize.medium:
        return 18.0;
      case AvatarSize.big:
        return 30.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double avatarSize = getSize();
    final double fontSize = getFontSize();

    return GestureDetector(
      onTap: () async {
        Navigator.pushNamed(context, '/profile', arguments: id);
      },
      child: Container(
        width: avatarSize,
        height: avatarSize,
        decoration: BoxDecoration(
          color: ColorConstant.red,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            (firstName.isNotEmpty && lastName.isNotEmpty)
                ? firstName[0].toUpperCase() + lastName[0].toUpperCase()
                : "",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
