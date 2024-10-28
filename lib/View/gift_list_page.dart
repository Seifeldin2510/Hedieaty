import 'package:flutter/material.dart';

import 'gift_details_page.dart';

class GiftListPage extends StatefulWidget {
  const GiftListPage({super.key});

  @override
  State<GiftListPage> createState() => _GiftListPageState();
}

class _GiftListPageState extends State<GiftListPage> {

  List<String> sort = ["name" , "category" , "status"];
  List<String> gifts = ["assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg"];
  List<bool> pledge = [true,false,false,true,true,true,false,false];
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

      body: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2
      ),
          itemCount: gifts.length,
          itemBuilder: (context,index)
          {
            return Center(
              child: Padding(padding: EdgeInsets.all(10),
              child: Card(
                color: pledge[index]?Colors.yellow:Colors.white,
                elevation: 20,
                shadowColor: Color(0Xaaaaaa),
                child:
                    Row(
                      children: [
                        Column(
                          children: [
                            Image.asset(gifts[index], width: 100, height: 100,),
                            SizedBox(
                              height: 30,
                            ),
                            InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> GiftDetailsPage()));
                                },
                                child: Text("Gift number ${index + 1}")),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        pledge[index]?Icon(Icons.check_box):Icon(Icons.check_box_outline_blank),
                      ],
                    ),
              ),
              ),
            );
          }

      ),
    );
  }
}
