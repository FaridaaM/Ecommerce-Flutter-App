import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int time = 60;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (time > 0) {
        setState(() {
          time--;
        });
      } else {
        timer.cancel(); // Stop timer at 0
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OTP")),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                SvgPicture.asset(
                  "assets/otp.svg",
                  width: 250,
                ),
                Positioned(
                  top: 0,
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    dashPattern: [10, 6],
                    color: Colors.grey,
                    strokeWidth: 2,
                    child: Container(
                      width: 245,
                      height: 215,
                      color: Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Verification Code",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                          text: "We have sent the code verification to your \nWhatsApp Number "),
                      TextSpan(
                        text: "+62812 788 6XXXX",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            PinCodeTextField(
              length: 4,
              appContext: context,
              onChanged: (value) {},
              keyboardType: TextInputType.number,
              cursorColor: Colors.grey,
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(10),
                fieldHeight: 75,
                fieldWidth: 75,
                activeFillColor: Colors.white,
                inactiveFillColor: Colors.grey.shade200,
                activeColor: Colors.grey.shade200,
                inactiveColor: Colors.grey.shade200,
                selectedColor: Colors.grey.shade200,
              ),
            ),
            SizedBox(height: 20),
            Text(
              time > 0 ? "Resend code in $time s" : "Resend Code",
              style: TextStyle(
                fontSize: 16,
                color: time > 0 ? Colors.grey : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: time >= 0 ? () => startTimer() : null,
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Color(0xFF2D3C52),
                foregroundColor: Colors.white,
              ),
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
