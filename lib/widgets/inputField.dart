import 'package:estudando_flutter/constants/color.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final double widthField;
  final double bottomValue;
  final double topValue;
  final double rightValue;

  const InputField({
    super.key,
    required this.controller,
    required this.icon,
    required this.label,
    required this.widthField,
    required this.bottomValue,
    required this.topValue,
    required this.rightValue
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthField,
      margin: EdgeInsets.only(bottom: bottomValue, top: topValue, right: rightValue),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          label: Text(label, style: const TextStyle(color: Colors.white),),
          fillColor: greyColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2.0,
              color: primaryYellow,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(5)
          ),
          labelStyle: const TextStyle(
            fontWeight: FontWeight.w600
          ),
          prefixIcon: Icon(icon, color: lightGreyColor,),
        ),
      ),
    );
  }
}