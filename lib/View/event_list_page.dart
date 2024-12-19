
import 'package:flutter/material.dart';
import 'package:hedieaty/Model/event_model.dart';
import 'package:hedieaty/Services/event_Service.dart';
import 'package:hedieaty/View/add_event_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'gift_list_page.dart';

class EventListPage extends StatefulWidget {
  bool current;
  int userId;
   EventListPage({super.key ,required this.current,required this.userId});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {


  List<String> sort = ["name"];

  List<Event> events = [];
  bool loaded = false;

  Future<void> getEvents() async
  {
    events = await EventService().getallEventsSQL(widget.userId);
    loaded = true;
    setState(() {

    });
  }

  @override
  void initState() {
    getEvents();
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
          DropdownButton(
              icon: Icon(Icons.sort , color: Colors.white,size: 35,),
              items: sort.map((x){
                return DropdownMenuItem(value: x,child: Text('$x'));
              }).toList(), onChanged: (var x)
          {
            setState(() {
              events.sort((a, b) => a.name.compareTo(b.name));
            });
          }),
        ],
      ),
      body: Center(
        child: loaded?Column(
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> GiftListPage(current: widget.current,eventId: events[index].id,)));
                        },
                          child: Card(
                            child: ListTile(
                              title: Text(events[index].name,style: TextStyle(fontSize: 25),),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(events[index].date,style: TextStyle(fontSize: 15),),
                              ),
                            ),
                          )
                      ),
                      leading: widget.current ?IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEventPage(id: events[index].id,name: events[index].name,date: events[index].date,description: events[index].description,location: events[index].location,)));
                        },
                        icon: Icon(Icons.edit,color: Colors.orange,size: 35,),
                      ):Icon(Icons.event_note,color: Color(0xff617ddf),size: 40,),
                      trailing:widget.current?IconButton(
                        onPressed: () async {
                          EventService().deleteEvent(events[index].id);
                          EventService().deleteEventFire(events[index].id);
                          events.removeAt(index);
                          setState(() {

                          });
                        },
                        icon: Icon(Icons.delete,color: Colors.red,size: 35,),
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
            widget.current? Text(""):ElevatedButton(
              style: TextButton.styleFrom(backgroundColor: Color(0xff617ddf)),
              onPressed: (){
              Navigator.pop(context);
            }, child: Text("Back"),
    )
          ],
        ):CircularProgressIndicator(),
      ),
      floatingActionButton: Visibility(
        visible: widget.current?true:false,
        child: FloatingActionButton(
          backgroundColor: Color(0xff617ddf),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddEventPage(id: 0,name: "",date: "",description: "",location: "",)));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
