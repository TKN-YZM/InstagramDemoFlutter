import 'package:flutter_application_1/commanusage/commonfunc.dart';
import 'package:flutter_application_1/firebase/allfirebase.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/userclass/shareclass.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class SharePage extends StatefulWidget {
  final UserClass myUser;
  final File imgPath;
  const SharePage({required this.myUser,required this.imgPath,super.key});
  @override
  State<SharePage> createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 30),
        backgroundColor: Colors.white,
        elevation: 0,
        actions:  [
            const Expanded(flex: 1,child: SizedBox()),
            const Expanded(flex: 3,child: Padding( //Yeni Gönderi
              padding:  EdgeInsets.only(top: 14),
              child: Text("Yeni Gönderi",style: TextStyle(fontSize: 20),),
            )),
            Expanded(flex: 1,child: Padding( //Done
              padding: const EdgeInsets.only(bottom: 2),
              child: InkWell(onTap: (){
                DataBase().paylasimYap(widget.myUser.ID, widget.imgPath).then((value) => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyMainApp(myUser: widget.myUser,isNewPost: true,)))
                });
              },child: const Icon(Icons.done,size: 27,color: Colors.blue,)),
            ),),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height/10,width: size.width,
              child: TextField(
                decoration: InputDecoration(
                  label: const Text("Açıklama Yaz..."),
                  prefixIcon:  userPhotoBuilder(),
                  suffixIcon: Container(child: Image.file(widget.imgPath),height: 60,width: 60,)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: createTextField(size,"Konum Ekle"),
            ),
            createTextField(size, "Müzik Ekle"),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: createSwitchList(size,"Facebook'ta Paylaş"),),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: createSwitchList(size, "Tweeter uygulamasında paylaş"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: createSwitchList(size, "Tumblr uygulamasında paylaş"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                children: const[
                  Expanded(flex: 3,child: Padding(
                    padding: EdgeInsets.only(left: 7),
                    child: Text("Gelişmiş Ayarlar",style: TextStyle(fontSize: 17),),
                  )),
                  Expanded(flex: 1,child: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder<Object?> userPhotoBuilder() {
    return FutureBuilder(
      future: DataBase().takeUserPhoto(widget.myUser.ID),
      builder: (context, snapshot) {
         return circlePictureNetwork(snapshot.data.toString(),height: 50,widht: 50);
    },);
  }

  Container createSwitchList(Size size,String metin) {
    return Container(
      height: size.height/10,width: size.width-10,
      child: Row(
        children: [
          Expanded(flex: 2,child: Text(metin,style: const TextStyle(color: Colors.black,fontSize: 17),)),
          Expanded(flex: 1,child: SwitchListTile(value: false, onChanged: (value){}))
        ],
      )
    );
  }

  Container createTextField(Size size,String text) {
    return Container(
      height: size.height/10,width: size.width-10,
      child: TextField(
        decoration: InputDecoration(
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text,style: const TextStyle(fontSize: 17,color: Colors.black),),
          ),
         
        ),
      ),
    );
  }
}