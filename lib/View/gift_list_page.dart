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
  List<String> sort = ["title" , "category" , "status"];

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
              if(x=="title") {
                    gifts.sort((a, b) => a.title.compareTo(b.title));
                  }
              else if(x=="category")
                {
                  gifts.sort((a, b) => a.category.compareTo(b.category));
                }
              else if(x=="status")
                {
                  gifts.sort((a, b) => a.pledge.toString().compareTo(b.pledge.toString()));
                }
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
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=> GiftDetailsPage(gift: gifts[index],eventId: widget.eventId,current: widget.current,)));
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
                              IconButton(onPressed: ()async{
                                if(widget.eventId!=0 && !widget.current)
                                {
                                  gifts[index].pledge = !(gifts[index].pledge);
                                  await GiftService().UpdateGift(gifts[index].id, gifts[index].title, gifts[index].description.replaceAll("'", "''"), gifts[index].thumbnail.replaceAll('/', 'Z'), gifts[index].brand, gifts[index].category, gifts[index].price, gifts[index].pledge ? 1 : 0, widget.eventId);
                                  await GiftService().updateGiftFire(gifts[index].id, gifts[index].title, gifts[index].description, gifts[index].thumbnail, gifts[index].brand, gifts[index].category, gifts[index].price, gifts[index].pledge ? 1 : 0, widget.eventId);
                                  setState(() {

                                  });
                                }
                              },
                                icon: gifts[index].pledge?Icon(Icons.check_box):Icon(Icons.check_box_outline_blank),)
                            ],
                          ),
                    ),
                    ),
                  );
                }

            ),
          ),
      widget.current?(widget.eventId == 0?Text(""):
      ElevatedButton(onPressed: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>AddNewGift(current: widget.current,eventId:widget.eventId)));
      }, child: Text("Add New Gift"),
      )
      ):
      Text(""),
        ],
      ):
      Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: Visibility(
        visible: widget.eventId == 0? false:true,
        child: FloatingActionButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text("Back"),
        ),
      ),
    );
  }
}
