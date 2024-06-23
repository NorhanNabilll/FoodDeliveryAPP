import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frist_pages/UI/home_page.dart';


class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text( 'Contact Us' , style: TextStyle(color:Color.fromARGB(165, 47, 11, 11), 
                    fontWeight:FontWeight.bold ),),centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 232, 208,208),
        elevation: 10, 
        toolbarHeight: 70, 
      ),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Column(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                            "assets/images/photo_2024-05-15_18-00-24.jpg")),
                    const Text(
                      'Contact Information:\nEmail: contact@ratatouille.com\nPhone: +20 1147333742',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
          ],
        ),
      )),
    );
  }
}
