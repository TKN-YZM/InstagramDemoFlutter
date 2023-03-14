import 'package:flutter_application_1/commanusage/commonfunc.dart';
import 'package:flutter_application_1/userclass/shareclass.dart';
import "package:flutter/material.dart";
import '../../firebase/allfirebase.dart';


class OutherUserProfile extends StatefulWidget {
  final OutherUserClass outherUser;
  final UserClass myUser;
  String genelOzellik;
  OutherUserProfile ({required this.myUser ,required this.outherUser,required this.genelOzellik,super.key});

  @override
  State<OutherUserProfile > createState() => _OutherUserProfile();
}

class _OutherUserProfile  extends State<OutherUserProfile > {
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
            Expanded(flex: 3,child: Padding( //Kullanici adi
              padding: const EdgeInsets.only(top: 14),
              child: Text(widget.outherUser.kullaniciAdi,style: const TextStyle(fontSize: 20),),
            )),
            const Expanded(flex: 1,child: Padding( //Zil
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(Icons.notifications_none,size: 27),
            ),),
            const Expanded(flex: 0,child: Padding( //Menu icon
              padding: EdgeInsets.only(bottom: 2),
              child: Icon(Icons.more_vert,size: 27,),
            ),),
          ],
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(  //Üst Kısım gönderi takipçi takip  
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                    InkWell(
                      onLongPress: (){_message(context);},
                      child: FutureBuilder(
                        future: DataBase().takeUserPhoto(widget.outherUser.ID),
                        builder: (context, snapshot) {                     
                          try{
                            if(snapshot.data=="" || snapshot.data==null){
                            return Container(height: 75,width: 75,
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: const DecorationImage(image: AssetImage("assets/aperson.png"),fit: BoxFit.cover))
                            );
                          }
                          else{
                            return InkWell(
                              child: Container(height: 75,width: 75,
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  image: DecorationImage(image: NetworkImage(snapshot.data!),fit: BoxFit.cover))
                              ),
                            );
                          }
                          }
                          catch(e){
                            return Container();
                          }                     
                        },
                      )
                    ),
                    Expanded(child: Container(child: textColumn("   3","    Gönderi",() {})),flex: 2,), //gonderi takipçi ve takip yazıları ve metotları
                    Expanded(child: Container(child: textColumn("468","Takipçi",() {})),flex: 1,),
                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          textColumn("538","Takip",() {})
                        ],
                      )),
                    ),
                    ],
                  ),
                ),
                Padding( //Açıklama kısmı PAÜ YBS
                  padding: const EdgeInsets.only(left: 21),
                  child: Container(height: 65,width: size.width-300,child: Text(widget.outherUser.kullaniciGenelAdi+"\n"+widget.genelOzellik,style: TextStyle(fontWeight: FontWeight.w400),),),
                ),
                const SizedBox(height: 10),
                profilbutton(size, context), //profil düzenleme ve - buttonu
                Padding( //butonun altındaki paylaşılan hikayeleren 
                  padding: const EdgeInsets.only(left: 20,right: 10),
                  child: Row(children: [CirclePicture("assets/bluemodel.jpg",name: "MyFoto"),CirclePicture("assets/batim1.png",name: "SunRise"),CirclePicture("assets/me.png",name: "ItsMe")]),
                ),
                const SizedBox(height: 5,),
                Row( //2 icon kare ve add person
                  children: [
                    Expanded(child: Center(child: IconButton(icon:Icon(Icons.border_all_sharp),onPressed: () {
                    },)),flex: 2,),
                    Expanded(
                      flex: 2,
                      child: Center(child: IconButton(icon: const Icon(Icons.person_add_outlined),
                    onPressed: () {
                    },)),),
                  ],
                ), 
                Container(
                height: size.height,
                child: ListView(
                  primary: false,
                  children: [
                    FutureBuilder(
                    future: DataBase().takeUserAllPhoto(widget.outherUser.ID),
                    builder: ((context, snapshot) {
                     try{
                       if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                        if(snapshot.data!.isEmpty){
                          return Container();
                        }
                        else{
                         debugPrint("*----------------------");
                         debugPrint(snapshot.data!.length.toString());
                           debugPrint(snapshot.data!.toString());
                          return  _paylasimKontrol((snapshot.data!),size);
                        }
                      }
                      else{
                      return Container(
                        height: size.height-500,
                        width: size.width-110,
                        child: const CircularProgressIndicator(color: Colors.black,),
                      );
                      }
                     }
                     catch(e){
                      return Container();
                     }
                    }
                    )
                    )
                  ],
                )
                )
              ],
            ),
          ],
        ),
      );
    
  }

  Widget _paylasimKontrol(List data,size){
     debugPrint(data.length.toString());
     switch(data.length){ 
      case 1:return karePicture(size,data[0] , "", ""); 
      case 2:return karePicture(size,data[0] , data[1], "");
      case 3:return karePicture(size, data[0], data[1], data[2]);
      case 4:return  Column(children: [karePicture(size, data[3], data[2], data[1]),karePicture(size, data[0],"", "")],);
      case 5:return Column(children: [karePicture(size, data[4], data[3], data[2]),karePicture(size, data[1],data[0], "")],);    
      case 6:return Column(children: [karePicture(size, data[5], data[4], data[3]),karePicture(size, data[2],data[1], data[0])],);
      case 7:return Column(children: [karePicture(size, data[6], data[5], data[4]),karePicture(size, data[3],data[2], data[1]),karePicture(size, data[0], "", "")],);
      case 7:return Column(children: [karePicture(size, data[7], data[6], data[5]),karePicture(size, data[4],data[3], data[2]),karePicture(size, data[1], data[0], "")],);
      case 8:return Column(children: [karePicture(size, data[8], data[7], data[6]),karePicture(size, data[5],data[4], data[3]),karePicture(size, data[2], data[1], data[0])],);
      case 9:return Column(children: [karePicture(size, data[9], data[8], data[7]),karePicture(size, data[6],data[5], data[4]),karePicture(size, data[3], data[2], data[1]),karePicture(size, data[0], "", "")],);
      case 10:return Column(children: [karePicture(size, data[10], data[9], data[8]),karePicture(size, data[7],data[6], data[5]),karePicture(size, data[4], data[3], data[2]),karePicture(size, data[1], data[0], "")],);
      case 11:return Column(children: [karePicture(size, data[11], data[10], data[9]),karePicture(size, data[8],data[7], data[6]),karePicture(size, data[5], data[4], data[3]),karePicture(size, data[2], data[1], data[0])],);

      default:return const Center(child: Text("Paylasim Yap",style: TextStyle(fontSize:18),));
     }

  }

  Row profilbutton(Size size, BuildContext context) {
    return Row( //profili düzenle buton
          children: [
            Expanded(//Takip button
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,

                ),    
                onPressed: () {
                },
                child: const Text("Takip"),
            ),
              )),
            Expanded( //Mesaj button
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                ),  
                onPressed: () {
                },
                child: const Text("Mesaj"),
            ),
              )),
            const Expanded( //add person icon
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: 12,top: 10,left: 5),
                child: Material(
                  color: Colors.white,
                  elevation: 1,
                  child: InkWell(child: Icon(Icons.person_add_alt_outlined)),
                )
              )),
          ],
      );
  }

  Column textColumn(String topText,String bottomText,Function()? onTap) { 
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(child: Text(topText,style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 20),),
        onTap: onTap,
        ),
        InkWell(child: Text(bottomText,style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 16)),
        onTap: onTap,)
        ],
    );
  }

  _message(context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20)
        )
      ),
      isScrollControlled: true,
      context: context, builder: ((context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) => SingleChildScrollView(
          //controller: scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
             
            ],
          ),
        ));
  }));
}
  
  Column photoandgallery(Icon icon,String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Text(text,style: const TextStyle(fontSize: 18), )
      ],
    );
  }
}




