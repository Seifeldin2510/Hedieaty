import 'package:flutter/material.dart';
import 'package:hedieaty/View/add_new_gift.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/gifts_model.dart';
import '../Services/gift_service.dart';
import 'gift_details_page.dart';

class GiftListPage extends StatefulWidget {
  bool current;
  int eventId;
  GiftListPage({super.key,required this.current,required this.eventId});

  @override
  State<GiftListPage> createState() => _GiftListPageState();
}

class _GiftListPageState extends State<GiftListPage> {
  List<Gift> gifts = [];
  bool loaded = false;
  List<String> sort = ["name" , "category" , "status"];

  getGifts()async{
    if(widget.eventId == 0)
      {
        final SharedPreferences pref = await SharedPreferences.getInstance();
        int id = pref.getInt("currentUser")!;
        gifts = await GiftService().getAllCurrentUserGifts(id);
      }
    else
    {
      gifts = await GiftService().getGiftsSQL(widget.eventId);
    }
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

      body: loaded?
      Column(
        children: [
          Expanded(
            child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      child: Image.network(gifts[index].thumbnail.replaceAll('Z', '/'), width: 100, height: 100,),
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

            ),
          ),
          widget.current? Text(""):(widget.eventId==0?Text(""):ElevatedButton(onPressed: (){
    Navigator.pop(context);
    }, child: Text("Back"),
    )),
      widget.current?(widget.eventId == 0?Text(""):
      ElevatedButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>AddNewGift(eventId:widget.eventId)));
      }, child: Text("Add New Gift"),
      )
      ):
      Text(""),
        ],
      ):
      Center(
        child: CircularProgressIndicator(),
      )
    );
  }
}
