import 'package:flutter/material.dart';
import 'package:benevolix_app/features/auth/services/auth_service.dart';
import 'package:benevolix_app/features/auth/services/user_service.dart';

import '../../features/auth/models/user_model.dart';
import '../constants/color.dart';

class MainHeader extends StatelessWidget {
  final String title;

  const MainHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _fetchUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          return Container(
            decoration: BoxDecoration(color: ColorConstant.black),
            child: Column(
              spacing: 12,
              children: [
                SizedBox(height: 30,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const SizedBox(width: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        'assets/images/Benevolix.png',
                        width: 50,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "${user.firstName} ${user.lastName}",
                      style: TextStyle(
                        color: ColorConstant.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Text('No user data');
        }
      },
    );
  }

  Future<User?> _fetchUser() async {
    final userId = await getUserId();
    if (userId != null) {
      final userService = UserService();
      return userService.getUser(userId);
    }
    return null;
  }
}
