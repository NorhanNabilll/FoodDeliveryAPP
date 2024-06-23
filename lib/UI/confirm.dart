import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_pages/UI/cart_page.dart';
import 'package:frist_pages/UI/home_page.dart';
import 'package:frist_pages/cubits/cubit/shopping_cubit.dart';
import 'package:frist_pages/cubits/cubit/user_cubit.dart';
import 'package:frist_pages/dataLayer/dataBase.dart';
import 'package:frist_pages/dataLayer/model/user.dart';

class confirmCheckout extends StatelessWidget {
  String name = '';
  String location = '';
  String phoneNumber = '';

  DataBaseHandler d = DataBaseHandler();
  double totalPrice;
  
  confirmCheckout(this.totalPrice, {super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShoppingCubit, ShoppingState>(
      listener: (context, state) {
        if (state is OrderSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Your order confirmed successfully'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        } else if (state is OrderFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to confirm the order'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Checkout' , style: TextStyle(color:Color.fromARGB(189, 47, 11, 11), fontWeight:FontWeight.bold )),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 430, 
                    child: Card(
                      color: Color.fromARGB(255, 232, 208, 208), 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid name';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  name = value!;
                                },
                                decoration: const InputDecoration(
                                  labelText: "Name",
                                  labelStyle: TextStyle(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.bold, 
                                ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 244, 246, 247), 
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)), 
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid phone number';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  phoneNumber = value!;
                                },
                                decoration: const InputDecoration(
                                  labelText: "Phone Number",
                                  labelStyle: TextStyle(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.bold, 
                                ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 236, 237, 238), 
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)), 
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a valid location';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  location = value!;
                                },
                                decoration: const InputDecoration(
                                  labelText: "Shipping Address",
                                  labelStyle: TextStyle(
                                  color: Colors.black, 
                                  fontWeight: FontWeight.bold, 
                                ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 234, 236, 237), 
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)), 
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              Center(
                                
                                child: Text(
                                  "Shipping Cost: E£50 \n Total Price: E£${(totalPrice+50).toStringAsFixed(2) }",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 47, 7, 7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final orderCubit = context.read<ShoppingCubit>();
                            final userId = context.read<UserCubit>().userId!;
                            orderCubit.placeOrder(userId, location, totalPrice);
                          }
                        },style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 145, 83, 83)),
                                ),
                        child: Text('Confirm' , style: TextStyle(color:Color.fromARGB(164, 255, 255, 255), 
                    fontWeight:FontWeight.bold ),),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.reset();
                        },style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 145, 83, 83)),
                                ),
                        child: Text('Reset' , style: TextStyle(color:Color.fromARGB(164, 255, 255, 255), 
                    fontWeight:FontWeight.bold ),),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}