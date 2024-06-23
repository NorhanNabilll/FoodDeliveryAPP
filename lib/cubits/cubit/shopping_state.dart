part of 'shopping_cubit.dart';

@immutable
sealed class ShoppingState {}

final class ShoppingInitial extends ShoppingState {}

class CartLoadingState extends ShoppingState {}

class CartLoadedState extends ShoppingState {
  final List<cartItem> products;

  CartLoadedState(this.products);
}

class CartEmptyState extends ShoppingState {}

class OrderProcessingState extends ShoppingState {}

class OrderSuccessState extends ShoppingState {}

class OrderFailureState extends ShoppingState {}
