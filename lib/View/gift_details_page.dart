import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GiftDetailsPage extends StatefulWidget {
  const GiftDetailsPage({super.key});

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
      body: ListView(
        children: [
          Form(
              key : _formKey,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text("Name : "),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            width: 200,
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(label: Text("Enter Name"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text("Description : "),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            width: 200,
                            child: TextFormField(
                              controller: descriptionController,
                              decoration: InputDecoration(label: Text("Enter Description,"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text("Category : "),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            width: 200,
                            child: TextFormField(
                              controller: categoryController,
                              decoration: InputDecoration(label: Text("Enter category"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Text("Price : "),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            width: 200,
                            child: TextFormField(
                              controller: priceController,
                              decoration: InputDecoration(label: Text("Enter Price"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(onPressed: ()
                        {
                        },
                        child: Text("Pick image from gallary"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Pledged"),
                        ),
                        ToggleButtons(
                          onPressed:(int index){
                            setState(() {
                              for(int buttonIndex = 0 ; buttonIndex < isSelected.length;buttonIndex++)
                                {
                                  if(buttonIndex == index)
                                    {
                                      isSelected[buttonIndex] = true;
                                    }
                                  else{
                                    isSelected[buttonIndex] = false;
                                  }
                                }
                            });
                          } ,
                            children: <Widget>[
                              Icon(Icons.check_box),
                              Icon(Icons.check_box_outline_blank),
                            ], isSelected: isSelected),
                      ],
                    )
                  ],
                ),
              )
          ),
        ],
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
