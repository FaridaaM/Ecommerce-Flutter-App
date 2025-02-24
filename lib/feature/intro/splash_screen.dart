import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:counter/core/db/cache/cache_helper.dart';
import 'package:counter/feature/auth/presentation/login_screen.dart';
import 'package:counter/feature/home/presentation/onboard1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../auth/presentation/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? token;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await CacheHelper.init();
    setState(() {
      token = CacheHelper.getData(key: "token");
      isLoading = false; // Ensure UI updates after data is loaded
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loader until token loads
            : FlutterSplashScreen.fadeIn(
          nextScreen: token != null ? OnboardingScreen() : LoginScreen(),
          backgroundColor: Colors.white,
          duration: const Duration(seconds: 5), // **Ensure it stays long enough**
          onInit: () async {
            await Future.delayed(Duration(milliseconds: 500)); // **Ensures elements appear**
          },
          onEnd: () async {
            debugPrint("Splash Screen Ended");
          },
          childWidget: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/logo.svg",
                  height: 120,
                  width: 120,
                  placeholderBuilder: (context) =>
                      CircularProgressIndicator(),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Zalada",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
