part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeUserLoading extends HomeState {}

class HomeUserLoaded extends HomeState {}
class HomeProductsLoaded extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProductModel> products;
  HomeLoaded(this.products);
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
class HomeFavoritesAndCartState extends HomeState {
  final List<ProductModel> favorites;
  final List<ProductModel> cart;

  HomeFavoritesAndCartState({required this.favorites, required this.cart});

  HomeFavoritesAndCartState copyWith({
    List<ProductModel>? favorites,
    List<ProductModel>? cart,
  }) {
    return HomeFavoritesAndCartState(
      favorites: favorites ?? this.favorites,
      cart: cart ?? this.cart,
    );
  }
}

class ProductDetailsLoaded extends HomeState {}
class ProductDetailsLoading extends HomeState {}  // ✅ Add this if missing

class HomeUserError extends HomeState {
  final String error;
  HomeUserError(this.error);
}


class HomeProductsError extends HomeState {
  final String error;
  HomeProductsError(this.error);
}


class ProductDetailsError extends HomeState {
  final String error;
  ProductDetailsError(this.error);
}

/// 🛒 **New CartUpdated state**
class CartUpdated extends HomeState {
  final List<ProductModel> cart;
  CartUpdated(this.cart);
}
class FavoritesUpdated extends HomeState {
  final List<ProductModel> favorites;
  FavoritesUpdated(this.favorites);
}
