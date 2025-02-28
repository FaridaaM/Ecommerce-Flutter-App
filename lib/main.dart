import 'package:counter/core/db/cache/cache_helper.dart';
import 'package:counter/core/db/local_db/local_db_helper.dart';
import 'package:counter/core/network/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counter/feature/cart/presentation/fav.dart';

import 'feature/home/logic/home_cubit.dart';
import 'feature/intro/splash_screen.dart';
import 'package:counter/feature/home/presentation/home_screen.dart';
import 'package:counter/feature/cart/logic/cart_cubit.dart';

import 'package:counter/feature/cart/presentation/cart_screen.dart';
import 'package:counter/feature/home/presentation/search_screen.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await SQLHelper.database;
  await CacheHelper.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (context) => HomeCubit()),// ✅ Ensure CartCubit is provided
// ✅ Ensure CartCubit is provided

      ],
      child: const MyApp(), // Ensure MyApp is properly instantiated
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App',
      initialRoute: '/', // ✅ Ensure the correct initial route
      onGenerateRoute: (settings) {

          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => SplashScreen());
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeScreen());
            case '/cart':
              return MaterialPageRoute(builder: (_) => CartScreen());
            case '/wishlist': // ✅ Add Wishlist Route
              return MaterialPageRoute(builder: (_) => FavScreen());
            default:
              return MaterialPageRoute(builder: (_) => HomeScreen());
          }
      },
    );
  }
}
