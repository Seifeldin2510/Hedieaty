import 'package:flutter/material.dart';
import 'package:hedieaty/Model/notifications_model.dart';
import 'package:hedieaty/Services/notification_service.dart';

class notificationPage extends StatefulWidget {
  const notificationPage({super.key});

  @override
  State<notificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {
  bool loaded = false;
  List<notificationsModel> notifications = [];


  Future<void>getNotifications()async{
    notifications = await notificationService().getNotificationsSQL();
    loaded = true;
    setState(() {

    });
  }

  @override
  void initState() {
    getNotifications();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff617ddf),
        title: const Text("Notifications"),
        leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),
      ),
      body: Column(
        children: [
          loaded? Expanded(
            child: ListView.separated(
              itemCount: notifications.length ,
              itemBuilder:(context,index){
                return ListTile(
                  title: Text("${notifications[index].message}"),

                  subtitle: Text("sender email: ${notifications[index].userEmail.replaceFirst("agmail", "@gmail")}"),
                );
              },
              separatorBuilder: (context,index){
                return Divider();
              },
            ),
          )
              :Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
