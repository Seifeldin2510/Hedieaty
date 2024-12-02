import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/Model/database_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendService{

  DatabaseClass mydb = DatabaseClass();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future addFriend(int id, int friendId) async
  {
    mydb.insertData('''
    INSERT INTO Friends (UserId,FriendId)  
      VALUES  
      ($id,$friendId)
    ''');
  }


  Future<List<Map>> getAllFriendSQL() async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? UserID = prefs.getInt("currentUser");
    List<Map> response = await mydb.readData('''
  select * from Friends where UserId = $UserID
  ''');
    return response;
  }

  Future<List> fetchdata()async
  {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Friends').get();
    List x=[];
    for (var doc in querySnapshot.docs)
    {
      x.add(doc.data());
    }
    return x;
  }

  Future<void> addFriendsFireBase(int friendId)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await firestore.collection('Friends').add(
        {
          'id': prefs.getInt("currentUser"),
          'friends':friendId
        }
    );
  }



}