import 'package:dio/dio.dart';

import '../Model/gifts_model.dart';

class GiftService{
  String endpoint = "https://dummyjson.com/products";

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
}