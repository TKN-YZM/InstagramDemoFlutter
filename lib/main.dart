import 'package:flutter_application_1/commanusage/GoEmpty.dart';
import 'package:flutter_application_1/firebase/allfirebase.dart';
import 'package:flutter_application_1/mainPage.dart';
import 'package:flutter_application_1/navigatiorbarstate/menu.dart';
import 'package:flutter_application_1/navigatiorbarstate/profile/profile.dart';
import 'package:flutter_application_1/toppages/message.dart';
import 'package:flutter_application_1/userclass/shareclass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:flutter/material.dart";
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'navigatiorbarstate/kesfet.dart';
import 'navigatiorbarstate/salepage.dart';
import 'providers/mainproviders.dart';



class MyMainApp extends StatelessWidget {
  UserClass myUser; 
  MyMainApp({required this.myUser,super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      debugShowCheckedModeBanner: false,
      title: "Instagram",
      home: topPage(myUser: myUser,),
    );
  }
}

class topPage extends StatefulWidget {
  UserClass myUser;
  topPage({required this.myUser,super.key});
  @override
  State<topPage> createState() => _topPageState();
}

class _topPageState extends State<topPage>{
  int _selectedIndex=0;
  int expandedStateCount=3;
  late  GoEmptyPage emptyPage; // myprofile
  late MainStructurePage mainPage; //tüm postlar
  late List allPage; //tüm bottom sayfalarını tutan liste
  late MyProfile myProfile; //profile sayfası
  late MenuSearch mySearch; //menü sayfa (keşfet)
  late SalePage salePage;
  late DiscoverPage discoverPage;
  @override
  void initState() {
    super.initState();
    myProfile=MyProfile(myUser: widget.myUser,genelOzellik: widget.myUser.genelOzellik,);
    emptyPage=const GoEmptyPage();
    mainPage=MainStructurePage(myUser: widget.myUser);
    mySearch=const MenuSearch();
    salePage=const SalePage();
    discoverPage=DiscoverPage(myUser: widget.myUser,);
    allPage=[mainPage,discoverPage,emptyPage,salePage,myProfile];
  }

  @override         
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Expanded(
            flex: expandedStateCount,
            child: Padding(
            padding: const  EdgeInsets.only(top: 10,left: 10),
            child: Consumer(builder: ((context, ref, child) {
              var deger= ref.watch(textInstaProvider);
              return deger;
            })),
          ),),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                _message(context);
              },
              child: Consumer(builder: ((context, ref, child) {
              return ref.watch(instaIconReels); 
            }))
            ),
          ),
          Expanded(flex: 0,child: InkWell(child: Consumer(builder: ((context, ref, child) {
              return ref.watch(instaIconFavorite); 
            }))
            ),),
          Expanded(
            flex: 1,
            child: 
            InkWell(child: Consumer(builder: ((context, ref, child) {
              return ref.watch(instaIconMessage); 
            })),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MessagePage()));
            },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
      body: Consumer(
        builder: (context, ref, child) {
          return allPage[ref.watch(navbarstate)];
        },
      )
    );
  }
 _message(context) {
   showMaterialModalBottomSheet(
  context: context,
  builder: (context) => SingleChildScrollView(
    controller: ModalScrollController.of(context),
    child: Container(
      color: Colors.white,
      height: 220,
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
          Card( //gönderi ekle
            elevation: 0,
            child: ListTile(
              title: const Text("Gönderi Ekle"),
              leading: const Icon(Icons.rule_folder_outlined),
              onTap: () {
                camandgalery(context);
              },
            ),
          ),
          Card( //reels videosu ekle
            elevation: 0,
            child: ListTile(
              title: const Text("Reels Videosu Ekle"),
              leading: const Icon(Icons.movie_filter_outlined),
              onTap: () {
                camandgalery(context);
              },
            ),
          ),
          Card( //canlı yayın
            elevation: 0,
            child: ListTile(
              onTap: () {
                DataBase().cameraOpen(widget.myUser.ID);
              },
              title: const Text("Canlı Yayın",style: TextStyle(color: Colors.red),),
              leading: const Icon(Icons.live_tv,color: Colors.red,),
            ),
          ),
        ],
      ),
    )
  ),);
  }
 Future<dynamic> camandgalery(BuildContext context) {
   return showMaterialModalBottomSheet( //galeri veya kamera seçeneği
      context: context,
      builder: (context) => SingleChildScrollView(
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
                    DataBase().cameraOpen(widget.myUser.ID);
                  },
                  ),),
                  Expanded(
                  flex: 1,
                  child: InkWell(child: photoandgallery(const Icon(Icons.photo),"Galeri"),
                  onTap: () {
                    DataBase().galleryOpen(widget.myUser.ID);
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

class BottomNavigation extends ConsumerWidget{
   const BottomNavigation({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home,size: 30),label:""),
        BottomNavigationBarItem(icon: Icon(Icons.search,size: 30),label:""),
        BottomNavigationBarItem(icon: Icon(Icons.movie_filter_outlined),label:""),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_sharp),label:""),
        BottomNavigationBarItem(icon: Icon(Icons.person),label:""),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: ref.watch(navbarstate), 
      fixedColor: Colors.black,
      onTap: ((value) {
        if(value==1 ){
          ref.read(textInstaProvider.notifier).state=const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child:  TextField(
              decoration: InputDecoration(
                label: Text("Search"),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))  
                )
              ),
            ),
          );
          allStateClear(ref,true);    
        }
        else if(value==3){
          ref.read(textInstaProvider.notifier).state=const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child:  TextField(
              decoration: InputDecoration(
                label: Text("Search"),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0))  
                )
              ),
            ),
          );
          allStateClear(ref,false);
        }
        else if(value==2){
          DataBase().cikisYap();
        }
        else if(value==4){
          oldState(ref);
        }
        else{
          oldState(ref);
        }
        ref.read(navbarstate.notifier).state=value;       
      }),
    );
  }

  void oldState(WidgetRef ref){
      ref.read(instaIconFavorite.notifier).state=favoriteIcon();
      ref.read(instaIconMessage.notifier).state=messageIcon();
      ref.read(instaIconReels.notifier).state=reeelsIcon();
      ref.read(textInstaProvider.notifier).state=mainTitle();
     
  }
  void allStateClear(WidgetRef ref,bool Kontrol){
      //ref.read(instaIconReels.notifier).state=const AbsorbPointer(absorbing: true,child: Text(""));
      Kontrol==true? ref.read(instaIconReels.notifier).state=IconButton(onPressed: (){}, icon: const Icon(Icons.person_add,color: Colors.black,)): ref.read(instaIconReels.notifier).state=IconButton(onPressed: (){}, icon: const Icon(Icons.abc_sharp));
      ref.read(instaIconMessage.notifier).state=IconButton(onPressed: (){}, icon: const Icon(Icons.abc_sharp,color: Colors.white,));
      ref.read(instaIconFavorite.notifier).state=IconButton(onPressed: (){}, icon: const Icon(Icons.abc_sharp,color: Colors.white,));
  }
  

}

