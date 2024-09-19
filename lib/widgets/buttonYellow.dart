import 'package:estudando_flutter/constants/color.dart';
import 'package:flutter/material.dart';

class ButtonYellow extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final double marginTopValue;

  const ButtonYellow({
    super.key,
    required this.label,
    required this.onPressed,
    required this.marginTopValue
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: marginTopValue),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryYellow,
          foregroundColor: Colors.black87,
          elevation: 0.0,
        ),
        child: Text(label),
      ),
    );
  }
}
