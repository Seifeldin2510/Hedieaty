import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hedieaty/Model/database_class.dart';

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


  Future<List<Map>> getAllFriendSQL(int UserID) async
  {
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

  Future<void> addFriendsFireBase(int id, int friendId)async{
    await firestore.collection('Friends').add(
        {
          'id':id,
          'friends':friendId
        }
    );
  }



}