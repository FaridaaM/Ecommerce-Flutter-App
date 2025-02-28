import 'package:flutter/material.dart';
import 'package:counter/feature/home/presentation/search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter/feature/cart/presentation/cart_screen.dart';
import 'package:counter/feature/cart/presentation/fav.dart';
import 'package:counter/feature/profile/profile_screen.dart';
import 'package:counter/feature/home/logic/home_cubit.dart';
import 'package:counter/feature/home/data/model/product_model.dart';
import 'package:counter/feature/home/presentation/product_details_screen.dart';
import 'package:counter/feature/cart/presentation/fav.dart';
import 'package:flutter_svg/flutter_svg.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Wishlist"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    );
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return SearchScreen();
      case 2:
        return FavScreen();
      case 3:
        return CartScreen();
      case 4:
        return ProfilePage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () => context.read<HomeCubit>().getHomeData(),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader(context)),
                SliverToBoxAdapter(child: _buildBanner(context)),
                SliverToBoxAdapter(child: _buildCategorySection()),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        var product = context.watch<HomeCubit>().products[index];
                        return _buildProductCard(product, context);
                      },
                      childCount: context.watch<HomeCubit>().products.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchPage() {
    return Center(
      child: Text("-"),
    );
  }



  Widget _buildProfilePage() {
    return Center(
      child: Text("-"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getSelectedScreen(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

Widget _buildHeader(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  );
}

Widget _buildBanner(BuildContext context) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFFFDA56C), Color(0xFFFD6C8A)]),
        ),
      ),
      Positioned(
        top: 80,
        left: 20,
        child: Row(
          children: [
            _buildCircleIcon(Icons.location_on),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("location", style: TextStyle(color: Colors.white)),
                Text("Condong Catur", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(width: 70),
            _buildCircleIcon(Icons.notifications),
            SizedBox(width: 20),
            SvgPicture.asset("assets/girl-svgrepo-com.svg", height: 50, width: 50),
          ],
        ),
      ),
      Positioned(
        right: 35,
        top: 150,
        child: Text("Find best device for \nyour setup!",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 33)),
      ),
      Positioned(
        top: 270,
        left: 25,
        right: 25,
        child: _buildPromoBanner(),
      ),
      Positioned(
        right: 20,
        top: 245,
        child: Image.asset("assets/Image.png", height: 250, fit: BoxFit.contain),
      ),
    ],
  );
}

Widget _buildPromoBanner() {
  return Container(
    height: 180,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: LinearGradient(colors: [Colors.indigoAccent.shade100, Color(0xFF1565C0)]),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("New Bing \nWireless \nEarphone",
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Text("See Offer", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(width: 5),
              Icon(Icons.arrow_forward, color: Colors.white, size: 16),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildCategorySection() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Row(
      children: [SizedBox(height: 50)],
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
      color: Color(0xFFFAFAFA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(product.image!, height: 80, width: double.infinity, fit: BoxFit.fitHeight),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Text("\$${product.price}", style: TextStyle(color: Colors.orange)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCircleIcon(IconData icon) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), shape: BoxShape.circle),
    child: Icon(icon, size: 30, color: Colors.white),
  );
}
