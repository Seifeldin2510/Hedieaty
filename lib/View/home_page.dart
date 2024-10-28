import 'package:flutter/material.dart';
import 'package:hedieaty/View/friends_list_page.dart';

import 'event_list_page.dart';
import 'gift_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  changePage(int index){
    selectedIndex=index;
    setState(() {

    });
  }

  int selectedIndex = 0;
  List<Widget> pages = [
    const FriendsListPage(),
    const EventListPage(),
    const GiftListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
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
        ],
      ),
    );
  }
}
