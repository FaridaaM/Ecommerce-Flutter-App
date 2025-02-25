import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFF),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/success.svg",
              width: 200,
            ),
            SizedBox(height: 20),
            Text(
              "Congratulations!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Your account is ready to use. You will be redirected\n to the Homepage in a few seconds.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2D3C52),
                foregroundColor: Colors.white,
                minimumSize: Size(340, 55),
              ),
              child: Text(
                "Continue",
                style: TextStyle(fontSize: 17),
              ),
            ),
            SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}
