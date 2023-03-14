import 'package:flutter_application_1/toppages/chatpage.dart';
import 'package:flutter_application_1/commanusage/commonfunc.dart';
import "package:flutter/material.dart";
import 'package:flutter_application_1/userclass/shareclass.dart';

class MessagePage extends StatefulWidget {
  final UserClass myUser;
  const MessagePage({required this.myUser,super.key});
  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Expanded(
            flex: 1,
            child: InkWell(child: const Icon(Icons.arrow_back,color: Colors.black,size: 25,),
            onTap: () {
              Navigator.pop(context);
            },
            ),
          ),
          const Expanded(flex: 4,child: Padding(
            padding:  EdgeInsets.only(top: 15),
            child: Text("abdullah_balcn ",style: TextStyle(fontSize: 21,color: Colors.black),),
          )),
          const Expanded(flex: 1,child: Icon(Icons.video_call_sharp,color: Colors.black,size: 30,)),
          const Expanded(flex: 1,child: Icon(Icons.add,color: Colors.black,size: 30,)),   
        ],
      ),
      body:  MainStructure(myUser: widget.myUser),
    );
  }
}

class MainStructure extends StatefulWidget {
  final UserClass myUser;
  const MainStructure({required this.myUser,super.key});
  @override
  State<MainStructure> createState() => _MainStructureState();
}

class _MainStructureState extends State<MainStructure> {
  @override
  Widget build(BuildContext context) {
    return  ListView(
      primary: true,
      children: [
        Column(
          children: [
            Padding( // search 
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 40,
                width: 380,
                child: TextField(
                  decoration: InputDecoration(
                    label: const Text("Ara"),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    prefixIcon: const Icon(Icons.search,color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                )
              ),
            ),
            Row( //aktif kullanıcılar
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: _aktifKullanici("assets/model1.jpg", "mr_Atl"),
                ),
                 Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: _aktifKullanici("assets/model3.jpg", "mr_Bob"),
                )
              ],
            ),
            Row( //mesajlar istekler
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text("Mesajlar",style: TextStyle(fontSize: 15),),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(child: const Text("İstekler"),onPressed: () {
                  },),
                )
                ],),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: ListView.builder(
                primary: false,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(myUser: widget.myUser))),
                    child: Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ListTile(
                          title: Text("Konuşmaci $index"),
                          leading: const Icon(Icons.person),
                          trailing: const Icon(Icons.camera_alt_outlined,size: 30,),
                        ),
                      ),
                    ),
                  );
              },),
            )
          ],
        ),
      ],
    );
  }

  Widget _aktifKullanici(String imgPath,String name){
    return Row(
      children: [
         Stack(
          children: [
          circlePicture(imgPath,name: name),
          Positioned(
            top: 60,
            left: 60,
            child: Container(height: 18,width: 17,
             decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: const DecorationImage(image: AssetImage("assets/green.jpg"),fit: BoxFit.cover)
              ),))
          ],
         )
      ],
    );
  }
}