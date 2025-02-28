import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter/feature/cart/logic/cart_cubit.dart';
import 'package:counter/feature/cart/presentation/address.dart';
import 'package:counter/feature/cart/presentation/address.dart';


class ConfirmOrderScreen extends StatelessWidget {
  const ConfirmOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProducts = context
        .watch<CartCubit>()
        .cartProducts;
    final totalPrice = context
        .watch<CartCubit>()
        .totalPrice;

    return Scaffold(
      backgroundColor: Colors.white, // Ensure consistent white background
      appBar: AppBar(
        title: const Text("Confirm Order"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Address"),
            _buildAddressCard(),
            _buildSectionTitle("Items"),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartProducts.length,
              itemBuilder: (context, index) {
                final product = cartProducts[index];
                return _buildCartItem(product);
              },
            ),
            _buildSectionTitle("Shipping"),
            _buildShippingMethod(),
            _buildSectionTitle("Payment Summary"),
            _buildPaymentSummary(totalPrice),
            const SizedBox(height: 10),
            _buildConfirmButton(context, totalPrice),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAddressCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.location_on, color: Colors.red),
        title: const Text("Home"),
        subtitle: const Text("123, Main Street, New York, NY 10001"),
        trailing: TextButton(
          onPressed: () {},
          child: const Text("Edit", style: TextStyle(color: Colors.blue)),
        ),
      ),
    );
  }

  Widget _buildCartItem(product) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Image.network(
            product.image!, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(product.title!),
        subtitle: Text("${product.price} x ${product.quantity}"),
        trailing: Text(
            "\$${(product.price! * product.quantity!).toStringAsFixed(2)}"),
      ),
    );
  }

  Widget _buildShippingMethod() {
    return Card(
      color: Colors.white,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.local_shipping, color: Colors.red),
        title: const Text("AT Express"),
        subtitle: const Text("Estimated delivery: 3-5 days"),
      ),
    );
  }

  Widget _buildPaymentSummary(double totalPrice) {
    return Card(
      color: Colors.white,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryRow("Price", totalPrice - 5.00),
            _buildSummaryRow("Delivery Fee", 5.00),
            const Divider(),
            _buildSummaryRow("Total Payment", totalPrice, isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text("\$${value.toStringAsFixed(2)}", style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context, double totalPrice) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectAddressPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF2D3C52),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(42)),
        ),
        child: Text("Pay \$${totalPrice.toStringAsFixed(2)}",
            style: const TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }
}
