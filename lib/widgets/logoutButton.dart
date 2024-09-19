import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30, left: 40),
      child: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text(
          'Logout',
          style: TextStyle(
              color: Colors.white,
              decorationColor: Colors.white,
              decoration: TextDecoration.underline,
              fontSize: 16),
        ),
      ),
    );
  }
}