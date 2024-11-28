import 'package:flutter/material.dart';
import 'package:hedieaty/Model/event_model.dart';

import 'gift_list_page.dart';

class EventListPage extends StatefulWidget {
  bool current;
   EventListPage({super.key ,required this.current});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {

  void _addEvent()
  {
    events.add(Event(id: 5, name: "party", description:"party", date: "25/10/2024", location: "Party"));
    setState(() {

    });
  }

  List<String> sort = ["name" , "category" , "status"];

 // List<String> myEvents = ['Graduation','Birthday'];
  List<Event> events = [
    Event(id: 1, name: "Birthday", description: "Party", date: "25/10/2025", location: "home"),
    Event(id: 2, name: "Wedding", description: "Party", date: "25/10/2025", location: "home"),
    Event(id: 3, name: "trip", description: "Party", date: "25/10/2025", location: "home"),
    Event(id: 4, name: "Graduation", description: "Party", date: "25/10/2025", location: "Hall"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff617ddf),
        title: const Text("hedieaty"),
        leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),
        actions: [
          DropdownButton(
              icon: Icon(Icons.sort , color: Colors.white,),
              items: sort.map((x){
                return DropdownMenuItem(value: x,child: Text('$x'));
              }).toList(), onChanged: (var x)
          {
            setState(() {
              //events.sort();
            });
          }),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemCount: events.length,
                  itemBuilder: (context,index){
                    return ListTile(
                      title: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> GiftListPage(current: widget.current,)));
                        },
                          child: Card(
                            child: ListTile(
                              title: Text(events[index].name),
                              subtitle: Text(events[index].date),
                            ),
                          )
                      ),
                      leading: widget.current ?IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.edit),
                      ):Icon(Icons.event_note),
                      trailing:widget.current?IconButton(
                        onPressed: (){
                          events.removeAt(index);
                          setState(() {

                          });
                        },
                        icon: Icon(Icons.delete),
                      ):null
                    );
                  },
                  separatorBuilder: (context,index)
                  {
                    return Divider();
                  },
                ),
              ),
            ),
            widget.current? Text(""):ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Back"),
    )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: Icon(Icons.add),
      ),
    );
  }
}
