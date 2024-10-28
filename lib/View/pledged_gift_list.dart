import 'package:flutter/material.dart';

class PledgedGiftListPage extends StatefulWidget {
  const PledgedGiftListPage({super.key});

  @override
  State<PledgedGiftListPage> createState() => _PledgedGiftListPageState();
}

class _PledgedGiftListPageState extends State<PledgedGiftListPage> {
  List<String> gifts = ["assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg"];
  List<String> friends = ["Seif","Laurent","Tracy","Claire","Joe","Mark","Williams","seif eldin"];
  List<String> time =["25/10","10/10","1/1","9/5","9/5","7/7","2/2","25/10"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff617ddf),
        title: const Text("hedieaty"),
        leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),
      ),
      body: ListView.builder(
          itemCount: gifts.length,
          itemBuilder: (context,index)
          {
            return Center(
              child: Padding(padding: EdgeInsets.all(10),
                child: Card(
                  elevation: 20,
                  shadowColor: Color(0Xaaaaaa),
                  child: ListTile(
                    leading: Image.asset(gifts[index]),
                    title: Text("Friend : ${friends[index]}"),
                    subtitle: Text("due date : ${time[index]}"),
                  )
                ),
              ),
            );
          }
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
