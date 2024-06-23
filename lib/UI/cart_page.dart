import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_pages/UI/ProductDetailsPage.dart';
import 'package:frist_pages/UI/confirm.dart';
import 'package:frist_pages/cubits/cubit/shopping_cubit.dart';
import 'package:frist_pages/cubits/cubit/user_cubit.dart';



class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 241, 241, 0.875),
      appBar: AppBar(
        title: const Text( 'Cart' , style: TextStyle(color:Color.fromARGB(165, 47, 11, 11), 
                    fontWeight:FontWeight.bold ),),centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 232, 208,208),
        elevation: 10, 
        toolbarHeight: 70, 
      ),
      body: BlocBuilder<ShoppingCubit, ShoppingState>(
        builder: (context, state) {
          if (state is ShoppingInitial) {
            return const Center(child: Text('Your cart is empty.'));
          } else if (state is CartLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartEmptyState) {
            return Center(child: Text('Cart is empty'));
          } else if (state is CartLoadedState) {
            final cartItems = state.products;
            final userId = BlocProvider.of<UserCubit>(context).userId!;

            if (cartItems.isEmpty) {
              return Center(child: Text('Your cart is empty.'));
            }

             double totalPrice = cartItems.fold(
                0, (sum, item) => sum + item.price * item.quantity);

            return Column(
              children: [
              Expanded(
              child:ListView.builder
             (
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return Stack(
                  children: [
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Color.fromARGB(255, 255, 255, 255),
                      
                      child: ListTile(

                       //image
                        leading:
                        Container(
                              width: 70,
                              height: 90,
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
                         Text(cartItem.name),


                       //Description , Price
                        subtitle: 
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cartItem.description),
                            SizedBox(height: 8),
                            


                          //Price , Quantity
                          Row(
                          mainAxisSize: MainAxisSize.min,
                          children:
                           [

                            //Price
                            Text(' E£${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}',
                                   style: TextStyle( color: Colors.grey[700],fontWeight: FontWeight.bold, ),),

                            //Quantity
                            Spacer(),
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Color.fromARGB(255, 237, 238, 241),
                              child: IconButton(
                                icon: Icon(Icons.remove , size: 15,),
                                onPressed: () {
                                  if(cartItem.quantity == 1){
                                    context.read<ShoppingCubit>().removeFromCart(userId, cartItem.id!);
                                }else{
                                  context.read<ShoppingCubit>().updateCartItemQuantity(userId, cartItem.id!, -1);}
                                },
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('${cartItem.quantity}'),
                              
                            ),
                            
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Color.fromARGB(255, 237, 238, 241),
                              child: IconButton(
                                icon: Icon(Icons.add , size: 15,),
                                onPressed: () {
                                  context.read<ShoppingCubit>().updateCartItemQuantity(userId, cartItem.id!, 1);
                                },
                              ),
                            ),
                          ],
                        ),
                        ],
                        ),
                         
                      ),
                    ),


                   //Delete
                    Positioned(
                      top: 1,
                      right: 1,
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Color.fromARGB(255, 172, 56, 56)),
                        onPressed: () {
                          context.read<ShoppingCubit>().removeFromCart(userId, cartItem.id!);
                        },
                      ),
                    ),
                  ],
                );
              },
            )),


              //total price
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Total Price: E£${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),


                //order
                ElevatedButton(
                  onPressed: () {
                     Navigator.push(context,
                              MaterialPageRoute(builder: (context) => confirmCheckout(totalPrice)));
                  },style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 128, 63, 63)),
                                ),
                  child: Text('Confirm Checkout' , style: TextStyle(color:Color.fromARGB(164, 255, 255, 255), 
                    fontWeight:FontWeight.bold ),),
                ),
              SizedBox(height: 25,)
              ]
            );
            
          } else {
            return Center(child: Text('Unknown state' ));
          }
        },
      ),
    );
  }
}
