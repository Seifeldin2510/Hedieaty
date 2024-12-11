import 'package:flutter/material.dart';
import 'package:hedieaty/Services/friend_service.dart';
import 'package:hedieaty/View/friends_list_page.dart';
import 'package:hedieaty/View/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/user_service.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({super.key});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  final _formKey=GlobalKey<FormState>();
  TextEditingController friendEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ADD friend'),
      ),
      body: Center(
              child: Column(
                children: [
                 Expanded(
                    child:Center(
                      child:
                        Form(
                        key : _formKey,
                          child:ListView(
                              children: [
                                Padding(padding: const EdgeInsets.all(4.0),
                                  child:
                                    TextFormField(
                                    controller: friendEmailController,
                                    validator: (value){
                                      if(value!.isEmpty)
                                      {
                                      return "Email must not be empty";
                                      }
                                      },
                                      decoration: const InputDecoration(label: Text("Enter Friend Email",)),
                                  ),
                                ),
                            ],
                          ),
                          ),
                        ),
                      ),
                FloatingActionButton(onPressed: () async{
                  SharedPreferences pref = await SharedPreferences.getInstance();
                  int myId = pref.getInt("currentUser")!;
                  int id = await UserService().getUserByemail(friendEmailController.text);
                  FriendService().addFriend(myId,id);
                  FriendService().addFriendsFireBase(id);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                },
                  child: Text('ADD'),

                ),
                ],
                  ),
                ),
              );
  }
}
