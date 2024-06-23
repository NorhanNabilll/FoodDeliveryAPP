import 'package:bloc/bloc.dart';
import 'package:frist_pages/dataLayer/dataBase.dart';
import 'package:frist_pages/dataLayer/model/favorite.dart';
import 'package:frist_pages/dataLayer/model/product.dart';
import 'package:meta/meta.dart';


part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  DataBaseHandler db=DataBaseHandler();

  void loadUserFavoriteProducts(int userId) async {
    emit(FavoriteLoadingState());
    List<Product> userFavorites=await db.userFavoriteProducts(userId);
    emit(FavoriteLoadedState(userFavorites));
  }

  
  void userAddToFavorites(Favorite f) async {
    emit(FavoriteLoadingState());
    db.addToFavorites(f);
    List<Product> userFavorites=await db.userFavoriteProducts(f.u_id);
    emit(FavoriteLoadedState(userFavorites));
  }


  void userRemoveFromFavorites(int UserId , int productId) async {
    emit(FavoriteLoadingState());
    db.daleteFromFavorites(UserId, productId);
    List<Product> userFavorites=await db.userFavoriteProducts(UserId);
    emit(FavoriteLoadedState(userFavorites));
  }

}
