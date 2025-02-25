part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeUserLoading extends HomeState {}

final class HomeUserLoaded extends HomeState {}

final class HomeUserError extends HomeState {
  final String message;
  HomeUserError(this.message);
}

final class HomeProductsLoading extends HomeState {}

final class HomeProductsLoaded extends HomeState {}

final class HomeProductsError extends HomeState {
  final String message;
  HomeProductsError(this.message);
}

final class ProductDetailsLoading extends HomeState {}

final class ProductDetailsLoaded extends HomeState {}

final class ProductDetailsError extends HomeState {
  final String message;
  ProductDetailsError(this.message);
}

// ✅ New State for Favorites & Cart
class HomeFavoritesAndCartState extends HomeState {
  final List<ProductModel> favorites;
  final List<ProductModel> cart;

  HomeFavoritesAndCartState({required this.favorites, required this.cart});

  HomeFavoritesAndCartState copyWith({List<ProductModel>? favorites, List<ProductModel>? cart}) {
    return HomeFavoritesAndCartState(
      favorites: favorites ?? this.favorites,
      cart: cart ?? this.cart,
    );
  }
}
