import 'dart:io';

import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.dart';
import 'package:flutter/material.dart';
import 'package:hedieaty/Model/gifts_model.dart';

class GiftDetailsPage extends StatefulWidget {
  Gift gift;
  GiftDetailsPage({super.key,required this.gift});

  @override
  State<GiftDetailsPage> createState() => _GiftDetailsPageState();
}

class _GiftDetailsPageState extends State<GiftDetailsPage> {
  final _formKey=GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<bool>  isSelected = [true,false];

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
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Image.network(widget.gift.thumbnail.replaceAll('Z', '/')),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          Navigator.pop(context);
        },
        child: Icon(Icons.keyboard_backspace_outlined),
      ),
    );
  }
}
