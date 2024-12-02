

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/Model/database_class.dart';
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

Future<List<Map>> getallEventsSQL(int UserID) async
{
  List<Map> response = await mydb.readData('''
  select * from Events where UserID = '$UserID'
  ''');
  return response;
}

Future UpdateEvent(int id , String name , String date , String location , String description) async
{
  await mydb.updateData('''
  update Events set Name = '$name',Description='$description',Date='$date',Location='$location'
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










}