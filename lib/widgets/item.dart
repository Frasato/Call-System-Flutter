import 'package:estudando_flutter/constants/color.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  final String title;
  final String whoCalled;
  final String sector;
  final String description;
  final String role;
  final String time;
  final VoidCallback onPressed;

  const Item({
    super.key,
    required this.title,
    required this.description,
    required this.sector,
    required this.whoCalled,
    required this.role,
    required this.time,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: primaryYellow,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Text(
              whoCalled,
              style: const TextStyle(
                  color: lightGreyColor, fontSize: 16),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              '|',
              style: TextStyle(color: lightGreyColor),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              sector,
              style: const TextStyle(
                  color: lightGreyColor, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          description,
          style: const TextStyle(
              color: Colors.white, fontSize: 16),
        ),
        const Spacer(),
        role == "ADMIN"
            ? ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryYellow,
                  padding: const EdgeInsets.symmetric(
                      vertical: 15),
                ),
                child: const Text('Finish'))
            : Text(time),
      ],
    );
  }
}