import 'package:flutter_application_1/commanusage/commonfunc.dart';
import 'package:flutter_application_1/firebase/allfirebase.dart';
import 'package:flutter_application_1/userclass/shareclass.dart';
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
                  Expanded(flex: 2,child: Container(child: textColumn("   2","    Gönderi",() {}))), //gonderi takipçi ve takip yazıları ve metotları
                  Expanded(flex: 1,child: Container(child: textColumn("226","Takipçi",() {}))),
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
                child: circlePicture("assets/modelgrid1.jpg",),
              ),
              Row( //2 icon kare ve add person
                children: [
                  Expanded(flex: 2,child: Center(child: IconButton(icon: const Icon(Icons.border_all_sharp),onPressed: () {
                  },)),),
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
                        return _paylasimKontrol((snapshot.data!),size);
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
      case 8:return Column(children: [karePicture(size, data[7], data[6], data[5]),karePicture(size, data[4],data[3], data[2]),karePicture(size, data[1], data[0], "")],);
      case 9:return Column(children: [karePicture(size, data[8], data[7], data[6]),karePicture(size, data[5],data[4], data[3]),karePicture(size, data[2], data[1], data[0])],);
      case 10:return Column(children: [karePicture(size, data[9], data[8], data[7]),karePicture(size, data[6],data[5], data[4]),karePicture(size, data[3], data[2], data[1]),karePicture(size, data[0], "", "")],);
      case 11:return Column(children: [karePicture(size, data[10], data[9], data[8]),karePicture(size, data[7],data[6], data[5]),karePicture(size, data[4], data[3], data[2]),karePicture(size, data[1], data[0], "")],);
      case 12:return Column(children: [karePicture(size, data[11], data[10], data[9]),karePicture(size, data[8],data[7], data[6]),karePicture(size, data[5], data[4], data[3]),karePicture(size, data[2], data[1], data[0])],);
      case 13:return Column(children: [karePicture(size, data[12], data[11], data[10]),karePicture(size, data[9],data[8], data[7]),karePicture(size, data[6], data[5], data[4]),karePicture(size, data[3], data[2], data[1]),karePicture(size, "", "", "")],);

      default:return const Center(child: Text("Paylasim Yap",style: TextStyle(fontSize:18),));
     }

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
        return  FractionallySizedBox(
        heightFactor: 0.3,
        child: Column(
          children: [
            Row( //--- çizgisi
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 3,
                    width: 40,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            Expanded(//galeri icon
              child: Card( //gönderi ekle
                elevation: 0,
                child: ListTile(
                  title: const Text("Yeni Profil Resmi"),
                  leading: const Icon(Icons.rule_folder_outlined),
                  onTap: () {
                    Navigator.pop(context);
                    camandgalery(context);
                  },
                ),
              ),
            ),
            Expanded(//facebook icon
              child: Card( //reels videosu ekle
                elevation: 0,
                child: ListTile(
                  title: const Text("Facebook'tan Aktar"),
                  leading: const Icon(Icons.facebook),
                  onTap: () {
                    camandgalery(context);
                  },
                ),
              ),
            ),
            Expanded(//Çöp Kovası
              child: Card( //canlı yayın
                elevation: 0,
                child: ListTile(
                  onTap: () {
                    DataBase().preofilResmiGaleriKamera(widget.myUser.ID,galeriMi: false);
                  },
                  title: const Text("Mevcut Resmi Kaldır",style: TextStyle(color: Colors.red),),
                  leading: const Icon(Icons.delete,color: Colors.red,),
                ),
              ),
            ),
          ],
        ),
    );}));   
  }

  camandgalery(context){
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20)
        )
      ),
      isScrollControlled: true,
      context: context, builder: ((context) {
        return  FractionallySizedBox(
        heightFactor: 0.3,
        child: Container(
        height: 220,
        child: Column( //kamera ve ---- yapısı
          children: [
            Padding( //üstteki --- 
              padding: const EdgeInsets.all(8.0),
              child: Container(height: 3,width: 40,color: Colors.black,),
            ),
            Padding( //kamera ve galeri
              padding: const EdgeInsets.only(top: 70),
              child: Row( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                  flex: 1,
                  child: 
                  InkWell(child: photoandgallery(const Icon(Icons.camera_enhance),"Kamera"),
                  onTap: () {
                    debugPrint("Kamera açılıyor");
                    DataBase().preofilResmiGaleriKamera(widget.myUser.ID,galeriMi: false);
                    Navigator.pop(context);
                  },
                  ),),
                  Expanded(
                  flex: 1,
                  child: InkWell(child: photoandgallery(const Icon(Icons.photo),"Galeri"),
                  onTap: () {
                    debugPrint("-------------------------");
                    debugPrint("Galeriyi açıyoruz");
                     DataBase().preofilResmiGaleriKamera(widget.myUser.ID,galeriMi: true);
                       Navigator.pop(context);
                  },
                  ))  
                ],
              ),
            )
          ],
        ),
      ),
      );
      }),
    );
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




