import 'package:flutter/material.dart';
import 'package:tibachap/user_provider.dart';

class UserInfoDisplay extends StatelessWidget {
  final UserProvider userProvider;

  const UserInfoDisplay({super.key, required this.userProvider});

  @override
  Widget build(BuildContext context) {
    return Text(
      userProvider.isLoggedIn()
          ? 'Welcome, ${userProvider.user!.email}'
          : 'You are not logged in',
    );
  }
}
