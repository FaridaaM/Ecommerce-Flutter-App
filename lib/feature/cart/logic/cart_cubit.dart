import 'package:counter/core/db/local_db/local_db_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../data/model/product_cart_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  double totalPrice = 0;
  List<ProductCartModel> cartProducts = [];

  Future<void> getCartData() async {
    emit(CartLoading());
    try {
      final cartItems = await SQLHelper.getCartProducts(); // ✅ Fetch cart data
      cartProducts = cartItems.map((e) => ProductCartModel.fromJson(e)).toList();
      calculateTotalPrice();
      emit(CartLoaded(cartProducts: cartProducts));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }


  Future<void> addProductToCart(ProductCartModel product) async {
    emit(CartLoading());
    try {
      await SQLHelper.insertProduct(product.toJson());
      cartProducts.add(product);
      calculateTotalPrice();
      emit(CartLoaded(cartProducts: List.from(cartProducts)));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> deleteProduct(String id) async {
    emit(CartLoading());
    try {
      await SQLHelper.deleteProduct(id);
      cartProducts.removeWhere((product) => product.id == id);
      calculateTotalPrice();
      emit(CartLoaded(cartProducts: List.from(cartProducts))); // ✅ Emit updated state
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }


  void calculateTotalPrice() {
    totalPrice = 0;
    for (var product in cartProducts) {
      totalPrice += (product.quantity ?? 1) * (product.price ?? 0.0);
    }
  }
}
