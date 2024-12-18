

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/Model/database_class.dart';
import 'package:hedieaty/Model/event_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventService{
  DatabaseClass mydb = DatabaseClass();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static int count=1;


  Future addEventSQL(String name , String date , String location , String description,int UserID) async{
    await mydb.insertData('''
    Insert into 'Events'
    (Name, Description, Date, Location, UserID)
    values
    ('$name','$description','$date','$location','$UserID')
    ''');
  }

Future<List<Event>> getallEventsSQL(int UserID) async
{
  List<Map> response = await mydb.readData('''
  select * from Events where UserID = '$UserID'
  ''');
  List<Event> events = [];
  for (int i =0 ;i<response.length;i++)
  {
    events.add(Event(id: response[i]['ID'], name: response[i]['Name'], description: response[i]['Description'], date: response[i]['Date'], location: response[i]['Location']));
  }
  return events;
}

  Future<Map> getEventsSQLId(int EventId) async
  {
    List<Map> response = await mydb.readData('''
  select * from Events where ID = '$EventId'
  ''');
    Map events ;
      events = {'date':response[0]['Date'],
      'userId':response[0]['UserID']
      };
    return events;
  }


Future UpdateEvent(int id , String name , String date , String location , String description,int userid) async
{
  await mydb.updateData('''
  update Events set Name = '$name',Description='$description',Date='$date',Location='$location','userId'='$userid'
  where ID = '$id'
  ''');
}

Future deleteEvent(int id) async{
    await mydb.deleteData('''
    delete from Events where ID = '$id'
    ''');
}

  Future<List> fetchdata()async
  {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Events').get();
    List x=[];
    for (var doc in querySnapshot.docs)
      {
        x.add(doc.data());
      }
    return x;
  }


  Future<void> addEventFireBase(int id , String name , String date , String location , String description)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userid = prefs.getInt('currentUser');
    await firestore.collection('Events').add(
        {
        'id':id,
        'name':name,
        'date':date,
        'location':location,
        'description':description,
        'userId':userid
        }
    );
    count++;
  }

  int getCount()
  {
    return EventService.count;
  }

  Future<void> updateEventFire(int id , String name , String date , String location , String description,int userid) async{
    final querySnapshot = await FirebaseFirestore.instance.collection('Events').where('id' ,isEqualTo: id).get();
    for (var doc in querySnapshot.docs) {
      await doc.reference.update({
        'id':id,
        'name':name,
        'date':date,
        'location':location,
        'description':description,
        'userId':userid
      });
    }
  }

  Future<void> deleteEventFire(int id) async{
    final querySnapshot = await FirebaseFirestore.instance.collection('Events').where('id' ,isEqualTo: id).get();
    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }



  Future<int> getEventCount(int id) async
  {
    List<Map> response = await mydb.readData('''
  select count(ID) from Events where UserID = '$id'
  ''');
    int count = response[0]["count(ID)"];
    return count;
  }


  Future<int> getNewEventId(String name , String date , String location , String description,int UserID) async
  {
    List<Map> response = await mydb.readData('''
  select ID from Events Where name = '$name' and location = '$location' and description = '$description' and date = '$date' and userId = '$UserID'
  ''');
    int id = response[0]["ID"];
    return id;
  }



}
