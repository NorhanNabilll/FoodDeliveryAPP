part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {
  
}

final class addProductState extends ProductState {}

class ProductLoadingState extends ProductState {
}

final class categoryProductsState extends ProductState {
  List<Product>categoryProducts=[];
  categoryProductsState(this.categoryProducts);
}

final class productLoadedState extends ProductState {
  List<Product>Products=[];
  productLoadedState(this.Products);
}

final class featuredProductState extends ProductState {
  List<Product>featuredProducts=[];
  featuredProductState(this.featuredProducts);
}