import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class CustomSocialButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onPressed;

  const CustomSocialButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16), // Added horizontal padding
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade400),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Aligns to the left
          children: [
            SizedBox(width: 10),
            SvgPicture.asset(iconPath, height: 24),
            Expanded(
              child: Center(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 16),
                ),

              ),
            ),
            SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
