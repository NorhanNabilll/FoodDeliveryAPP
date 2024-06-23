import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_pages/cubits/cubit/favorites_cubit.dart';
import 'package:frist_pages/cubits/cubit/shopping_cubit.dart';
import 'package:frist_pages/cubits/cubit/user_cubit.dart';
import 'package:frist_pages/dataLayer/model/favorite.dart';
import 'package:frist_pages/dataLayer/model/product.dart';


class ProductDetailsPage extends StatelessWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name , style: TextStyle(color:Color.fromARGB(243, 47, 11, 11), 
                    fontWeight:FontWeight.bold ),),centerTitle: true,
        backgroundColor: Colors.white60,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color.fromARGB(255, 230, 196, 196)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      product.image,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  product.name,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 104, 46, 46),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'E£${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added to cart successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        context.read<ShoppingCubit>().addToCart(
                            BlocProvider.of<UserCubit>(context).userId!,
                            product.id!,
                            1);
                      },
                      icon: Icon(Icons.shopping_cart),
                      label: Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Color.fromARGB(255, 121, 61, 61),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    BlocBuilder<FavoritesCubit, FavoritesState>(
                      builder: (context, state) {
                        bool isFavorite = false;
                        if (state is FavoriteLoadedState) {
                          isFavorite = state.userFavorites
                              .any((favorite) => favorite.id == product.id);
                        }

                        return ElevatedButton.icon(
                          onPressed: () {
                            if (isFavorite) {
                              context
                                  .read<FavoritesCubit>()
                                  .userRemoveFromFavorites(
                                      BlocProvider.of<UserCubit>(context)
                                          .userId!,
                                      product.id!);
                            } else {
                              context.read<FavoritesCubit>().userAddToFavorites(
                                  Favorite(
                                      null,
                                      BlocProvider.of<UserCubit>(context)
                                          .userId!,
                                      product.id!));
                            }
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: Colors.white,
                          ),
                          label: Text(isFavorite
                              ? 'Remove from Favorites'
                              : 'Add to Favorites'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: isFavorite ? Color.fromARGB(255, 173, 46, 46) : Color.fromARGB(255, 121, 61, 61),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Details',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 58, 27, 27),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Category: ${product.category}',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 5),
                     
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
