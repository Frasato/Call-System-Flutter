import 'package:flutter/material.dart';

class CallItem extends StatelessWidget {
  final String title;
  final String username;
  final String time;
  final String role;

  const CallItem({
    super.key,
    required this.title,
    required this.username,
    required this.time,
    required this.role
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                username,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
              ),
              role == 'ADMIN'
                  ? Text(
                      time,
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    )
                  : const Text(''),
            ],
          ),
        ],
      ),
    );
  }
}