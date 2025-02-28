part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {  // ✅ Add cartProducts field
  final List<ProductCartModel> cartProducts;

  CartLoaded({required this.cartProducts});
}

class CartProductAdded extends CartState {}

class CartProductDeleted extends CartState {}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
