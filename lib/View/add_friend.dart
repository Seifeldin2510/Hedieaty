import 'package:flutter/material.dart';
import 'package:hedieaty/Model/user_model.dart';
import 'package:hedieaty/Services/friend_service.dart';
import 'package:hedieaty/Services/notification_service.dart';
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
        backgroundColor: const Color(0xff617ddf),
        title: const Text("Add Friend"),
        leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),
      ),
      body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 Expanded(
                    child:Center(
                      child:
                        Form(
                        key : _formKey,
                          child:Padding(padding: const EdgeInsets.all(4.0),
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
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: FloatingActionButton(
                    backgroundColor: Color(0xff617ddf),
                    onPressed: () async{
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    int myId = pref.getInt("currentUser")!;
                    int? id = await UserService().getUserDataByEmail(friendEmailController.text);
                    if(id==null)
                      {
                        SnackBar snackBar = SnackBar(
                          content:
                          const Text("This email is not correct"),
                          duration: const Duration(seconds: 5),
                          action: SnackBarAction(
                            label: "Ok",
                            onPressed: (){},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    else {
                    FriendService().addFriend(myId, id);
                    FriendService().addFriendsFireBase(id);
                    userModel user = await UserService().getUsers(myId);
                    String message = "User ${user.username} add you to his friends List";
                    await notificationService().addNotificationSQL(message, user.email, id);
                    int notificationId = await notificationService().getNewNotificationsAddSQL(message, user.email, id);
                    await notificationService().addNotificationToFireBase(notificationId, message, user.email, id);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  }
              },
                    child: Text('ADD'),

                  ),
                ),
                ],
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Color(0xff617ddf),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("back"),
      ),
              );
  }
}
