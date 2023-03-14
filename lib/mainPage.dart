import 'package:flutter_application_1/sharepost.dart';
import 'commanusage/commonfunc.dart';
import 'package:flutter/material.dart';
import 'firebase/allfirebase.dart';
import 'history.dart';
import 'userclass/shareclass.dart';


class MainStructurePage extends StatefulWidget {
  final UserClass myUser;
  bool isNewPost;
  MainStructurePage({required this.myUser,this.isNewPost=false,super.key});
  @override
  State<MainStructurePage> createState() => _MainStructureState();
}

class _MainStructureState extends State<MainStructurePage> {
  @override
  Widget build(BuildContext context) {
   return ListView(
      children: [
        Container(
          height: 130,
          width: MediaQuery.of(context).size.width-50/2,
          child: ListView( 
            scrollDirection: Axis.horizontal,
            children: [ 
              Padding( //kulanicinin hikayesi
                padding: const EdgeInsets.only(top: 2),
                child: hikayeCard(widget.myUser.ID,thisMainUser: true),
              ),
              _tumArkadasHikayeleri(), 
              _botHesaplar(context,"assets/model1.jpg","mr_robo","Mr Robot","Youtuber,Youtube: Teknoloji ve Yazılım"),
              _botHesaplar(context,"assets/bluemodel.jpg","tuna_bal","Mr Balcan","Merhaba,ben bir öğrenciyim"),
              _botHesaplar(context, "assets/model3.jpg","mr_shel", "MR Shell", "Udemy: Abdullah Balcan"),
              _botHesaplar(context, "assets/model4.jpg","gi_comb", "Mr Kor", "Insta: fantastikYazilim,fallow me"),
              _botHesaplar(context, "assets/model2.jpg","mr_nobdy", "Mr Nobdy", "Insta: abdullah_balcn,fallow me!"),
            ],
          ),
        ),
       
        widget.isNewPost==true? _mainUserPosts():Postshare(myuserClass: OutherUserClass("1","tuna_bal","aaaa","bbbb"),imgPath: "assets/me.png",circilePath: "assets/bluemodel.jpg",networkControl: false),
        Postshare(myuserClass: OutherUserClass("1","ren_san","aaaa","bbbb"),imgPath: "assets/comedie.jpg",circilePath: "assets/model1.jpg",networkControl: false),
        Postshare(myuserClass: OutherUserClass("1","ab_balcn","aaaa","bbbb"),imgPath: "assets/model3.jpg",circilePath: 
        "assets/model2.jpg",networkControl: false),
        Postshare(myuserClass: OutherUserClass("1","atilla_tkrs","aaaa","bbbb"),imgPath: "assets/bluemodel.jpg",circilePath: "assets/model4.jpg",networkControl: false),
      ],
    );
  }

