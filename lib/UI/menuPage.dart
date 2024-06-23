import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:frist_pages/UI/ProductDetailsPage.dart';
import 'package:frist_pages/UI/cart_page.dart';
import 'package:frist_pages/UI/home_page.dart';
import 'package:frist_pages/cubits/cubit/favorites_cubit.dart';
import 'package:frist_pages/cubits/cubit/product_cubit.dart';
import 'package:frist_pages/cubits/cubit/shopping_cubit.dart';
import 'package:frist_pages/cubits/cubit/user_cubit.dart';
import 'package:frist_pages/dataLayer/dataBase.dart';
import 'package:frist_pages/dataLayer/model/favorite.dart';
import 'package:frist_pages/dataLayer/model/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';



class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  int favoriteId = 0;


  @override
  Widget build(BuildContext context) {
    ProductCubit pc=BlocProvider.of<ProductCubit>(context);
     pc.AllProducts();
    FavoritesCubit fc=BlocProvider.of<FavoritesCubit>(context);
     fc.loadUserFavoriteProducts(BlocProvider.of<UserCubit>(context).userId!);

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
           if (state is ProductLoadingState) {
          return Center(child: CircularProgressIndicator());
        }  
        else if (state is productLoadedState  ) {
          final products = state.Products;

          final List<String> categories =["Appetizers","Salads","Main Courses" , "desserts","Drinks"];

          return DefaultTabController(
            length: categories.length,
            child: Scaffold(
              appBar: AppBar(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
        toolbarHeight: 80,
        title: const Text("Food Menu" , 
                    style: TextStyle(color:Color.fromARGB(165, 47, 11, 11), 
                    fontWeight:FontWeight.bold ),), centerTitle: true,
       backgroundColor: Color.fromARGB(255, 231, 218, 218),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
                bottom: categories.isNotEmpty
                    ? TabBar(
                        isScrollable: true,
                        tabs: categories
                            .map((category) => Tab(text: category))
                            .toList(),
                      )
                    : null,
              ),
              body: 
              categories.isNotEmpty
                  ? TabBarView(
                      children: categories.map((category) {
                        final categoryProducts = products
                            .where((product) => product.category == category)
                            .toList();
                        return buildMenuItems(categoryProducts);
                      }).toList(),
                    )
                  : const Center(
                      child: Text('No products available.'),
                    ),
                    
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  ShoppingCubit shc=BlocProvider.of<ShoppingCubit>(context);
                 shc.loadCart(BlocProvider.of<UserCubit>(context).userId!);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },
                child: Icon(Icons.shopping_cart),
                tooltip: 'View Cart',
              ),

            ),
          );
        } 
        else {
          return Center(child: Text('Unknown state'));
        }
      },
    );
    
  }

Widget buildMenuItems(List<Product> items) {
  return ListView.builder(
    itemCount: items.length + 1, // عشان بعد منخلصهم كلهم نزود سبيس تحت لل كارت بوتن
    itemBuilder: (context, index) {

      if (index == items.length) {
        return Container(height: 80.0); 
      }
      
      return buildMenuItem(items[index]);
    },
  );
}


  Widget buildMenuItem(Product item) {
  return Card(
    child: InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductDetailsPage(product: item)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              item.image,
              height: 250,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(item.description),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'E£${item.price.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Added to cart successfully'),
                                  backgroundColor: Colors.green),
                            );
                            context.read<ShoppingCubit>().addToCart(
                                BlocProvider.of<UserCubit>(context).userId!,
                                item.id!,
                                1);
                          },
                          child: Text('Add to Cart'),
                        ),
                        BlocBuilder<FavoritesCubit, FavoritesState>(
                          builder: (context, state) {
                            bool isFavorite = false;
                            if (state is FavoriteLoadedState) {
                              isFavorite = state.userFavorites
                                  .any((favorite) => favorite.id == item.id);
                            }
                            return IconButton(
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isFavorite ? Colors.red : null,
                              ),
                              onPressed: () {
                                if (isFavorite) {
                                  context
                                      .read<FavoritesCubit>()
                                      .userRemoveFromFavorites(
                                          BlocProvider.of<UserCubit>(context)
                                              .userId!,
                                          item.id!);
                                } else {
                                  context
                                      .read<FavoritesCubit>()
                                      .userAddToFavorites(Favorite(
                                          null,
                                          BlocProvider.of<UserCubit>(context)
                                              .userId!,
                                          item.id!));
                                }
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}
