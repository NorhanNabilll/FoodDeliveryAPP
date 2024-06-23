import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:frist_pages/cubits/cubit/product_cubit.dart';
import 'package:frist_pages/dataLayer/dataBase.dart';
import 'package:frist_pages/dataLayer/model/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


Product p2 = Product(1, 'calamari', '6 Peices fried calamri', 'Appetizers',
    69.99, 1, 'assets/images/calamari.jpg');

Product p1 = Product( 2, 'Steak Florentine',' an Italian steak dish made of young steer or heifer that is one of the most famous dishes in Tuscan cuisine. It is loin steak on the bone cooked on a grill until rare',
    'Main Courses',359.99,1,'assets/images/SteakFlorentine.jpg');

Product p3 = Product(3, 'Tiramisu', 'An Italian dessert made of ladyfinger pastries dipped in coffee, layered with a whipped mixture of eggs, sugar and mascarpone and flavoured with cocoa',
    'desserts', 99.99, 1, 'assets/images/Tiramisu.jpg');

Product p4 = Product(4, 'Ratatouille', 'food made by rat', 'desserts', 99.99, 1,
    'assets/images/p1.jpg');

Product p5 = Product(5, 'V7', 'sparkling drink rich in sugar and vitamens',
    'Drinks', 19.99, 1, 'assets/images/V7.jpg');

Product p6 = Product(6, 'Caprese Salad', 'Nectarines add a fruity twist to the classic combo of tomato, mozzarella and basil',
'Salads', 19.99, 0, 'assets/images/CapreseSalad.jpg');

Product p7 = Product( 7, 'New York Cheesecake','soft fresh cheese, eggs, and sugar. It may have a crust or base made from crushed cookies, graham crackers, pastry, or sometimes sponge cake',
'desserts',89.99,0,'assets/images/NewYorkCheesecake.jpg');

Product p8 = Product(8,'Chicken Alfredo','pasta dish made with fettuccine, butter, and Parmesan cheese. As the cheese is mixed with freshly cooked, warm fettuccine and ample butter',
'Main Courses',239.99,1,'assets/images/ChickenAlfredo.jpg');
    
Product p9 = Product(9,'grilled Salmon','The simple marinade of honey and soy sauce adds the right amount of flavor without overpowering the delicate taste of the grilled salmon',
'Main Courses',279.99,1, 'assets/images/grilledSalmon.jpg');
    
Product p10 = Product(10, 'cesar salad', ' green salad of romaine lettuce and croutons dressed with lemon juice, olive oil, eggs or egg yolks, Worcestershire sauce, anchovies, garlic, Dijon mustard, Parmesan cheese, and black pepper',
'Salads', 59.99, 0, 'assets/images/cesarsalad.jpg');

Product p11 = Product(11, 'Quinoa Salad', '. Quinoa, cucumbers, bell pepper, olives, lots of parsley and an assertive lemon-garlic dressing make it a filling and protein-rich vegan lunch',
'Salads', 79.99, 1, 'assets/images/QuinoaSalad.jpg');

Product p12 = Product(12, 'Fruit Charcuterie Board', 'Move over cheese and sausage a fruit charcuterie board with seasonal fruits for a fresh and colorful appetizer', 
'Appetizers',99.99, 0, 'assets/images/FruitCharcuterieBoard.jpg');

Product p13 = Product(13, 'sambosa', '3 pcs chesse sambosa and 3 pcs meat', 
'Appetizers',49.99, 0, 'assets/images/sambosa.jpg');

Product p14 = Product(14, 'Spiro Spathis', 'classic soda drink with lemon flavor',
'Drinks', 16.99, 1, 'assets/images/SpiroSpathis.jpg');

Product p15 = Product(15, 'big cola', 'soft drink with cola flavor',
'Drinks', 13.99, 0, 'assets/images/bigcola.jpg');

DataBaseHandler sqldb = DataBaseHandler();


class addpro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit()),
      ],
      child: MaterialApp(
        title: 'One Button',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TwoButtonsScreen(),
      ),
    );
  }
}

class TwoButtonsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('One Button'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () {   
             sqldb.deleteProductByName("norhan");
             sqldb.deleteProductByName("featured");

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Product added successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              log('Button pressed');
            },
            child: Text('Button 1'),
          ),
          SizedBox(height: 20), // Adding space between buttons
        ]),
      ),
    );
  }
}
