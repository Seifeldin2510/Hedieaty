import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/Model/database_class.dart';
import 'package:hedieaty/Model/notifications_model.dart';
import 'package:hedieaty/Services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class notificationService{
  DatabaseClass mydb = DatabaseClass();
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<void> addNotificationToFireBase(int id , String message,String email,int userId)async{
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // int currentId = await prefs.getInt("currentUser")!;
    await firestore.collection('Notifications').add(
        {
          'id': id,
          'message':message,
          'email' : email,
          'userid':userId
        }
    );
  }



  Future<void> addNotificationSQL(String message,String email, int userId) async
  {
    await mydb.insertData('''
    Insert into 'Notifications'
    (Email, message, UserId)
    values
    ('$email','$message','$userId')
    ''');
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
      notifications.add(notificationsModel(userEmail: response[i]['Email'], message: response[i]['message']));
    }
    return notifications;
  }


  Future<int> getNewNotificationsAddSQL(String message, String email,int id) async
  {
    List<Map> response = await mydb.readData('''
    select * from Notifications where UserId = '$id' and Email = '$email' and message = '$message'
    ''');
    int notificationId = response[0]["Id"];
    return notificationId;
  }


  Future<notificationsModel> getLastNotificationsSQL() async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = await prefs.getInt("currentUser")!;
    List<Map> response = await mydb.readData('''
    select * from Notifications where UserId = '$userId'
    ''');
    notificationsModel notifications=notificationsModel(userEmail: response[response.length-1]['Email'], message: response[response.length-1]['message']);
    return notifications;
  }



}