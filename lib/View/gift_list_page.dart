import 'package:flutter/material.dart';

import '../Model/gifts_model.dart';
import '../Services/gift_service.dart';
import 'gift_details_page.dart';

class GiftListPage extends StatefulWidget {
  const GiftListPage({super.key});

  @override
  State<GiftListPage> createState() => _GiftListPageState();
}

class _GiftListPageState extends State<GiftListPage> {
  List<Gift> gifts = [];
  bool loaded = false;
  List<String> sort = ["name" , "category" , "status"];


  getGifts()async{
    gifts = await GiftService().getGifts();
    loaded = true;
    setState(() {

    });
  }
@override
  void initState() {
    getGifts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff617ddf),
        title: const Text("hedieaty"),
        leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),
        actions: [
          DropdownButton(
              icon: Icon(Icons.sort , color: Colors.white,),
              items: sort.map((x){
                return DropdownMenuItem(value: x,child: Text('$x'));
              }).toList(), onChanged: (var x)
          {
            setState(() {
              gifts.sort();
            });
          }),
        ],
      ),

      body: loaded?GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2
      ),
          itemCount: gifts.length,
          itemBuilder: (context,index)
          {
            return Center(
              child: Padding(padding: EdgeInsets.all(10),
              child: Card(
                color: gifts[index].pledge?Colors.yellow:Colors.white,
                elevation: 20,
                shadowColor: Color(0Xaaaaaa),
                child:
                    Row(
                      children: [
                        Column(
                          children: [
                            Center(
                                child: Image.network(gifts[index].thumbnail, width: 100, height: 100,),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Center(
                              child: Container(
                                width: 100,
                                child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> GiftDetailsPage()));
                                    },
                                    child: Text(gifts[index].title,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        gifts[index].pledge?Icon(Icons.check_box):Icon(Icons.check_box_outline_blank),
                      ],
                    ),
              ),
              ),
            );
          }

      ):Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}
