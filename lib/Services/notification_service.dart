import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/Model/database_class.dart';
import 'package:hedieaty/Model/notifications_model.dart';
import 'package:hedieaty/Services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class notificationService{
  DatabaseClass mydb = DatabaseClass();
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> addNotificationToFireBase(int id , String message,String email)async{
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // int currentId = await prefs.getInt("currentUser")!;
    await firestore.collection('Notifications').add(
        {
          'id': id,
          'message':message,
          'email' : email
        }
    );
  }

  Future<List<notificationsModel>> getNotificationsSQL() async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = await prefs.getInt("currentUser")!;
    List<Map> response = await mydb.readData('''
    select * from Notifications where UserId = '$userId'
    ''');
    List<notificationsModel> notifications=[];
    for (int i =0 ;i<response.length;i++)
    {
      notifications.add(notificationsModel(userEmail: response[i]['UserEmail'], message: response[i]['message']));
    }
    return notifications;
  }




}