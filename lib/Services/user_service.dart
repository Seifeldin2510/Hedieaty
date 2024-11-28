import 'package:dio/dio.dart';

import '../Model/user_model.dart';

class UserService{
  String endpoint = "https://dummyjson.com/user";

  Future<List<User>> getFriends() async {
    List<User> users = [];
    try{
      var response = await Dio().get(endpoint);
      var data = response.data["users"];
      data.forEach((json)
      {
        User user = User.fromJson(json);
        users.add(user);
      });
    }
    catch(e)
    {
      print(e.toString());
    }
    return users;
  }
}