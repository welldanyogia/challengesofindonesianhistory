import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const MenuButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: EdgeInsets.only(top: topMargin, left: leftMargin),
      height: 100,
      width: 200,
      child: Card(
        color: Colors.white.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.brown.withOpacity(0.6), width: 3),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.brown.withOpacity(0.6), width: 3),
            ),
          ),
          child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 40,
              )
          ),
        ),
      ),
    );
  }
}