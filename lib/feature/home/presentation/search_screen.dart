import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter/feature/home/logic/home_cubit.dart';
import 'package:counter/feature/home/data/model/product_model.dart';
import 'package:counter/feature/home/presentation/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    final homeCubit = context.read<HomeCubit>();

    print("🔍 Products in SearchScreen: ${homeCubit.products.length}");

    if (homeCubit.products.isEmpty) {
      print("🟡 Fetching products again...");
      homeCubit.getProducts();
    }

    _filteredProducts = homeCubit.products;
  }


  void _filterProducts(String query) {
    final homeCubit = context.read<HomeCubit>();
    setState(() {
      _filteredProducts = homeCubit.products
          .where((product) =>
          (product.title ?? "").toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,  // Match Figma background
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            controller: _searchController,
            onChanged: _filterProducts,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              hintText: "Search laptop, headset...",
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          print("🔄 SearchScreen state: $state");

          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeProductsLoaded || state is HomeLoaded) {
            final homeCubit = context.read<HomeCubit>();
            final products = _searchController.text.isEmpty
                ? homeCubit.products
                : _filteredProducts;

            print("📦 Products in UI: ${products.length}");

            return products.isNotEmpty
                ? _buildProductGrid(products)
                : const Center(child: Text("No products found"));
          } else if (state is HomeProductsError) {
            return Center(child: Text("Error: ${state.error}"));
          }
          return const Center(child: Text("No products available"));
        },
      ),

    );
  }

  Widget _buildProductGrid(List<ProductModel> products) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          var product = products[index];
          return _buildProductCard(product, context);
        },
      ),
    );
  }

  Widget _buildProductCard(ProductModel product, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                product.image!,
                height: 100,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title!,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 5),
                  Text("\$${product.price}",
                      style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
