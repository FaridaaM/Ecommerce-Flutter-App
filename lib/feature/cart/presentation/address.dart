import 'package:flutter/material.dart';
import 'package:counter/feature/cart/presentation/pay.dart';

class SelectAddressPage extends StatefulWidget {
  @override
  _SelectAddressPageState createState() => _SelectAddressPageState();
}

class _SelectAddressPageState extends State<SelectAddressPage> {
  int? selectedAddressIndex;

  final List<Map<String, String>> addresses = [
    {"title": "Home", "details": "123 Main Street, New York, NY 10001"},
    {"title": "Office", "details": "456 Corporate Blvd, Los Angeles, CA 90012"},
    {"title": "Apartment", "details": "789 High Rise Ave, Chicago, IL 60611"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Make background same as card
      appBar: AppBar(
        title: Text("Select Address", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white, // Match background
        foregroundColor: Colors.black, // Ensure visibility
        elevation: 0, // Remove shadow for a cleaner look
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAddressIndex = index;
                    });
                  },
                  child: Card(
                    color: selectedAddressIndex == index ? Colors.white : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: selectedAddressIndex == index ? Colors.orange : Colors.grey.shade300,
                      ),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      padding: EdgeInsets.all(16),
                      height: 120, // Set the height of the card
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 32, // Bigger icon
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  addresses[index]['title']!,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  addresses[index]['details']!,
                                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                                ),
                              ],
                            ),
                          ),
                          if (selectedAddressIndex == index)
                            Icon(Icons.check_circle, color: Colors.orange, size: 28),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
             onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewAddressPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                backgroundColor: Color(0xFF2D3C52),
              ),
              child: Center(
                child: Text("Select Address", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),

          )
        ],
      ),
    );
  }
}
