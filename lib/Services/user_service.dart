
import 'package:dio/dio.dart';
import 'package:hedieaty/Model/database_class.dart';
import 'package:hedieaty/Services/event_Service.dart';

import '../Model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService{
  String endpoint = "https://dummyjson.com/user";
  static int count=2;
  static late String currentUserId;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DatabaseClass mydb = DatabaseClass();


  Future<List<userModel>> getFriends() async {
    List<userModel> users = [];
    try{
      var response = await Dio().get(endpoint);
      var data = response.data["users"];
      data.forEach((json)
      {
        userModel user = userModel.fromJson(json);
        users.add(user);
      });
    }
    catch(e)
    {
      print(e.toString());
    }
    return users;
  }

int getcount()
{
  return UserService.count;
}


  Future<User?> signUp(String email,String password) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch (e)
    {
      print('error: ${e.message}');
      return null;
    }
  }

  Future<User?> signIn(String email , String password) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    }on FirebaseAuthException catch (e)
    {
      print("error: ${e.message}");
      return null;
    }
  }


  Future<void> saveUserData(int id ,String firstname,String lastName,int age,String email,String username,String password,String image )async{
    User? user = FirebaseAuth.instance.currentUser;
    if(user!=null)
    {
      String uid = user.uid;
      currentUserId = uid;
      FirebaseFirestore.instance.collection('users').doc(uid).set({
        'id':id,
        'Firstname': firstname,
        'Lastname':lastName,
        'age':age,
        'email':email,
        'username':username,
        'password':password,
        'image':image,
      });
      count++;
    }
  }


  Future<void> signOut()async{
    await FirebaseAuth.instance.signOut();
  }

  Future<DocumentSnapshot>getUserData()async{
    User? user = FirebaseAuth.instance.currentUser;
    if(user!=null)
    {
      String uid = user.uid;
      return FirebaseFirestore.instance.collection('users').doc(uid).get();
    }
    return Future.error("User Not signed in");
  }

  Future addUserSQL(String firstname,String lastName,int age,String email,String username,String password,String image) async{

    email = email.replaceAll('@', 'a');
    image = image.replaceAll(":", 'Z');
    image = image.replaceAll("/", 'z');
    await mydb.insertData('''
    Insert into "Users"
     (Firstname,Lastname,age,Email,UserName,Password,Image)
    values
    ('$firstname','$lastName','$age','$email','$username','$password','$image')
    ''');
  }

  Future<int> getUserByemail(String email) async{
    email = email.replaceAll('@', 'a');
    var x = await mydb.readData('''
    select * from Users where Email = '$email'
    ''');
    print("Hi ${x}");
    print("Hello ${x[0]['ID']}");
    return x[0]['ID'];
  }

  Future<userModel> getUsers(int id)async{
    var x = await mydb.readData('''
    select * from Users where ID = '$id'
    ''');
    int count = await EventService().getEventCount(id);
    userModel user = userModel(id: x['ID'], firstName: x['Firstname'], lastName: x['Lastname'], age: x['age'], email: x['Email'], username: x['UserName'], password: x['Password'], image: ((x['Image']).replaceAll('Z',':')).replaceAll('z','/'),eventNumber: count);
    return user;
  }

















}