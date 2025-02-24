import 'package:counter/feature/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:counter/feature/auth/presentation/login_screen.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = (index == 2);
              });
            },
            children: [
              OnboardingPage(
                image: "assets/entrance1.svg",
                title: "Find the item you've been looking for",
                description:
                "Here you'll see rich varieties of goods, carefully classified for seamless browsing experience.",
              ),
              OnboardingPage(
                image: "assets/entrance2.svg",
                title: "Get those shopping bags filled",
                description:
                "Add any item you want to your cart or save it on your wishlist so you don't miss it.",
              ),
              OnboardingPage(
                image: "assets/entrance3.svg",
                title: "Fast and secure payments",
                description:
                "There are many ways to pay for your orders, making it easy and safe to complete your purchase.",
              ),
            ],
          ),

          // Skip Button (Top-Right)
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () => _controller.jumpToPage(2),
              child: Text("Skip", style: TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ),

          // Arrow Button (Moved Higher)
          Positioned(
            bottom: 100, // <-- Increased from 80 to 100 (Moves it up)
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                if (isLastPage) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                } else {
                  _controller.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: SvgPicture.asset("assets/arrow.svg", height: 100),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image, title, description;

  const OnboardingPage({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0), // <-- Moved everything up
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start, // <-- Changed to start instead of center
        children: [
          SizedBox(height: 110),
          SvgPicture.asset(image, height: 280), // <-- Reduced height to fit better
          SizedBox(height: 20), // Increased spacing
          Text(
            title,
            style: TextStyle(
              fontSize: 30, // Increased from 26 to 30
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15), // More space between title and description
          Text(
            description,
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
