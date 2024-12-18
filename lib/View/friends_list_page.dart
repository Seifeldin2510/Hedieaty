import 'package:flutter/material.dart';
import 'package:hedieaty/Services/friend_service.dart';
import 'package:hedieaty/View/add_friend.dart';
import 'package:hedieaty/View/profile_page.dart';

import '../Model/user_model.dart';
import '../Services/user_service.dart';
import 'event_list_page.dart';
import 'gift_list_page.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key});

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {

  TextEditingController searchController = TextEditingController();
  String searchValue = "";
  int index = 0;
  List<userModel> users = [];
  List<userModel> selectedUsers = [];
  bool loaded = false;

  getFriends()async{
    users = await FriendService().getAllFriendSQL();
    selectedUsers = users;
    loaded = true;
    setState(() {

    });
  }

  @override
  void initState() {
    getFriends();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff617ddf),
        title: const Text("hedieaty"),
        leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (contex)=>AddFriend()));
          },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                SizedBox(
                  width: 275,
                  child:
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.search),
                      hintText: "Search",
                    ),
                    onChanged: (var x)
                    {
                      setState(() {
                        searchValue = x;
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0) ,
                  child: ElevatedButton(
                    onPressed: () {
                      users = selectedUsers.where((user) => user.firstName.toLowerCase() == searchValue.toLowerCase()).toList();
                      setState(() {

                      });
                    }
                    , child: const Text("Search"),
                  ),
                ),
              ],
            ),
          ),
          loaded? Expanded(
            child: ListView.separated(
              itemCount: users.length ,
              itemBuilder:(context,index){
                return ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    child: Image.network(users[index].image) ,
                  ),
                  title: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> EventListPage(current: false,userId: users[index].id,)));
                    },
                    child:Text("${users[index].firstName} ${users[index].lastName}"),
                  ),
                  subtitle: Text("Event ${users[index].eventNumber}"),
                );
              },
              separatorBuilder: (context,index){
                return Divider();
              },
            ),
          )
              :Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
        },
        child: Icon(Icons.person),
      ),
    );
  }
}
