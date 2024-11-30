

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/Model/database_class.dart';

class EventService{
  DatabaseClass mydb = DatabaseClass();
  FirebaseFirestore firestore = FirebaseFirestore.instance;



  Future addEventSQL(String name , String date , String location , String description,int UserID) async{
    await mydb.insertData('''
    Insert into 'Events'
    (Name, Description, Date, Location, UserID)
    values
    ($name,$description,$date,$location,$UserID)
    ''');
  }

Future<List<Map>> getallEventsSQL(int UserID) async
{
  List<Map> response = await mydb.readData('''
  select * from Events where UserID = $UserID
  ''');
  return response;
}

Future UpdateEvent(int id , String name , String date , String location , String description) async
{
  await mydb.updateData('''
  update Events set Name = $name,Description=$description,Date=$date,Location=$location
  where ID = $id
  ''');
}





  Future<void>  fetchdata()async
  {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Events').get();
    for (var doc in querySnapshot.docs)
      {
        print(doc.data());
      }
  }


  Future<void> addEventFireBase(int id , String name , String date , String location , String description)async{
    await firestore.collection('Events').add(
        {
        'id':id,
        'name':name,
        'date':date,
        'location':location,
        'description':description,
        }
    );
  }

}