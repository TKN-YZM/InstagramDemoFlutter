import 'package:flutter_application_1/commanusage/commonfunc.dart';
import 'package:flutter_application_1/userclass/shareclass.dart';
import 'package:flutter_application_1/firebase/allfirebase.dart';
import 'package:flutter_application_1/main.dart';
import "package:flutter/material.dart";
import 'package:palette_generator/palette_generator.dart';

class HistoryPicturePage extends StatefulWidget {
  final String imagePath;
  final UserClass myUser;
  const HistoryPicturePage({required this.myUser,required this.imagePath,super.key});
  @override
  State<HistoryPicturePage> createState() => _HistoryPicturePageState();
}

class _HistoryPicturePageState extends State<HistoryPicturePage> {
  int sayi=0;
  late PageController controller;
  late PaletteGenerator generator;
  Color arkaplan_rengi=Colors.white30;
  @override
  void initState() {
    super.initState();
    controller=PageController(initialPage: 2);
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: arkaplan_rengi,
      body: Hero(
        tag: "1",
        child: PageView(
          onPageChanged: (value) {
           debugPrint(value.toString());
           if(value==1){
            ColorState("assets/batim1.png");
           }
           else if(value==0){
            ColorState("assets/blue.jpg");
           }
           else {
            ColorState("assets/model3.jpg");
           }
          },
         reverse: true,
         allowImplicitScrolling: true,
          controller: controller,
          children: [  
            columnState(context,"assets/blue.jpg","tuna_bol",flag: true,pictureflag: true,picturePath: "assets/bluemodel.jpg"),
            columnState(context,"assets/modelgrid1.jpg","mr_robo",flag: true,pictureflag: true,picturePath: "assets/modelgrid1.jpg"),
            columnState(context,widget.imagePath,widget.myUser.kullaniciAdi),
          ],
        )
      ),
    );
  }

  SingleChildScrollView columnState(BuildContext context,String imgPath,String userName,{bool flag=false,bool pictureflag=false,String picturePath="assets/model1.jpg"}) {
    return SingleChildScrollView(
      child: Column(
        children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
              child: flag==false? _futureBuilder(widget.myUser.ID):myHistory(picturePath),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyMainApp(myUser: widget.myUser)));
              },),
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
        Container(
        height: 460,//size.height,
        width: 410,//size.width,
        decoration: BoxDecoration(
        image: pictureflag==false?
         DecorationImage(
          image: NetworkImage(widget.imagePath),fit: BoxFit.cover
        ):
         DecorationImage(
          image: AssetImage(imgPath),fit: BoxFit.cover
        )
        ),
      ),
        Container(
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
              const Expanded(flex: 1,child: Icon(Icons.north_east,color: Colors.white54,)),
            ],
          ),
        ),
      )
        ],
      ),
    );
  }

  FutureBuilder<Object?> _futureBuilder(String userID) {
    return FutureBuilder(
      future: DataBase().takeUserPhoto(userID),
      builder: ((context, snapshot) {
      if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
        return CirclePictureNetwork(snapshot.data.toString(),height: 50,widht: 50);
      }
      else{
      return Container();
      }
    }));
  }

  Widget myHistory(String imgPath){
    return CirclePicture(imgPath,height: 50,widht: 50);
    //CirclePictureNetwork(snapshot.data.toString(),height: 50,widht: 50);
  }

  void ColorState(String imgPath) async{
    generator=await PaletteGenerator.fromImageProvider(AssetImage(imgPath));
    arkaplan_rengi=generator.dominantColor!.color;
    setState(() {
      print(arkaplan_rengi);
    });
  }
  // Color(0xff646464) ,Color(0xffaab4b1)
}