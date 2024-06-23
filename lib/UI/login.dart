import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frist_pages/UI/home_page.dart';
import 'package:frist_pages/UI/signUp.dart';
import 'package:frist_pages/cubits/cubit/user_cubit.dart';


int theUserId = -1;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Login' , style: TextStyle( fontWeight:FontWeight.bold , fontSize: 25)), leading: const Icon(Icons.login_outlined)
          ),
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          } else if (state is UserLoginDoneState) {
            theUserId = state.userId!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Successful Login')),
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }else if (state is UserLoginFailedState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('User Doesn\'t Exist')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onSaved: (value) => email = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (value) => password = value!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      context.read<UserCubit>().login(email, password);
                    }
                  },
                  style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 232, 208, 208)),
                              side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(color: Color.fromARGB(244, 243, 243, 243), width: 2), ) ),
                  child: Text('Login'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account?" , style: TextStyle( fontWeight:FontWeight.bold )),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Signup()),
                        );
                      },
                      style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 255, 255, 255)),
                              side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(color: Color.fromARGB(244, 163, 178, 239), width: 2), ) ),
                      child: Text('Sign up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
