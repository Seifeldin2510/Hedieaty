import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/Model/database_class.dart';
import 'package:hedieaty/Model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FriendService{

  DatabaseClass mydb = DatabaseClass();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future addFriend(int id, int friendId) async
  {
    mydb.insertData('''
    INSERT INTO Friends (UserId,FriendId)  
      VALUES  
      ('$id','$friendId')
    ''');
  }


  Future<List<userModel>> getAllFriendSQL() async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? UserID = prefs.getInt("currentUser");
    List<Map> response = await mydb.readData('''
        SELECT u.*
        FROM Users u
        JOIN Friends f ON u.ID = f.FriendId
        WHERE f.UserId = '$UserID';
  ''');
   List<userModel> friends = [];
    for (int i =0 ;i<response.length;i++)
      {
        friends.add(userModel(id: response[i]['ID'], firstName: response[i]['Firstname'], lastName: response[i]['Lastname'], age: response[i]['age'], email: response[i]['Email'], username: response[i]['UserName'], password: response[i]['Password'], image: ((response[i]['Image']).replaceAll('Z',':')).replaceAll('z','/')));
      }
    return friends;
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