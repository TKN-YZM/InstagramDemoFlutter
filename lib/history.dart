import 'package:flutter_application_1/commanusage/commonfunc.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/navigatiorbarstate/profile/userprofile.dart';
import 'package:flutter_application_1/userclass/shareclass.dart';
import 'package:flutter_application_1/firebase/allfirebase.dart';
import "package:flutter/material.dart";
import 'package:palette_generator/palette_generator.dart';

class HistoryPicturePage extends StatefulWidget {
  final String imagePath;
  final UserClass myUser;
  final OutherUserClass outherUser;
  final bool networkControl;
  final bool thisMainUser;
  const HistoryPicturePage({required this.myUser,required this.outherUser,required this.imagePath,required this.networkControl,super.key,required this.thisMainUser});
  @override
  State<HistoryPicturePage> createState() => _HistoryPicturePageState();
}

class _HistoryPicturePageState extends State<HistoryPicturePage> {
  int sayi=0;
  late PageController controller;
  late PaletteGenerator generator;
  Color arkaplanRengi=Colors.white30;
  @override
  void initState() {
    super.initState();
    controller=PageController(initialPage: 2);
    colorState(widget.imagePath,flagState: widget.networkControl);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: arkaplanRengi,
      body: Hero(
        tag: "",
        child: PageView(
         onPageChanged: (value) {          
          },
         reverse: true,
         allowImplicitScrolling: true,
          controller: controller,
          children: [  
            columnState(context,widget.imagePath,widget.outherUser.kullaniciAdi,() => goProfile(widget.outherUser),pictureflag: widget.networkControl,flag: widget.networkControl),
          ],
        )
      ),
    );
  }

  Widget columnState(BuildContext context,String imgPath,String userName,Function() onTap,{bool flag=true,bool pictureflag=true}) {
    return SingleChildScrollView(
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyMainApp(myUser: widget.myUser))),
        child: Column(
          children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell( //user picture
                child: flag==true? _futureBuilder(widget.outherUser.ID):myHistory(imgPath),
                onTap: onTap,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40,right: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Container(
                      height: 17,
                      width: 100,
                      child: Text(userName,style: const TextStyle(fontSize: 15,color: Colors.white),),
                    ),
                    const Padding(
                      padding:  EdgeInsets.only(right: 46),
                      child: Text("22 dakika",style: TextStyle(color: Colors.white,fontSize: 13),),
                    )
                    ],
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.only(left: 155,bottom: 20),
                  child: Icon(Icons.more_vert,color: Colors.white,),
                )
              ],
            ),
          ),
          Container( //ana resim
          height: 460,//size.height,
          width: 410,//size.width,
          decoration: BoxDecoration(
          image: pictureflag==true?
           DecorationImage(
            image: NetworkImage(widget.imagePath),fit: BoxFit.cover
          ):
           DecorationImage(
            image: AssetImage(imgPath),fit: BoxFit.cover
          )
          ),
              ),
          Container( //resmin altındaki textbox favori icon 
            height: 90,
            color: Colors.black,
            child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              children:  [
                Expanded(flex: 5,child: Padding(
                  padding: const EdgeInsets.only(left: 24,top: 10,bottom: 14),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(width: 2, color: Colors.white54), //<-- SEE HERE
                        ),
                      ), 
                    ),
                  ),
                ),
                const Expanded(flex: 1,child: Icon(Icons.favorite,color: Colors.white54,)),
                const Expanded(flex: 1,child: Icon(Icons.near_me_sharp,color: Colors.white54,)),
              ],
            ),
          ),
        )
          ],
        ),
      ),
    );
  }

  FutureBuilder<Object?> _futureBuilder(String userID) {
    return FutureBuilder(
      future: DataBase().takeUserPhoto(userID),
      builder: ((context, snapshot) {
      if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
        return circlePictureNetwork(snapshot.data.toString(),height: 50,widht: 50);
      }
      else{
      return Container();
      }
    }));
  }

  Widget myHistory(String imgPath){
    return circlePicture(imgPath,height: 50,widht: 50);
  }
  
  void goProfile(OutherUserClass outherUser,){
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget.thisMainUser==true? 
    MyMainApp(myUser: widget.myUser):
    OutherUserProfile(myUser: widget.myUser, outherUser: outherUser, genelOzellik: outherUser.genelOzellik,
    isFalseNetworkimgPath: widget.networkControl==false? widget.imagePath:"assets/model1.jpg",
    )
    
    ));
  }

  void colorState(String imgPath,{bool flagState=true}) async{
    generator=flagState==false? await PaletteGenerator.fromImageProvider(AssetImage(imgPath)): await PaletteGenerator.fromImageProvider(NetworkImage(imgPath));
    arkaplanRengi=generator.dominantColor!.color;
    setState(() {

    });
  }
}