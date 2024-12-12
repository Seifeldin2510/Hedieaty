
import 'package:flutter/material.dart';
import 'package:hedieaty/Model/user_model.dart';
import 'package:hedieaty/Services/event_Service.dart';
import 'package:hedieaty/Services/user_service.dart';
import 'package:hedieaty/View/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEventPage extends StatefulWidget {
  int id;
  String name;
  String date;
  String location;
  String description;

  AddEventPage({super.key,required this.id,required this.name,required this.date, required this.location,required this.description});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey=GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late int userId;

  Future<void> getId() async{
    SharedPreferences pref =  await SharedPreferences.getInstance();
    userId = pref.getInt('currentUser')!;
  }

  @override
  void initState() {
    getId();
    nameController.text = widget.name;
    dateController.text = widget.date;
    locationController.text = widget.location;
    descriptionController.text = widget.description;
    setState(() {

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff617ddf),
        title:  Text(widget.name),
        leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
                child:Center(
                  child:
                  Form(
                    key : _formKey,
                    child:ListView(
                      children: [
                        Padding(padding: const EdgeInsets.all(4.0),
                          child:
                          TextFormField(
                            controller: nameController,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "Name must not be empty";
                              }
                            },
                            decoration: const InputDecoration(label: Text("Enter Event Name",)),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.all(4.0),
                          child:
                          TextFormField(
                            controller: dateController,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "Date must not be empty";
                              }
                            },
                            decoration: const InputDecoration(label: Text("Enter Date",)),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.all(4.0),
                          child:
                          TextFormField(
                            controller: locationController,
                            validator: (value){
                              if(value!.isEmpty)
                              {
                                return "Location must not be empty";
                              }
                            },
                            decoration: const InputDecoration(label: Text("Enter Location",)),
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

                        FloatingActionButton(
                          onPressed: () async
                          {
                            if(_formKey.currentState!.validate()){
                              if(widget.id==0)
                                {
                                  await EventService().addEventSQL(nameController.text, dateController.text, locationController.text, descriptionController.text, userId);
                                  int newId = await EventService().getNewEventId(nameController.text, dateController.text, locationController.text, descriptionController.text, userId);
                                  await EventService().addEventFireBase(newId, nameController.text, dateController.text, locationController.text, descriptionController.text);
                                }
                              else{
                                await EventService().UpdateEvent(widget.id,nameController.text, dateController.text, locationController.text, descriptionController.text, userId);
                                await EventService().updateEventFire(widget.id,nameController.text, dateController.text, locationController.text, descriptionController.text, userId);

                              }
                            }
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                          },
                          child: widget.id==0? Text("Add"):Text("Edit"),
                        ),
                      ],),
                  ),
                ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Back")),
            )
          ],
        ),
      ),
    );
  }
}
