import 'package:bloc/bloc.dart';
import 'package:frist_pages/dataLayer/dataBase.dart';
import 'package:frist_pages/dataLayer/model/product.dart';
import 'package:meta/meta.dart';


part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  DataBaseHandler db=DataBaseHandler();

  Future<void> AllProducts() async {
    emit(ProductLoadingState());
    List<Product> products=await db.allProducts();
    emit(productLoadedState(products));
  }

  Future<void>ProductsByCategory(String category) async {
    emit(ProductLoadingState());
    List<Product> products=await db.categoryProducts(category);
    emit(categoryProductsState(products));
  }


  Future<void> FeaturedProducts() async {
    emit(ProductLoadingState());
    List<Product> products=await db.featuredProducts();
    emit(featuredProductState(products));
  }

  void addProduct(Product p){
    db.addProduct(p);
  }
}
