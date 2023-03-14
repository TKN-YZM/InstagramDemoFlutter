import 'package:flutter_application_1/navigatiorbarstate/menu.dart';
import 'package:flutter_application_1/navigatiorbarstate/profile/profile.dart';
import 'package:flutter_application_1/navigatiorbarstate/sharepage.dart';
import 'package:flutter_application_1/toppages/message.dart';
import 'package:flutter_application_1/userclass/shareclass.dart';
import 'package:flutter_application_1/commanusage/GoEmpty.dart';
import 'package:flutter_application_1/firebase/allfirebase.dart';
import 'package:flutter_application_1/mainpage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigatiorbarstate/salepage.dart';
import "package:flutter/material.dart";
import 'navigatiorbarstate/kesfet.dart';
import 'providers/mainproviders.dart';



class MyMainApp extends StatelessWidget {
  UserClass myUser; 
  bool isNewPost;
  MyMainApp({required this.myUser,this.isNewPost=false,super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.cyan),
      debugShowCheckedModeBanner: false,
      title: "Instagram",
      home: TopPage(myUser: myUser,isNewPost: isNewPost),
    );
  }
}

class TopPage extends StatefulWidget {
  UserClass myUser;
  bool isNewPost;
  TopPage({required this.myUser,this.isNewPost=false,super.key});
  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage>{
  int expandedStateCount=3; //üst yapıdaki alan kontrolü (yazi ve iconlar)
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
    mainPage=MainStructurePage(myUser: widget.myUser,isNewPost: widget.isNewPost);
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
          Expanded( //Instagram yazisi
            flex: expandedStateCount,
            child: Padding(
            padding: const  EdgeInsets.only(top: 10,left: 10),
            child: Consumer(builder: ((context, ref, child) {
              var deger= ref.watch(textInstaProvider); //riverpod ile diğer sayfalarda değişiklik yapılacak
              return deger;
            })),
          ),),
          Expanded( //reels icon
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
          Expanded(flex: 0,child: InkWell( //kalp icon 
            onTap: () {
              DataBase().usersID(widget.myUser.ID);
            },
            child: Consumer(builder: ((context, ref, child) {
              return ref.watch(instaIconFavorite); 
            }))
            ),),
          Expanded( //message icon
            flex: 1,
            child: 
            InkWell(child: Consumer(builder: ((context, ref, child) {
              return ref.watch(instaIconMessage); 
            })),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  MessagePage(myUser: widget.myUser,)));
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

   _message(context) { //Alttan Gönderi Ekle  Mesajı
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
                  title: const Text("Gönderi Yayınla"),
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
                  title: const Text("Reels Videosu Oluştur"),
                  leading: const Icon(Icons.movie_outlined),
                  onTap: () {
                    _camandgalery(context);
                  },
                ),
              ),
            ),
            Expanded(//çöp kovası icon
              child: Card( //canlı yayın
                elevation: 0,
                child: ListTile(
                  onTap: () {
                    DataBase().preofilResmiGaleriKamera(widget.myUser.ID,galeriMi: false);
                  },
                  title: const Text("Canlı Yayın Yap",style: TextStyle(color: Colors.red),),
                  leading: const Icon(Icons.abc,color: Colors.red,),
                ),
              ),
            ),
          ],
        ),
    );}));   
  }
  
   _camandgalery(context){ /// Galeriden mi Kameradan Mı Seçilsin
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
                  InkWell(child: _photoAndGallery(const Icon(Icons.camera_enhance),"Kamera"),
                  onTap: () {
                    debugPrint("Kamera açılıyor");
                    DataBase().paylasimGaleriCamera(gallery: false).then((value) => {
                        value.path==""? debugPrint("SEÇİM YOK YA DA HATA"):Navigator.push(context, MaterialPageRoute(builder: (context) => SharePage(myUser: widget.myUser, imgPath: value))),
                      });
                    Navigator.pop(context);
                  },
                  ),),
                  Expanded(
                  flex: 1,
                  child: InkWell(child: _photoAndGallery(const Icon(Icons.photo),"Galeri"),
                  onTap: () {
                    debugPrint("-------------------------");
                    debugPrint("Galeriyi açıyoruz");
                      DataBase().paylasimGaleriCamera().then((value) => {
                        value.path==""? debugPrint("SEÇİM YOK YA DA HATA"):Navigator.push(context, MaterialPageRoute(builder: (context) => SharePage(myUser: widget.myUser, imgPath: value))),
                      });
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

  Column _photoAndGallery(Icon icon,String text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Text(text,style: const TextStyle(fontSize: 18), )
      ],
    );
  }

}

class BottomNavigation extends ConsumerWidget{ //Alttaki 5 İconlu Yapı
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
        if(value==1 ){ //Keşfet sayfasında üst yapıyı kontrol etme
          ref.read(textInstaProvider.notifier).state=const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child:  TextField(
              decoration: InputDecoration(
                label: Text("Search"),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))  
                )
              ),
            ),
          );
          allStateClear(ref,true);    
        }
        else if(value==3){//Sale sayfasında üst yapıyı kontrol etme
          ref.read(textInstaProvider.notifier).state=const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child:  TextField(
              decoration: InputDecoration(
                label: Text("Search"),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius:  BorderRadius.all(Radius.circular(10.0))  
                )
              ),
            ),
          );
          allStateClear(ref,false);
        }
        else{ //diğer durumlarda ilk ana yapı kalıcak
          oldState(ref);
        }
        ref.read(navbarstate.notifier).state=value;      
      }),
    );
  }

  void oldState(WidgetRef ref){ //Üst Taraftaki En temel hal (insta yazısı ve 3 icon)
      ref.read(instaIconFavorite.notifier).state=favoriteIcon();
      ref.read(instaIconMessage.notifier).state=messageIcon();
      ref.read(instaIconReels.notifier).state=reeelsIcon();
      ref.read(textInstaProvider.notifier).state=mainTitle();
  }
  
  void allStateClear(WidgetRef ref,bool kontrol){ //üst tarafı tamamen kaldırıyoruz

      kontrol==true? ref.read(instaIconReels.notifier).state=IconButton(onPressed: (){}, icon: const Icon(Icons.person_add,color: Colors.black,)): ref.read(instaIconReels.notifier).state=IconButton(onPressed: (){}, icon: const Icon(Icons.abc_sharp));
      ref.read(instaIconMessage.notifier).state=IconButton(onPressed: (){}, icon: const Icon(Icons.abc_sharp,color: Colors.white,));
      ref.read(instaIconFavorite.notifier).state=IconButton(onPressed: (){}, icon: const Icon(Icons.abc_sharp,color: Colors.white,));
  }
  
}

