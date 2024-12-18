import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty/Services/user_service.dart';
import 'package:hedieaty/View/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey=GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool hidePassword = true;
  void hiddenPassword()
  {
    hidePassword=!hidePassword;
    setState(() {

    });
  }

  Future<void> authUser () async{
    User? x = await UserService().signUp(emailController.text, passwordController.text);
    if(x!=null) {
      await UserService().addUserSQL(firstNameController.text, lastNameController.text,int.parse(ageController.text),emailController.text,userNameController.text,passwordController.text,imageController.text);
      int id = await UserService().getUserByemail(emailController.text);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setInt("currentUser", id );
      await UserService().saveUserData(id,firstNameController.text, lastNameController.text,int.parse(ageController.text),emailController.text,userNameController.text,passwordController.text,imageController.text);
      Navigator.of(context).pop();
      Navigator.pop(context);
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
          Center(
            child:
            Form(
              key : _formKey,
              child:ListView(
                children: [
                  const Icon(Icons.person , size: 90,),
                  Padding(padding: const EdgeInsets.all(4.0),
                    child:
                    TextFormField(
                      controller: firstNameController,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Name must not be empty";
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.black,width: 5)
                          ),
                          label: Text("Enter First Name",)),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(4.0),
                    child:
                    TextFormField(
                      controller: lastNameController,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Name must not be empty";
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.black,width: 5)
                          ),
                          label: Text("Enter Last Name",)),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(4.0),
                    child:
                    TextFormField(
                      controller: userNameController,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Name must not be empty";
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.black,width: 5)
                          ),
                          label: Text("Enter User Name",)),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(4.0),
                    child:
                    TextFormField(
                      controller: ageController,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Age must not be empty";
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.black,width: 5)
                          ),
                          label: Text("Enter Age",)),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(4.0),
                    child:
                    TextFormField(
                      controller: emailController,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Email must not be empty";
                        }
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.black,width: 5)
                        ),
                        label: Text("Enter email",),),
                    ),
                  ),

                  Padding(padding: const EdgeInsets.all(4.0),
                    child:
                    TextFormField(
                      controller: imageController,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "image link must not be empty";
                        }
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color:Colors.black,width: 5)
                          ),
                          label: Text("Enter Image link",)),
                    ),
                  ),



                  Padding(padding: const EdgeInsets.all(4.0),
                    child:TextFormField(
                      obscureText:hidePassword ,
                      controller: passwordController,
                      validator:(value){
                        if(value != null && value.length < 8 )
                        {
                          return "Password must be more than 8 characters";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.black,width: 5)
                        ),
                        label: const Text("Enter password",),
                        suffixIcon: IconButton(onPressed: (){
                          hiddenPassword();
                        },
                          icon: Icon(
                            hidePassword?Icons.visibility:Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(padding: const EdgeInsets.all(4.0),
                    child:TextFormField(
                      obscureText:hidePassword ,
                      controller: confirmPasswordController,
                      validator:(value){
                        if(value != null && value != passwordController.text )
                        {
                          return "Password must be same as above";
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color:Colors.black,width: 5)
                        ),
                        label:const  Text("Confirm password",),
                        suffixIcon: IconButton(onPressed: (){
                          hiddenPassword();
                        },
                          icon: Icon(
                              hidePassword?Icons.visibility:Icons.visibility_off,
                          ),
                        ),
                      ),
                    ),
                  ),

                  FloatingActionButton(
                    onPressed: ()
                    {
                      if(_formKey.currentState!.validate()){
                        authUser();
                      }
                      else{
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
                    },
                    child: const Text("Signup"),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Back")),
                  )
                ],
              ),
            ),
          ),
  ],
      ),
    );
  }
}
