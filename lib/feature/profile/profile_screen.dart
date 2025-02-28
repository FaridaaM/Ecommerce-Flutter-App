import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:counter/feature/auth/presentation/login_screen.dart';
import 'package:counter/feature/home/presentation/home_screen.dart';
import 'package:counter/feature/profile/privacy_doc.dart';
import 'package:counter/feature/profile/payment.dart';
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFEFE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()), // Replace with your actual Home screen widget
            );
          },
        ),

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  ClipOval(
                    child: SvgPicture.asset(
                      "assets/girl-svgrepo-com.svg",
                      width: 100, // Adjust size accordingly
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Bryan Adam",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "bryan.adam@gmail.com",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ProfileSection(title: "Account Settings", items: [
              ProfileOption(icon: Icons.location_on, title: "Address"),
              ProfileOption(
                icon: Icons.payment,
                title: "Payment Method",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PayPage()),
                  );
                },
              ),
              ProfileOption(icon: Icons.notifications, title: "Notification", switchable: true),
              ProfileOption(icon: Icons.lock, title: "Account Security"),
            ]),
            ProfileSection(title: "General", items: [
              ProfileOption(icon: Icons.people, title: "Invite Friends"),
              ProfileOption(
                icon: Icons.privacy_tip,
                title: "Privacy Policy",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                  );
                },
              ),
              ProfileOption(icon: Icons.help_outline, title: "Help Center"),
            ]),
            Center(
              child: TextButton(
                onPressed: () {
                  // Navigate to the login screen and clear previous screens
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your login screen widget
                        (route) => false, // This removes all previous routes
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 28),
                    Icon(FontAwesomeIcons.signOutAlt, color: Colors.red),
                    SizedBox(width: 8),
                    Text("Logout", style: TextStyle(color: Colors.red, fontSize: 20)),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final String title;
  final List<ProfileOption> items;

  ProfileSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          ...items,
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool switchable;
  final VoidCallback? onTap; // Add this

  ProfileOption({required this.icon, required this.title, this.switchable = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, size: 28, color: Colors.black54),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        trailing: switchable
            ? Switch(value: true, onChanged: (bool value) {})
            : Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black45),
        onTap: onTap, // Use the callback
      ),
    );
  }
}
