

import 'package:cloud_firestore/cloud_firestore.dart';

class EventService{

  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> addEvent(int id , String name , String date , String location , String description)async{
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