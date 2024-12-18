import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty/Services/user_service.dart';
import 'package:hedieaty/View/home_page.dart';
import 'package:hedieaty/View/signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import '../Model/notifications_model.dart';
import '../Services/notification_service.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  getNotification()async{
    notificationsModel notification = await notificationService().getLastNotificationsSQL();
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.minimal,
      title: Text(notification.message),
      autoCloseDuration: const Duration(seconds: 5),
      alignment: Alignment.topCenter,
      primaryColor: Colors.white,
      backgroundColor: Color(0xff617ddf),
      foregroundColor: Colors.white,
    );
  }

  Future<void> authUser () async{
    User? x = await UserService().signIn(emailController.text, passwordController.text);
    if(x!=null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      int id = await UserService().getUserByemail(emailController.text);
      pref.setInt("currentUser", id );
      Navigator.of(context).pop();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage()));
    }
    else
    {
      SnackBar snackBar = SnackBar(
        content:
        const Text("Something is Wrong"),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: "Ok",
          onPressed: (){},
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }


  void hiddenPassword() {
    hidePassword = !hidePassword;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 30),
        backgroundColor: const Color(0xff617ddf),
        title: const Text("hedieaty"),
        leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),

      ),
      body:
      Stack(
        children: [
          Image.asset("assets/stack-gift-boxes-icon-isolated.jpg",
            height: MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width ,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
          child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0),
                ),
              ),
          ),
          Expanded(
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Text("Login", style: TextStyle(
                        fontSize: 50, fontWeight: FontWeight.bold,),),
                      Padding(padding: const EdgeInsets.all(15),
                        child:
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email must not be empty";
                            }
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.black,width: 5)
                            ),
                            label: Text("Enter email"),),
                        ),
                      ),
                      Padding(padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          obscureText: hidePassword,
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.length < 8) {
                              return "Password must be more than 8 characters";
                            }

                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color:Colors.black,width: 5)
                            ),
                            label: const Text("Enter password"),
                            suffixIcon: IconButton(onPressed: () {
                              hiddenPassword();
                            },
                              icon: Icon(
                                hidePassword ? Icons.visibility : Icons
                                    .visibility_off,
                              ),
                            ),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authUser();
                            getNotification();
                          }
                        },
                        child: const Text("Login"),
                      ),
                      TextButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => const SignupPage()));
                      },
                        child: const Text("Click Here to signup",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
