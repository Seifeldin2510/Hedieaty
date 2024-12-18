import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/Model/database_class.dart';
import 'package:hedieaty/Model/event_model.dart';
import 'package:hedieaty/Model/gifts_model.dart';
import 'package:hedieaty/Model/pledged_model.dart';
import 'package:hedieaty/Model/user_model.dart';
import 'package:hedieaty/Services/event_Service.dart';
import 'package:hedieaty/Services/gift_service.dart';
import 'package:hedieaty/Services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PledgedGiftService{
  DatabaseClass mydb = DatabaseClass();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<PledgedGifts>> getMyPledgedGiftsSQL() async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = await prefs.getInt("currentUser")!;
    List<Map> response = await mydb.readData('''
    select * from Pledged where UserId = '$userId'
    ''');
    List<PledgedGifts> pledgedGifts=[];
    for(int i =0 ; i<response.length;i++)
      {
        Map gift = await GiftService().getGiftsSQLId(response[i]['GiftId']);
        Map event = await EventService().getEventsSQLId(gift['eventId']);
        userModel user = await UserService().getUsers(event['userId']);
        pledgedGifts.add(PledgedGifts(name: user.username,date: event['date'],image: gift['image']));
      }
    return pledgedGifts;
  }

  Future<void> addPledgedGiftsSQl(int giftId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = await prefs.getInt("currentUser")!;
    await mydb.insertData('''
    Insert into 'Pledged'
    (UserId,GiftId)
    values
    ('$userId','$giftId')
    ''');
  }

  Future<void> addPledgedGiftToFireBase(int giftId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentId = await prefs.getInt("currentUser")!;
    await firestore.collection('PledgedGifts').add(
        {
          'userId': currentId,
          'giftId':giftId
        }
    );
  }

  Future<bool> checkPledgedUser(int giftId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentId = await prefs.getInt("currentUser")!;
    List<Map> response = await mydb.readData('''
    select * from Pledged where GiftId = '$giftId'
    ''');
    if(response.isEmpty)
      {
        return true;
      }
    if(response[0]['UserId']==currentId)
      {
        return true;
      }
    else{
      return false;
    }
  }

  Future deletePledgedGift(int giftId) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentId = await prefs.getInt("currentUser")!;
    await mydb.deleteData('''
    delete from Pledged where GiftId = '$giftId' and UserId = '$currentId'
    ''');
  }

  Future<void> deletePledgedGiftFire(int giftId) async{
    final querySnapshot = await FirebaseFirestore.instance.collection('PledgedGifts').where('giftId' ,isEqualTo: giftId).get();
    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

}