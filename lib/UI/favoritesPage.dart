// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_pages/UI/ProductDetailsPage.dart';
import 'package:frist_pages/cubits/cubit/favorites_cubit.dart';
import 'package:frist_pages/cubits/cubit/shopping_cubit.dart';
import 'package:frist_pages/cubits/cubit/user_cubit.dart';



class FavoritePage extends StatelessWidget {


  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 241, 241, 0.968),
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
        toolbarHeight: 80,
        title: const Text("Favorite Products" , 
                    style: TextStyle(color:Color.fromARGB(165, 47, 11, 11), 
                    fontWeight:FontWeight.bold ),), centerTitle: true,
       backgroundColor: Color.fromARGB(255, 232, 208,208),
       ),


      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoriteLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is FavoriteLoadedState) {
            if (state.userFavorites.isEmpty) {
              return Center(child: Text('No favorite products'));
            }

            final products=state.userFavorites;
            final userId = BlocProvider.of<UserCubit>(context).userId!;

            return ListView.builder
             (
              itemCount: products.length,
              itemBuilder: (context, index)
              {
                final cartItem = products[index];
                return Stack(
                  children: [
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Color.fromARGB(255, 255, 255, 255),
                      
                      child: ListTile(

                       //image
                        leading:
                        Container(
                              width: 80,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(cartItem.image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                       //Name
                        title:
                         Text(cartItem.name , 
                              style:
                               TextStyle( color: const Color.fromARGB(255, 20, 17, 17),
                               fontWeight: FontWeight.bold, )),


                       //Description , Price
                        subtitle: 
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartItem.description),
                            SizedBox(height: 8),
                            Text(" E£${cartItem.price}" , 
                            style: TextStyle( color: Color.fromARGB(255, 27, 12, 94),fontWeight: FontWeight.bold, )),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                SizedBox(width: 20),
                                Center(
                                   child:ElevatedButton(
                                onPressed: () {
                                 context.read<ShoppingCubit>().addToCart(userId, products[index].id!, 1);
                                },
                                child:Text('Add To Cart'),
                              ),
                                )
                              ],
                            )
                            
                          ]

                        ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsPage(product: cartItem),
                              ),
                            );
                          },
                        ),
  
                      ),

                      
                   //favorite
                    Positioned(
                      top: 5,
                      right: 10,
                      child: IconButton(
                        icon: Icon(Icons.favorite, color: Color.fromARGB(255, 229, 76, 76)),
                        onPressed: () {
                          context.read<FavoritesCubit>().userRemoveFromFavorites(userId, products[index].id!);
                        },
                      ),
                    ),
  
                  ],
                );
                

              },
             );

          } else {
            return Center(child: Text('Failed to load favorites'));
          }
        },
      ),
    );
  }
}
