import 'package:flutter/material.dart';

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
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool hidePassword = true;
  void hiddenPassword()
  {
    hidePassword=!hidePassword;
    setState(() {

    });
  }
  void addUser()
  {
    //UserService().addUsers(User(name: nameController.text, email: emailController.text, password: passwordController.text));
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
                      decoration: const InputDecoration(label: Text("Enter First Name",)),
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
                      decoration: const InputDecoration(label: Text("Enter Last Name",)),
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
                      decoration: const InputDecoration(label: Text("Enter User Name",)),
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
                      decoration: const InputDecoration(label: Text("Enter Age",)),
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
                      decoration: const InputDecoration(label: Text("Enter email",),),
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
                      decoration: InputDecoration(label: const Text("Enter password",),
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
                      decoration: InputDecoration(label:const  Text("Confirm password",),
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
                        addUser();
                        SnackBar snackBar = SnackBar(
                          content:
                          const Text("You are signed up"),
                          duration: const Duration(seconds: 5),
                          action: SnackBarAction(
                            label: "Go to login",
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                ],),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Back")),
          )
  ],
      ),
    );
  }
}
