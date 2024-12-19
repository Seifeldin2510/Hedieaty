import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty/Model/database_class.dart';
import 'package:hedieaty/Model/user_model.dart';
import 'package:hedieaty/Services/user_service.dart';
import 'package:hedieaty/View/login_page.dart';
import 'package:hedieaty/View/pledged_gift_list.dart';

import 'event_list_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey=GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  userModel?  currentUser;

  Future<void>getUserdata () async{
    DocumentSnapshot x = await UserService().getUserData();
    Map y = x.data() as Map;
    currentUser = userModel(id: y['id'], firstName: y['Firstname'], lastName: y['Lastname'], age: y['age'], email: y['email'], username: y['username'], password: y['password'], image: y['image']);
    nameController.text=currentUser!.username;
    ageController.text=currentUser!.age.toString();
    setState(() {

    });
  }

  Future<void> updateUser()async{
    await UserService().updateUser(int.parse(ageController.text), nameController.text);
    await UserService().updateUserSQL(int.parse(ageController.text), nameController.text);
    currentUser!.firstName = nameController.text;
    currentUser!.age= int.parse(ageController.text);
    setState(() {

    });
    SnackBar snackBar = SnackBar(
      content:
      const Text("User updated successfully"),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: "Ok",
        onPressed: (){},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

@override
  void initState() {
    getUserdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff617ddf),
        title: const Text("hedieaty"),
        leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),
      ),
      body:ListView(
        children: [
          Form(
              key : _formKey,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
                      child: Center(
                        child: CircleAvatar(
                          radius: 50,
                          child: Image.network(currentUser!.image) ,
                        ),
                      ),
                    ),
                    Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: Text("Change Personal information",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text("Name : "),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            width: 200,
                            child: TextFormField(
                              controller: nameController,
                              validator: (value){
                                if(value == null || value.isEmpty)
                                {
                                  return "name must not be empty";
                                }
                              },
                              decoration: InputDecoration(label: Text("Enter Name"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text("age : "),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            width: 200,
                            child: TextFormField(
                              controller: ageController,
                              validator: (value){
                                if(value == null || value.isEmpty)
                                  {
                                    return "age must not be empty";
                                  }
                              },
                              decoration: InputDecoration(label: Text("Enter age"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(backgroundColor: Color(0xff617ddf)),
                      onPressed: (){
                      if(_formKey.currentState!.validate())
                        {
                          updateUser();
                        }
                    }, child: Text("Submit"),),
                    Divider(
                      color: Colors.black,
                      thickness: 5,
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(backgroundColor: Color(0xff617ddf)),
                      onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PledgedGiftListPage()));
                    },
                      child: Text("Go to pledged gifts list"),
                    ),
                    ElevatedButton(
                      style: TextButton.styleFrom(backgroundColor: Color(0xff617ddf)),
                      onPressed: (){
                      UserService().signOut();
                     // DatabaseClass().deleteDataBaseToSync();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route) => false);
                    },
                      child: Text("SignOut"),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff617ddf),
        onPressed: ()
        {
          Navigator.pop(context);
        },
        child: Icon(Icons.keyboard_backspace_outlined),
      ),
    );
  }
}
