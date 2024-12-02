import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:hedieaty/Model/database_class.dart';

import '../Model/gifts_model.dart';

class GiftService{
  String endpoint = "https://dummyjson.com/products";
  DatabaseClass mydb = DatabaseClass();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Gift>> getGifts() async {
    List<Gift> gifts = [];
    try{
      var response = await Dio().get(endpoint);
      var data = response.data["products"];
      data.forEach((json)
      {
        Gift gift = Gift.fromJson(json);
        gifts.add(gift);
      });
    }
    catch(e)
    {
      print(e.toString());
    }
    return gifts;
  }

  Future addGiftSQL(String title,String description,String thumbnail , String brand , String category , double price , bool pledge,int EventId) async
  {
    await mydb.insertData('''
    INSERT INTO Gifts (Title, Description, Thumbnail, Brand, Category, Price, Pledge, EventId)  
      VALUES  
      ('$title','$description','$thumbnail','$brand','$category','$price','$pledge','$EventId')
    ''');
  }

  Future getGiftsSQL(int EventID) async
  {
    await mydb.insertData('''
    select * from Gifts where EventId = '$EventID'
    ''');
  }


  Future<List> fetchdata()async
  {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Gifts').get();
    List x=[];
    for (var doc in querySnapshot.docs)
    {
      x.add(doc.data());
    }
    return x;
  }


  Future<void> addGiftFireBase(int id , String title,String description,String thumbnail , String brand , String category , double price , bool pledge,int EventId)async{
    await firestore.collection('Gifts').add(
        {
          'id':id,
          'title':title,
          'description':description,
          'thumbnail':thumbnail,
          'brand':description,
          'category':category,
          'price':price,
          'pledged':pledge,
          'eventId':EventId,
        }
    );
  }




}