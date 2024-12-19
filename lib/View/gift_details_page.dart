import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty/Model/gifts_model.dart';
import 'package:hedieaty/Services/gift_service.dart';
import 'package:hedieaty/Services/pledge_service.dart';

class GiftDetailsPage extends StatefulWidget {
  Gift gift;
  int eventId;
  bool current;
  GiftDetailsPage({super.key,required this.gift,required this.eventId,required this.current});

  @override
  State<GiftDetailsPage> createState() => _GiftDetailsPageState();
}

class _GiftDetailsPageState extends State<GiftDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff617ddf),
      title: const Text("hedieaty"),
      leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),
      ),
      body: Center(
        child: Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Image.network(widget.gift.thumbnail.replaceAll('Z', '/')),
                ),
              ),
              Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("Name: ${widget.gift.title}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Brand: ${widget.gift.brand}"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Category: ${widget.gift.category}"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Price: ${widget.gift.price}"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Description: ${widget.gift.description}"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.gift.pledge?const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("This gift has been pledged",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(
                      width: 5,
                    ),
                    AnimatedEmoji(
                      AnimatedEmojis.smile,
                    ),
                  ],
                ):const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("This gift has not been pledged",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(
                      width: 5,
                    ),
                    AnimatedEmoji(
                      AnimatedEmojis.sad,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: ElevatedButton(
                      style: TextButton.styleFrom(backgroundColor: widget.gift.pledge?Colors.green:Colors.red),
                        onPressed: () async{
                      if(!widget.current) {
                        bool check = await PledgedGiftService().checkPledgedUser(widget.gift.id);
                        if (check) {
                          widget.gift.pledge = !(widget.gift.pledge);
                          await GiftService().UpdateGift(widget.gift.id, widget.gift.title, widget.gift.description.replaceAll("'", "''"), widget.gift.thumbnail.replaceAll('/', 'Z'), widget.gift.brand, widget.gift.category, widget.gift.price, widget.gift.pledge ? 1 : 0, widget.eventId);
                          await GiftService().updateGiftFire(widget.gift.id, widget.gift.title, widget.gift.description, widget.gift.thumbnail, widget.gift.brand, widget.gift.category, widget.gift.price, widget.gift.pledge ? 1 : 0, widget.eventId);
                          if(widget.gift.pledge)
                          {
                            await PledgedGiftService().addPledgedGiftsSQl(widget.gift.id);
                            await PledgedGiftService().addPledgedGiftToFireBase(widget.gift.id);
                          }
                          else
                          {
                            await PledgedGiftService().deletePledgedGift(widget.gift.id);
                            await PledgedGiftService().deletePledgedGiftFire(widget.gift.id);
                          }
                          setState(() {});
                        }
                      }
                    },
                        child:widget.gift.pledge?Text("Gift all ready pledged"):Text("Pledge gift"),
                    ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff617ddf),
        onPressed: ()
        {
          Navigator.pop(context);
        },
        child: Icon(Icons.keyboard_backspace_outlined),
      ),
    );
  }
}
