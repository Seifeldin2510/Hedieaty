import 'package:flutter/material.dart';
import 'package:hedieaty/Model/pledged_model.dart';
import 'package:hedieaty/Services/pledge_service.dart';

class PledgedGiftListPage extends StatefulWidget {
  const PledgedGiftListPage({super.key});

  @override
  State<PledgedGiftListPage> createState() => _PledgedGiftListPageState();
}

class _PledgedGiftListPageState extends State<PledgedGiftListPage> {

  List<PledgedGifts> pledgedGifts = [];

  Future<void>getPledgedGifts() async
  {
    pledgedGifts = await PledgedGiftService().getMyPledgedGiftsSQL();
    setState(() {

    });
  }


  @override
  void initState() {
    getPledgedGifts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff617ddf),
        title: const Text("hedieaty"),
        leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),
      ),
      body: ListView.builder(
          itemCount: pledgedGifts.length,
          itemBuilder: (context,index)
          {
            return Center(
              child: Padding(padding: EdgeInsets.all(10),
                child: Card(
                  elevation: 20,
                  shadowColor: Color(0Xaaaaaa),
                  child: ListTile(
                    leading: Image.network(pledgedGifts[index].image.replaceAll('Z', '/')),
                    title: Text("Friend : ${pledgedGifts[index].name}"),
                    subtitle: Text("due date : ${pledgedGifts[index].date}"),
                  )
                ),
              ),
            );
          }
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
