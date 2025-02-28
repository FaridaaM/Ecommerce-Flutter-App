import 'package:flutter/material.dart';
class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFEFE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Privacy Policy",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("1. Types of Data We Collect"),
            _buildParagraph(
                "We collect various types of data to provide and improve our services. "
                    "This includes personal information such as your name, email address, "
                    "and payment details, as well as non-personal data like device information and browsing activity."
            ),

            _buildSectionTitle("2. Use of Your Personal Data"),
            _buildParagraph(
                "Your personal data is used to enhance your experience, facilitate transactions, "
                    "and personalize content. We may also use this information to improve our services, "
                    "communicate updates, and provide customer support."
            ),

            _buildSectionTitle("3. Disclosure of Your Personal Data"),
            _buildParagraph(
                "We do not share your personal data with third parties except in the following cases:\n"
                    "• When required by law or legal processes.\n"
                    "• To protect the rights and safety of our users and business.\n"
                    "• With trusted partners who assist in providing our services under strict confidentiality agreements."
            ),
            _buildSectionTitle("4. Types of Data We Collect"),
            _buildParagraph(
                "We collect various types of data to provide and improve our services. "
                    "This includes personal information such as your name, email address, "
                    "This includes personal information such as your name, email address, "
                    "and payment details, as well as non-personal data like device information and browsing activity."
            ),

            _buildSectionTitle("5. Use of Your Personal Data"),
            _buildParagraph(
                "Your personal data is used to enhance your experience, facilitate transactions, "
                    "and personalize content. We may also use this information to improve our services, "
                    "and personalize content. We may also use this information to improve our services, "
                    "communicate updates, and provide customer support."
            ),

            _buildSectionTitle("6. Disclosure of Your Personal Data"),
            _buildParagraph(
                "We do not share your personal data with third parties except in the following cases:\n"
                    "• When required by law or legal processes.\n"
                    "• To protect the rights and safety of our users and business.\n"
                    "• With trusted partners who assist in providing our services under strict confidentiality agreements."
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Helper method to create paragraphs
  Widget _buildParagraph(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black54,
          height: 1.5, // Increases readability
        ),
        textAlign: TextAlign.justify, // Justifies the text
      ),
    );
  }
}
