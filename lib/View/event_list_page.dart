import 'package:flutter/material.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {

  void _addEvent()
  {
    myEvents.add("wedding");
    setState(() {

    });
  }

  List<String> sort = ["name" , "category" , "status"];

  List<String> myEvents = ['Graduation','Birthday'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff617ddf),
        title: const Text("hedieaty"),
        leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),
        actions: [
          DropdownButton(
              icon: Icon(Icons.sort),
              items: sort.map((x){
                return DropdownMenuItem(value: x,child: Text('$x'));
              }).toList(), onChanged: (var x)
          {
            setState(() {
              myEvents.sort();
            });
          }),
        ],
      ),
      body: Center(
        child: ListView.separated(
          itemCount: myEvents.length,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(myEvents[index]),
              trailing: Icon(Icons.edit),
            );
          },
          separatorBuilder: (context,index)
          {
            return Divider();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: Icon(Icons.add),
      ),
    );
  }
}
