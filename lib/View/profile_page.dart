import 'package:flutter/material.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();

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
                    Center(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: Text("Change Personal information"),
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
                              decoration: InputDecoration(label: Text("Enter age"),
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
                          Text("Email : "),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            width: 200,
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(label: Text("Enter Email"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ElevatedButton(onPressed: (){}, child: Text("Submit"),),
                    Divider(
                      color: Colors.black,
                      thickness: 5,
                    ),
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EventListPage()));
                    },
                        child: Text("Go to event list"),
                    ),
                    ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PledgedGiftListPage()));
                    },
                      child: Text("Go to pledged gifts list"),
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          Navigator.pop(context);
        },
        child: Icon(Icons.keyboard_backspace_outlined),
      ),
    );
  }
}
