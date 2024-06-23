import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_pages/UI/cart_page.dart';
import 'package:frist_pages/UI/confirm.dart';
import 'package:frist_pages/UI/favoritesPage.dart';
import 'package:frist_pages/UI/home_page.dart';
import 'package:frist_pages/UI/login.dart';
import 'package:frist_pages/UI/menuPage.dart';
import 'package:frist_pages/UI/signUp.dart';
import 'package:frist_pages/UI/welcomePage.dart';
import 'package:frist_pages/addingProducts.dart';
import 'package:frist_pages/addproduct.dart';
import 'package:frist_pages/cubits/cubit/favorites_cubit.dart';
import 'package:frist_pages/cubits/cubit/product_cubit.dart';
import 'package:frist_pages/cubits/cubit/shopping_cubit.dart';
import 'package:frist_pages/cubits/cubit/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() async {

  runApp(MyApp());


}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(create: (context) => ShoppingCubit()),
        BlocProvider(create: (context) => FavoritesCubit()),
        BlocProvider(create: (context) => UserCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "welcome":(context)=>welcomPage(),
          "singUp":(context)=>Signup(),
          "login":(context) => LoginPage(),
          "cart":(context) => CartPage(),
          "favorite":(context) => FavoritePage(),
          "menue":(context) => MenuPage(),
          "home":(context) => HomePage(),
          "addProduct":(context) => addpro(),
        },
        initialRoute: "welcome",
      ),
    );
  }
}