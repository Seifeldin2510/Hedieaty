
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:hedieaty/Model/database_class.dart';
import 'package:hedieaty/Model/event_model.dart';
import 'package:hedieaty/Services/event_Service.dart';

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

  Future addGiftSQL(String title,String description,String thumbnail , String brand , String category , double price , int pledge,int EventId) async
  {
    await mydb.insertData('''
    INSERT INTO Gifts (Title, Description, Thumbnail, Brand, Category, Price, Pledge, EventId)  
      VALUES  
      ('$title','$description','$thumbnail','$brand','$category','$price','$pledge','$EventId')
    ''');
  }

  Future<List<Gift>> getAllCurrentUserGifts(int userId)async{
    List<Gift> gifts=[];
    List<Event> events = await EventService().getallEventsSQL(userId);
    for(int i = 0 ; i<events.length;i++)
      {
        List<Gift> gift = await getGiftsSQL(events[i].id);
        gifts.addAll(gift);
      }
        return gifts;
  }


  Future<Map> getGiftsSQLId(int giftId) async
  {
    List<Map> response = await mydb.readData('''
    select * from Gifts where ID = '$giftId'
    ''');
    Map gifts;
      gifts = {'image':response[0]['Thumbnail'],
      'eventId':response[0]['EventId'],
      };

    return gifts;
  }


  Future<List<Gift>> getGiftsSQL(int EventID) async
  {
     List<Map> response = await mydb.readData('''
    select * from Gifts where EventId = '$EventID'
    ''');
    List<Gift> gifts=[];
    for (int i =0 ;i<response.length;i++)
    {
      gifts.add(Gift(id: response[i]['ID'], title: response[i]['Title'], description: response[i]['Description'], price: response[i]['Price'], brand: response[i]['Brand'], category: response[i]['Category'], thumbnail: response[i]['Thumbnail'],pledge: response[i]['Pledge']==0?false:true));
    }
    return gifts;
  }

  Future<int> getNewGiftId(String title,String description,String thumbnail , String brand , String category , double price , int pledge,int EventId) async
  {
    List<Map> response = await mydb.readData('''
  select ID from Gifts Where Title = '$title' and Description = '$description' and Thumbnail = '$thumbnail' and Brand = '$brand' and Category = '$category' and Price = '$price' and Pledge = '$pledge' and EventId = '$EventId'
  ''');
    int id = response[0]["ID"];
    return id;
  }


  Future UpdateGift(int id , String title,String description,String thumbnail , String brand , String category , double price , int pledge,int EventId) async
  {
    await mydb.updateData('''
  update Gifts set Title = '$title',Description = '$description' , Thumbnail = '$thumbnail' , Brand = '$brand' , Category = '$category' , Price = '$price' , Pledge = '$pledge' , EventId = '$EventId'
  where ID = '$id'
  ''');
  }



  Future<void> updateGiftFire(int id , String title,String description,String thumbnail , String brand , String category , double price , int pledge,int EventId) async{
    final querySnapshot = await FirebaseFirestore.instance.collection('Gifts').where('id' ,isEqualTo: id).get();
    for (var doc in querySnapshot.docs) {
      await doc.reference.update({
        'id':id,
        'title':title,
        'description':description,
        'thumbnail':thumbnail,
        'brand':brand,
        'category':category,
        'price':price,
        'pledged':pledge,
        'eventId':EventId,
      });
    }
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


  Future<void> addGiftFireBase(int id , String title,String description,String thumbnail , String brand , String category , double price , int pledge,int EventId)async{
    await firestore.collection('Gifts').add(
        {
          'id':id,
          'title':title,
          'description':description,
          'thumbnail':thumbnail,
          'brand':brand,
          'category':category,
          'price':price,
          'pledged':pledge,
          'eventId':EventId,
        }
    );
  }




}