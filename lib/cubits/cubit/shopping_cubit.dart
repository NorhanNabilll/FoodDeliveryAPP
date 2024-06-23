import 'package:bloc/bloc.dart';
import 'package:frist_pages/dataLayer/dataBase.dart';
import 'package:frist_pages/dataLayer/model/cartProduct.dart';
import 'package:meta/meta.dart';


part 'shopping_state.dart';

class ShoppingCubit extends Cubit<ShoppingState> {
  ShoppingCubit() : super(ShoppingInitial());

  DataBaseHandler d=DataBaseHandler();

  Future<void> loadCart(int userId) async {
    emit(CartLoadingState());
    try {
      List<cartItem> products = await d.showCart(userId);
      if (products.isNotEmpty) {
        emit(CartLoadedState(products));
      } else {
        emit(CartEmptyState());
      }
    } catch (e) {
      print(e.toString());
    }
  }


  void addToCart(int userId, int productId, int quantity) async {
    try {
      await d.addToCart(userId, productId, quantity);
      loadCart(userId); 
    } catch (e) {
      print(e.toString());
    }
  }

  void removeFromCart(int userId, int productId) async {
    try {
      await d.deleteFromcart(userId, productId);
      loadCart(userId); 
    } catch (e) {
      print(e.toString());
    }
  }

  
  void updateCartItemQuantity(int userId, int productId, int quantity) async {
    try {
      await d.updateCartItemQuantity(quantity, userId, productId);
      loadCart(userId); 
    } catch (e) {
      print(e.toString());
    }
  }

  void placeOrder(int userId, String shippingAddress, double totalPrice) async {
    emit(OrderProcessingState());
    try {
      await d.order(userId, shippingAddress, totalPrice);
      emit(OrderSuccessState());
      loadCart(userId); 
    } catch (e) {
      emit(OrderFailureState());
    }
  }

}

