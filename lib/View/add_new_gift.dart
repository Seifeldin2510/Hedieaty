import 'package:flutter/material.dart';
import 'package:hedieaty/Services/gift_service.dart';
import 'package:hedieaty/View/gift_list_page.dart';

class AddNewGift extends StatefulWidget {
  int eventId;
  bool current;
  AddNewGift({super.key,required this.eventId,required this.current});

  @override
  State<AddNewGift> createState() => _AddNewGiftState();
}

class _AddNewGiftState extends State<AddNewGift> {
  final _formKey=GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController thumbnailController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController priceController =TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff617ddf),
        title: const Text("Add Gift"),
        leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),
      ),
      body: Center(
        child: Expanded(
          child:Center(
            child:
            Form(
              key : _formKey,
              child:ListView(
                children: [
                  Padding(padding: const EdgeInsets.all(4.0),
                    child:
                    TextFormField(
                      controller: titleController,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Title must not be empty";
                        }
                      },
                      decoration: const InputDecoration(label: Text("Enter Title",)),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(4.0),
                    child:
                    TextFormField(
                      controller: thumbnailController,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Thumbnail must not be empty";
                        }
                      },
                      decoration: const InputDecoration(label: Text("Enter Thumbnail Link",)),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(4.0),
                    child:
                    TextFormField(
                      controller: brandController,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Brand must not be empty";
                        }
                      },
                      decoration: const InputDecoration(label: Text("Enter Brand",)),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(4.0),
                    child:
                    TextFormField(
                      controller: descriptionController,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Description must not be empty";
                        }
                      },
                      decoration: const InputDecoration(label: Text("Enter Description",)),
                    ),
                  ),

                  Padding(padding: const EdgeInsets.all(4.0),
                    child:
                    TextFormField(
                      controller: categoryController,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Category must not be empty";
                        }
                      },
                      decoration: const InputDecoration(label: Text("Enter Category",)),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(4.0),
                    child:
                    TextFormField(
                      controller: priceController,
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Price must not be empty";
                        }
                        if(double.parse(value) <=0 )
                          {
                            return "Price must be greater than Zero";
                          }
                      },
                      decoration: const InputDecoration(label: Text("Enter Price",)),
                    ),
                  ),

                  FloatingActionButton(
                    backgroundColor: Color(0xff617ddf),
                    onPressed: () async
                    {
                      if (_formKey.currentState!.validate()) {
                        await GiftService().addGiftSQL(titleController.text, descriptionController.text, thumbnailController.text.replaceAll('/', 'Z'), brandController.text, categoryController.text, double.parse(priceController.text), 0, widget.eventId);
                        int newId = await GiftService().getNewGiftId(titleController.text, descriptionController.text, thumbnailController.text.replaceAll('/', 'Z'), brandController.text, categoryController.text, double.parse(priceController.text), 0, widget.eventId);
                        await GiftService().addGiftFireBase(newId,titleController.text, descriptionController.text, thumbnailController.text, brandController.text, categoryController.text, double.parse(priceController.text), 0, widget.eventId);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> GiftListPage(current: widget.current,eventId: widget.eventId,)));
                      }
                    },
                    child: Text("Add"),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        style: TextButton.styleFrom(backgroundColor: Color(0xff617ddf)),
                        onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Back")),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