  InkWell _botHesaplar(BuildContext context,String userimgPath,String userName,String kullaniciGenelAdi,String genelOzellik,) {
    return InkWell(child: circlePicture(userimgPath,name: userName,),
        onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => HistoryPicturePage(myUser: widget.myUser,outherUser: OutherUserClass("X",userName,kullaniciGenelAdi,genelOzellik),imagePath: userimgPath,networkControl: false,thisMainUser: false,))),
   );
  }

  FutureBuilder<List<dynamic>> _tumArkadasHikayeleri() {
    return FutureBuilder(
        future: DataBase().usersID(widget.myUser.ID),
        builder: ((context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
          if(snapshot.data!.isEmpty==true || snapshot.data==null){
            return circlePicture("",name: "");
          }
          else{
            int sayi=snapshot.data!.length;
            return  Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Row(
                children: [
                     for(int i = 0; i < sayi; i++) ...[
                          hikayeCard(snapshot.data![i]) 
                     ]
                ],
              ),
            );
          }
        }
        else {
          return circlePicture("",name: "mr_nobdy");
        }
      }));
  }

  FutureBuilder<String> hikayeCard(String id,{bool thisMainUser=false}) {
    return FutureBuilder(
        future: DataBase().takeUserPhoto(id),
        builder: ((context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
            if(snapshot.data=="" || snapshot.data==null){
              return InkWell(
                child: circlePicture("",name: "-",hikayeKontrol: true),
                onLongPress: () => _message(context),
                onTap: () => _message(context),
                );
            }
            else{
                return _futureYapi(snapshot.data!,id,thisMainUser: thisMainUser);
            }
        }
        else{
        return Container(height: 5,width: 5,child: const CircularProgressIndicator(),);
        }
      }));
  }

  FutureBuilder<String> _futureYapi(String imgPath,String id,{bool thisMainUser=false}) {
    return FutureBuilder(
      future: DataBase().takeUserHistoryPersonal(id),
      builder: ((context, snapshot) {
      if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
          if(snapshot.data=="" || snapshot.data==null){
            return InkWell(child: circlePictureNetwork(imgPath,name: "noname"),
              onLongPress: () => _message(context),
              onTap: () => _message(context),
              );
          }
          else{
            return _userBuilder(id,imgPath,snapshot.data!,thisMainUser: thisMainUser);
        }
      }
      else{
      return const SizedBox();
      }
    }));
  }
 
  FutureBuilder<UserClass> _userBuilder(String id,String imgPath,String imgPathHistory,{bool thisMainUser=false}){
    return FutureBuilder(
      future: DataBase().kullaniciOzellik(id),
      builder: ((context, snapshot) {
      if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
          if(snapshot.data=="" || snapshot.data==null){
            return InkWell(child: circlePictureNetwork(imgPath,name: "noname"),
              onLongPress: () => _message(context),
              onTap: () => _message(context),
              );
          }
          else{
            return Hero(
            tag: UniqueKey(),
            child: InkWell(child: circlePictureNetwork(imgPath,name: thisMainUser==false? snapshot.data!.kullaniciAdi: "hikayen"),
            onLongPress: () => _message(context),
            onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => HistoryPicturePage(myUser: widget.myUser,outherUser: OutherUserClass(snapshot.data!.ID,snapshot.data!.kullaniciAdi,snapshot.data!.kullaniciGenelAdi,snapshot.data!.genelOzellik),imagePath: imgPathHistory,networkControl: true,thisMainUser: thisMainUser,))),),
          );
        }
      }
      else{
      return const CircularProgressIndicator();
      }
    }));
  }

  _message(context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(27)
        )
      ),
      isScrollControlled: true,
      context: context, builder: ((context) {
        return  FractionallySizedBox(
        heightFactor: 0.24,
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
                  title: const Text("Hikayene Ekleme Yap"),
                  leading: const Icon(Icons.rule_folder_outlined),
                  onTap: () {
                    Navigator.pop(context);
                    _camandgalery(context);
                  },
                ),
              ),
            ),
            Expanded(//facebook icon
              child: Card( //reels videosu ekle
                elevation: 0,
                child: ListTile(
                  title: const Text("Yakın Arkadaş Listeni Düzenle"),
                  leading: const Icon(Icons.movie_outlined),
                  onTap: () {
                    _camandgalery(context);
                  },
                ),
              ),
            ),
          
          ],
        ),
    );}));   
  }

  _camandgalery(context){
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(27)
        )
      ),
      isScrollControlled: true,
      context: context, builder: ((context) {
        return  FractionallySizedBox(
        heightFactor: 0.24,
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
                  InkWell(child: _photoandgallery(const Icon(Icons.camera_enhance),"Kamera"),
                  onTap: () {
                    debugPrint("Kamera açılıyor");
                    DataBase().historySave(widget.myUser.ID,galeriMi: false);
                    Navigator.pop(context);
                  },
                  ),),
                  Expanded(
                  flex: 1,
                  child: InkWell(child: _photoandgallery(const Icon(Icons.photo),"Galeri"),
                  onTap: () {
                    debugPrint("-------------------------");
                    debugPrint("Galeriyi açıyoruz");
                    DataBase().historySave(widget.myUser.ID,galeriMi: false);
                    
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

  Column _photoandgallery(Icon icon,String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Text(text,style: const TextStyle(fontSize: 18), )
      ],
    );
  }

  FutureBuilder _mainUserPosts(){
    return FutureBuilder(
    future: DataBase().takeUserAllPhoto(widget.myUser.ID),
    builder: ((context, snapshot) {
      try{
        if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
        if(snapshot.data!.isEmpty){
          return Container();
        }
        else{
          int uzunluk=snapshot.data.length;
          return _futureHistoryCircle(snapshot.data[uzunluk-1]);
        }
      }
      else{
         return Container();
      }
      }
      catch(e){
      return Container();
      }
    }
    )
    );
  }

  FutureBuilder<String> _futureHistoryCircle(String picturePath) {
    return FutureBuilder(
        future: DataBase().takeUserPhoto(widget.myUser.ID),
        builder: ((context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
            if(snapshot.hasData!=""){
              return Postshare(imgPath: picturePath, myuserClass: OutherUserClass(widget.myUser.ID,widget.myUser.kullaniciAdi,widget.myUser.kullaniciGenelAdi,widget.myUser.genelOzellik), circilePath: snapshot.data.toString(),networkControl: true,);
            }
            else{
              return SizedBox();
            }
          }
          else{
            return SizedBox();
          }
      }));
  }

}