
import 'package:flutter_application_1/pictureShow.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'commanusage/commonfunc.dart';
import 'package:flutter/material.dart';
import 'firebase/allfirebase.dart';
import 'history.dart';
import 'sharepost.dart';
import 'userclass/shareclass.dart';


class MainStructurePage extends StatefulWidget {
  final UserClass myUser;
  const MainStructurePage({required this.myUser,super.key});
  @override
  State<MainStructurePage> createState() => _MainStructureState();
}

class _MainStructureState extends State<MainStructurePage> {
  List<String> myPhotoList=[];

  String userimgPath="";
  @override
  void initState() {
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
   return ListView(
      children: [
        Container(
          height: 130,
          width: MediaQuery.of(context).size.width-50/2,
          child: ListView( 
            scrollDirection: Axis.horizontal,
            children: [ 
              hikayeCard(widget.myUser.ID,widget.myUser.kullaniciAdi),
              FutureBuilder(
                future: DataBase().usersID(widget.myUser.ID),
                builder: ((context, snapshot) {
                if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
                  if(snapshot.hasData==""){
                    return CirclePicture("",name: "huğğğğ");
                  }
                  else{
                    debugPrint(snapshot.data![0].toString());
                    return hikayeCard(snapshot.data![0],"aaaaa");
                  }
                }
                else return CirclePicture("",name: "huğğğğ");
              })), 
              InkWell(
                child: CirclePicture("assets/modelgrid1.jpg",name: "mr.robo",)),
              CirclePicture("assets/bluemodel.jpg",name: "tuna_bal"),
              CirclePicture("assets/model3.jpg",name: "sinemm",), 
              CirclePicture("assets/model4.jpg",name: "Hikayen",),
              CirclePicture("assets/model2.jpg",name: "ecekilinc",),
              CirclePicture("assets/model3.jpg",name: "busekoc",), 
              CirclePicture("assets/modelgrid1.jpg",name: "aysetur",),
              CirclePicture("assets/modelgrid3.jpg",name: "simitci"), 
            ],
          ),
        ),
        Postshare(myuserClass: UserClass("1","tuna_bal","aaaa","bbbb"),imgPath: "assets/me.png",circilePath: "assets/bluemodel.jpg",onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  PicturePage(imgPath: "assets/me.png",myUser: widget.myUser,))),),
        Postshare(myuserClass: UserClass("1","ren_san","aaaa","bbbb"),imgPath: "assets/comedie.jpg",circilePath: "assets/model1.jpg",onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  PicturePage(imgPath: "assets/comedie.jpg",myUser: widget.myUser,)))),
        Postshare(myuserClass: UserClass("1","ab_balcn","aaaa","bbbb"),imgPath: "assets/model3.jpg",circilePath: 
        "assets/model2.jpg",onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>  PicturePage(imgPath: "assets/model3.jpg",myUser: widget.myUser,))),),
        Postshare(myuserClass: UserClass("1","atilla_tkrs","aaaa","bbbb"),imgPath: "assets/bluemodel.jpg",circilePath: "assets/model4.jpg",onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) =>  PicturePage(imgPath: "assets/bluemodel.jpg",myUser: widget.myUser,))),),
      ],
    );
  }

  FutureBuilder<String> hikayeCard(String id,String userName) {
    return FutureBuilder(
        future: DataBase().takeUserPhoto(id),
        builder: ((context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
            if(snapshot.data==""){
              return InkWell(
                child: CirclePicture("",name: userName,hikayeKontrol: true),
                onLongPress: () => _message(context),
                onTap: () => _message(context),
                );
            }
            else{
                return futureYapi(snapshot.data!,id);
            }
        }
        else{
        return const CircularProgressIndicator();
        }
      }));
  }

  FutureBuilder<String> futureYapi(String imgPath,String id) {
    return FutureBuilder(
      future: DataBase().takeUserHistoryPersonal(id),
      builder: ((context, snapshot) {
      if(snapshot.connectionState==ConnectionState.done && snapshot.hasData){
          if(snapshot.data=="" || snapshot.data==null){
            return InkWell(child: CirclePictureNetwork(imgPath,name: "Hikayen"),
              onLongPress: () => _message(context),
              onTap: () => _message(context),
              );
          }
          else{
            String ID="",isim="",userisim="",genelOzellik="";
            DataBase().kullaniciOzellik(id).then((value) => {
              ID=value.ID,
              isim=value.kullaniciAdi,
              userisim=value.kullaniciGenelAdi,
              genelOzellik=value.genelOzellik
            });
            return Hero(
            tag: UniqueKey(),
            child: InkWell(child: CirclePictureNetwork(imgPath,name: "Hikayen"),
            onLongPress: () => _message(context),
            onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => HistoryPicturePage(myUser: widget.myUser,outherUser: OutherUserClass(ID,isim,genelOzellik,genelOzellik),imagePath: snapshot.data!))),),
          );
        }
      }
      else{
      return const CircularProgressIndicator();
      }
    }));
  }

  _message(context) {
      showMaterialModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          color: Colors.white,
          height: 160,
          child: Column(
            children: [
              Row(
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
              Card(
                elevation: 0,
                child: ListTile(
                  title: const Text("Hikayene Ekleme Yap"),
                  //leading: const Icon(Icons.rule_folder_outlined),
                  onTap: () {
                    showMaterialModalBottomSheet( //galeri veya kamera seçeneği
                    context: context,
                    builder: (context) => SingleChildScrollView(
                    child: Container(
                      height: 160,
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
                                  DataBase().preofilResmiKamera(widget.myUser.ID);
                                },
                                ),),
                                Expanded(
                                flex: 1,
                                child: InkWell(child: photoandgallery(const Icon(Icons.photo),"Galeri"),
                                onTap: () {
                                  DataBase().profilResmiGaleri(widget.myUser.ID);
                                },
                                ))  
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ),
                  );
                  },
                ),
              ),
              const Card(
                elevation: 0,
                child: ListTile(
                  title: Text("Yakın Arkadaş Listeni Düzenle"),

                ),
              ),
            ],
          ),
        )
      ),
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