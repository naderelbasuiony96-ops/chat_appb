import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.onTap, required this.text});
  VoidCallback? onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        height: 60,
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
