import 'package:flutter_application_1/commanusage/commonfunc.dart';
import 'package:flutter_application_1/firebase/allfirebase.dart';
import 'package:flutter_application_1/userclass/shareclass.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import "package:flutter/material.dart";
import 'profduzenle.dart';



class MyProfile extends StatefulWidget {
  final UserClass myUser;
  String genelOzellik;
  MyProfile({required this.myUser,required this.genelOzellik,super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
      return ListView(
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
                      future: DataBase().takeUserPhoto(widget.myUser.ID),
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
                  Expanded(child: Container(child: textColumn("   2","    Gönderi",() {})),flex: 2,), //gonderi takipçi ve takip yazıları ve metotları
                  Expanded(child: Container(child: textColumn("226","Takipçi",() {})),flex: 1,),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        textColumn("227","Takip",() {})
                      ],
                    )),
                  ),
                  ],
                ),
              ),
              Padding( //Açıklama kısmı PAÜ YBS
                padding: const EdgeInsets.only(left: 21),
                child: Container(height: 65,width: size.width-300,child: Text(widget.myUser.kullaniciGenelAdi+"\n"+widget.genelOzellik),),
              ),
              const SizedBox(height: 10),
              profilbutton(size, context), //profil düzenleme ve - buttonu
              Padding( //butonun altındaki paylaşılan hikayeleren 
                padding: const EdgeInsets.only(left: 20,right: 10),
                child: CirclePicture("assets/modelgrid1.jpg",),
              ),
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
                  future: DataBase().takeUserAllPhoto(widget.myUser.ID),
                  builder: ((context, snapshot) {
                   try{
                     if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                      if(snapshot.data!.isEmpty){
                        return Container();
                      }
                      else{
                        return karePicture(size,snapshot.data![0],snapshot.data![1],snapshot.data![2]);
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
      );
  }

  Row profilbutton(Size size, BuildContext context) {
    return Row( //profili düzenle buton
          children: [
          Padding(
               padding: const EdgeInsets.only(left: 10),
               child: Container(
            width: size.width/1.13,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25)
            ),
            child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfiDuzenle(myUser: widget.myUser,))).then((value) {
                  if (value==null){
                  }
                  else{
                    setState(() {
                    widget.genelOzellik=value[0];
                    widget.myUser.kullaniciAdi=value[1];
                    widget.myUser.kullaniciGenelAdi=value[2];  
                  });
                  }
                },
              );
           }, 
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade100
            ),
            child: const Text("Profli Düzenle",textAlign: TextAlign.center,style: TextStyle(color: Colors.black),)),
          ),
             ),
          Padding( //+ butonu
            padding: const EdgeInsets.only(left: 8),
            child: Container(
              height: 38,
              width: size.width/15,
              color: Colors.grey.shade100,
              child:  ElevatedButton(onPressed: (){}, 
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade100
              ),
              child: const Text("+",style: TextStyle(color: Colors.black),),
                ),
              ),
            )
          ],
         );
  }

  Column textColumn(String topText,String bottomText,Function()? onTap) { 
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(child: Text(topText,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
        onTap: onTap,
        ),
        InkWell(child: Text(bottomText,style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 16)),
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




