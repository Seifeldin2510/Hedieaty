import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty/Model/user_model.dart';
import 'package:hedieaty/Services/user_service.dart';
import 'package:hedieaty/View/friends_list_page.dart';
import 'package:hedieaty/View/notification_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'event_list_page.dart';
import 'gift_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late userModel  currentUser;

  Future<void>getUserdata () async{
    DocumentSnapshot x = await UserService().getUserData();
    Map y = x.data() as Map;
    currentUser = userModel(id: y['id'], firstName: y['Firstname'], lastName: y['Lastname'], age: y['age'], email: y['email'], username: y['username'], password: y['password'], image: y['image']);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("currentUser", currentUser.id);
    pages.add(EventListPage(current: true,userId:currentUser.id));
    pages.add(GiftListPage(current: true,eventId: 0,));
    pages.add(notificationPage());
    }
  List<Widget> pages = [const FriendsListPage(),];
  @override
  void initState() {
    getUserdata();
    super.initState();
  }

  changePage(int index){
    selectedIndex=index;
    setState(() {

    });
  }

  int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar:
      BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: changePage,
        items:const  [
           BottomNavigationBarItem(
              label: "Friends",
              icon: Icon(Icons.groups)
           ),
          BottomNavigationBarItem(
              label: "Event",
              icon: Icon(Icons.event_note)
          ),
           BottomNavigationBarItem(
            label: "Gifts",
              icon: Icon(Icons.card_giftcard),
          ),
          BottomNavigationBarItem(
            label: "notifications",
            icon: Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }
}
