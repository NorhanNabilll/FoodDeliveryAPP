import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_pages/cubits/cubit/user_cubit.dart';
import 'package:frist_pages/dataLayer/model/user.dart';
import 'login.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SignupPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  String phone = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up' , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 27),),
      ),
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          } else if (state is UserSingUpState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Signed up Successfully')),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: const Color.fromARGB(255, 232, 208, 208),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(
                                  color: Colors.black, // Set the label text color to black
                                  
                                ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 255, 255, 255), // Set the input box color here
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)), // Change the border radius here
                                    borderSide: BorderSide.none,
                                  ),
                      ),
                      onSaved: (value) => name = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),


                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                                  color: Colors.black, 
                                 
                                ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 255, 255, 255), 
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)), 
                                    borderSide: BorderSide.none,
                                  ),
                      ),
                      onSaved: (value) => email = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),


                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                                  color: Colors.black, 
                                 
                                ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 255, 255, 255), 
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)), 
                                    borderSide: BorderSide.none,
                                  ),
                      ),
                      obscureText: true,
                      onSaved: (value) => password = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } 
                        if (value.length <= 8) {
                              return 'Password must be more than 8 characters long';
                            }
                        if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                              return 'Password must contain at least one special character';
                            }
                        return null;
                      },
                    ),
                    
                    SizedBox(height: 10),


                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        labelStyle: TextStyle(
                                  color: Colors.black, // Set the label text color to black
                                  // Make the label text bold
                                ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 255, 255, 255), // Set the input box color here
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)), // Change the border radius here
                                    borderSide: BorderSide.none,
                                  ),
                      ),
                      onSaved: (value) => phone = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }if (!RegExp(r'^(010|011|012)\d{8}$').hasMatch(value)) {
                              return 'Enter valid phone number';
                            }
                        return null;
                      },
                    ),


                    SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(
                                  color: Colors.black, // Set the label text color to black
                                   // Make the label text bold
                                ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 255, 255, 255), // Set the input box color here
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20.0)), // Change the border radius here
                                    borderSide: BorderSide.none,
                                  ),
                      ),
                      onSaved: (value) => address = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          User user = User(null, name, password, email, phone, address);
                          context.read<UserCubit>().signUp(user);
                        }
                      },
                      style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
                       side: MaterialStateProperty.all<BorderSide>(
                             BorderSide(color: Color.fromARGB(244, 143, 179, 245), width: 2), ) ),
                      child: Text('Sign Up'),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                            
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 244, 245, 248)),
                              side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(color: Color.fromARGB(244, 143, 179, 245), width: 2), ) ),
                          child: Text('Log in'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
