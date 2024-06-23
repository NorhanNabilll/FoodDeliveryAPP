

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_pages/cubits/cubit/product_cubit.dart';
import 'package:frist_pages/dataLayer/dataBase.dart';
import 'package:frist_pages/dataLayer/model/product.dart';

class addp extends StatelessWidget {
   addp({super.key});
   DataBaseHandler db=DataBaseHandler();
//Product p=Product(null, "featured", "teest", "desserts" , 17.5, 1, "assets/images/burger.png");

  @override
  Widget build(BuildContext context) {
    ProductCubit shc=BlocProvider.of<ProductCubit>(context);
    shc.FeaturedProducts();
    return Scaffold(
      appBar: AppBar(title: Text("aapp"),),
      
      body:BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if(state is featuredProductState){
            List<Product> ps=state.featuredProducts;
            String ss;
            for (var i = 0; i < ps.length; i++) {
              Product p=ps[i];
              String s=p.name;
              print(s);
            }
            
            return Text("oo");
          }
          else{
            return Text("nn");
          }
        },
      ),
      );
  }
}