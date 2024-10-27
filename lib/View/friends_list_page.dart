import 'package:flutter/material.dart';

import 'gift_list_page.dart';

class FriendsListPage extends StatefulWidget {
  const FriendsListPage({super.key});

  @override
  State<FriendsListPage> createState() => _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {

  List<String> names = ["Seif","Laurent","Tracy","Claire","Joe","Mark","Williams"];
  List<String> ProfilePicture = ["assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg"];
  List<String> events = ["event 1","event 1","event 2","event 4","No Upcoming Events","No Upcoming Events","event 10"];

  List<String> Selectednames = ["Seif","Laurent","Tracy","Claire","Joe","Mark","Williams"];
  List<String> SelectedProfilePicture = ["assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg","assets/stack-gift-boxes-icon-isolated.jpg"];
  List<String> Selectedevents = ["event 1","event 1","event 2","event 4","No Upcoming Events","No Upcoming Events","event 10"];

  TextEditingController searchController = TextEditingController();
  String searchValue = "";
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff617ddf),
        title: const Text("hedieaty"),
        leading: Image.asset("assets/stack-gift-boxes-icon-isolated.jpg"),
        actions: [
          IconButton(onPressed: (){

          },
              icon: const Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 275,
                    child:
                    TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.search),
                        hintText: "Search",
                      ),
                      onChanged: (var x)
                      {
                        setState(() {
                          searchValue = x;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(10.0) ,
                    child: ElevatedButton(
                      onPressed: ()
                      {
                        if(searchValue.isEmpty || searchValue == "")
                        {
                          Selectednames.removeRange(0, Selectednames.length);
                          Selectednames.addAll(names);
                          Selectedevents.removeRange(0, Selectedevents.length);
                          Selectedevents.addAll(events);
                          SelectedProfilePicture.removeRange(0, SelectedProfilePicture.length);
                          SelectedProfilePicture.addAll(ProfilePicture);
                        }
                        else
                        {
                          searchValue = searchValue.toLowerCase();
                          names.forEach((element) {
                            if(element.toLowerCase() == searchValue)
                            {
                              Selectednames.removeRange(0, Selectednames.length);
                              Selectednames.add(element);
                              index = names.indexOf(element);
                              Selectedevents.removeRange(0, Selectedevents.length);
                              Selectedevents.add(events[index]);
                              SelectedProfilePicture.removeRange(0, SelectedProfilePicture.length);
                              SelectedProfilePicture.add(ProfilePicture[index]);
                            }
                          });
                        }
                        setState(() {

                        });
                      }
                      , child: const Text("Search"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 500,
              child: ListView.separated(
                itemCount: Selectednames.length ,
                itemBuilder:(context,index){
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(SelectedProfilePicture[index]),
                    ),
                    title: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> GiftListPage()));
                      },
                      child:Text(Selectednames[index]),
                    ),
                    subtitle: Text(Selectedevents[index]),
                  );
                },
                separatorBuilder: (context,index){
                  return Divider();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
