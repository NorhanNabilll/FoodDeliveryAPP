import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_pages/UI/aboutus.dart';
import 'package:frist_pages/UI/cart_page.dart';
import 'package:frist_pages/UI/contactus.dart';
import 'package:frist_pages/UI/favoritesPage.dart';
import 'package:frist_pages/UI/login.dart';
import 'package:frist_pages/UI/menuPage.dart';
import 'package:frist_pages/cubits/cubit/favorites_cubit.dart';
import 'package:frist_pages/cubits/cubit/product_cubit.dart';
import 'package:frist_pages/cubits/cubit/shopping_cubit.dart';
import 'package:frist_pages/cubits/cubit/user_cubit.dart';
import 'package:frist_pages/main.dart';
import 'package:frist_pages/UI/ProductDetailsPage.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromARGB(255, 237, 237, 237);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text(
          "Ratatouille",
          style: TextStyle(color:  Color.fromARGB(255, 139, 95, 95) , fontWeight: FontWeight.w500),
        ),
        backgroundColor: backgroundColor,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.home,
              text: 'Home',
              onTap: () => Navigator.pop(context),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.restaurant_menu,
              text: 'Food Menu',
               onTap: () async {
                ProductCubit pc=BlocProvider.of<ProductCubit>(context);
                await pc.AllProducts();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MenuPage()));
              },

            ),
             ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: ()  {
                FavoritesCubit pc=BlocProvider.of<FavoritesCubit>(context);
                 pc.loadUserFavoriteProducts(BlocProvider.of<UserCubit>(context).userId!);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => FavoritePage()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () {
                ShoppingCubit shc=BlocProvider.of<ShoppingCubit>(context);
                 shc.loadCart(BlocProvider.of<UserCubit>(context).userId!);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartPage()));
              },
            ),
            _buildDrawerItem(
              context,
              icon: Icons.info,
              text: 'About Us',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutPage()),
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.contact_phone,
              text: 'Contact Us',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactPage()),
              ),
            ),
            _buildDrawerItem(
              context,
              icon: Icons.logout_rounded,
              text: 'Log out',
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider(
        create: (context) => ProductCubit()..FeaturedProducts(),
        child: Column(
          children: [
            _buildHeaderCard(),
            const SizedBox(height: 20),
            _buildSectionTitle(context, 'Food Menu', MenuPage()),
            const SizedBox(height: 20),
            _buildFoodMenu(context),
            const SizedBox(height: 20),
            _buildSectionTitle(context, 'Featured', MenuPage()),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is featuredProductState) {
                    return ListView.builder(
                      itemCount: state.featuredProducts.length,
                      itemBuilder: (context, index) {
                        final product = state.featuredProducts[index];
                        return ListTile(
                          title: Text(product.name),
                          subtitle: const Text(""),
                          leading: Image.asset(
                            product.image,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsPage(product: product),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } /*else if (state is ProductError) {
                    return const Center(
                        child: Text("Failed to fetch products"));
                  }*/
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required IconData icon,
      required String text,
      required Function() onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }

  Widget _buildHeaderCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 232, 208, 208),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child:
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ratatouille",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Text(
                "We are special in almost everything",
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              "assets/images/photo_2024-05-15_18-00-24.jpg",
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, Widget page) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25, left: 25),
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Color.fromARGB(255, 139, 95, 95)),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (v) {
                return page;
              }));
            },
            child: const Text(
              "See all",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }




  Widget _buildFoodMenu(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildFoodMenuItem(
            context, 'Chicken Alfredo', 'assets/images/ChickenAlfredo.jpg'),
        _buildFoodMenuItem(
            context, 'Bruschetta', 'assets/images/Bruschetta.jpg'),
            
        _buildFoodMenuItem(context, 'Calamari', 'assets/images/calamari.jpg'),
      ],
    );
  }




  Widget _buildFoodMenuItem(
      BuildContext context, String name, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return MenuPage();
              }));
            },
            child: Image.asset(
              imagePath,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
