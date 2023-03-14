import 'package:flutter/material.dart';
import 'package:flutter_application_1/commanusage/commonfunc.dart';
import 'userclass/shareclass.dart';

class Postshare extends StatefulWidget {
  final UserClass myuserClass;
  final String imgPath;
  final String circilePath;
  final Function() onTap;
  const Postshare({required this.imgPath,required this.myuserClass,required this.circilePath ,required this.onTap,Key? key,}):super(key: key);

  @override
  State<Postshare> createState() => _PostshareState();
}

class _PostshareState extends State<Postshare> {
    Color color=Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return Padding( //share post height widht radius settings 
      padding: const EdgeInsets.only(left: 10,right: 10,bottom: 20),
      child: Container(
        height: 550,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8)
        ),
        child: _shareThings(context,widget.onTap), //all post
      ),
    );
  }

  Widget _shareThings(context,Function() onTap){
    Size size=MediaQuery.of(context).size;
    return Column(
      children: [
        Row( // Top photo / username / time and share icon
          children: [
            sharePicture(widget.circilePath), //share user photo
            Stack(
              children: [
                shareUserText(widget.myuserClass.kullaniciAdi), //share of user name
                Positioned(child: shareTime("7 Dk Önce"),top: 28), //share of time
              ],
            ),
            Padding(
              padding:  EdgeInsets.only(left: (size.width-190)),
              child: InkWell(child: const Icon(Icons.more_vert),onTap: () {},),
            ),
          ],
        ),
        Row( //main post page
          children: [
            Expanded(child: InkWell(
              onTap: onTap,
              child: Container(height: 400,width: 300,child: Image.asset(widget.imgPath,fit: BoxFit.cover,))))
          ],
        ),
        const SizedBox(height: 20),
        Row( //bottom icons (like,message,share,select)
        mainAxisAlignment: MainAxisAlignment.start,
          children: [
            iconcreate(Icons.favorite_border_rounded,(){},), 
            const SizedBox(width: 25),
            iconcreate(Icons.mode_comment_outlined,(){
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10)
                  )
                ),
                isScrollControlled: true,
                context: context, builder: ((context) {
                  return DraggableScrollableSheet(
                    expand: false,
                    builder: (context, scrollController) => SingleChildScrollView(
                      controller: scrollController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      
                       Container(
                        height: 320,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row( // geri icon yorumlar yazısı ve paylaş icon
                              children: const[
                                Expanded(flex: 1,child: Padding(
                                  padding: EdgeInsets.only(right: 80),
                                  child: Icon(Icons.arrow_back,color: Colors.black,size: 30,),
                                )),
                                Expanded(flex: 1,child: Padding(
                                  padding: EdgeInsets.only(),
                                  child: Text("Yorumlar",style: TextStyle(fontSize: 22),),
                                )),
                                Expanded(flex: 1,child: Text(""))
                              ],
                            ),
                            mesajCard("assets/bluemodel.jpg","_ahmetfar","Merhaba, yakın bir dönem önce başladığım yazılım serüveninde içerik eksikliklerini farkedip içerik üretmeye başladım.İlk çektiğim videodaki o heyecanı günümüzde çektiğim tüm videolarda yaşamaktayım\n\n#başarı #yazılım #yazılımcı #keşfet #abdullahbalcan #udemy #youtube",gondericiKontrol: true),
                            const Divider(color: Colors.black,height: 5,),
                          ],
                        ),
                       ),
                        InkWell(
                          child: Card(color: Colors.transparent,elevation: 0,child: mesajCard("assets/blue.jpg","_ahmetfar","Tebrikler! Kendine güven ve başarıya odaklan"))),
                        Card(color: Colors.transparent,elevation: 0,child: mesajCard("assets/model1.jpg","_ahmetfar","You are real hero!")),
                        Card(color: Colors.transparent,elevation: 0,child: mesajCard("assets/bluemodel.jpg","_ahmetfar","Küçük bir başarı, daha iyisini bekleriz")),
                        Card(color: Colors.transparent,elevation: 0,child: mesajCard("assets/modelgrid1.jpg","_ahmetfar","Küçük bir başarı, daha iyisini bekleriz")),
                      ],
                    ),
                  ));
              }));
            }),
            const SizedBox(width: 25),
            iconcreate(Icons.near_me_sharp,(){
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
                    controller: scrollController,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                       Container( //mesaj yaz
                        height: 70,
                        width: 350,
                        child: const Padding(
                          padding: const EdgeInsets.only(top: 12,left: 10,right: 10),
                          child: TextField(
                            decoration: InputDecoration(
                              label: Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Text("Mesaj Yaz..",style: TextStyle(fontSize: 16),),
                              ),
                            ),
                          ),
                        )
                       ),
                      Container(
                        height: 40,
                        width: 350,
                        child:  const TextField(
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.person_outline_outlined),
                            label: Text("Search"),
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(10.0))  
                            )
                          ),
                        ),
                       ),
                      sendCard("assets/model3.jpg","Abdullah Balcan","abdullah_balcn",(){}),
                      sendCard("assets/model1.jpg","Bumin Tunahan","bumin_tuna",(){}),
                      sendCard("assets/model2.jpg","Zeki Aktal","zek_aktal",(){}),
                      sendCard("assets/reels2.jpg","Erdem Curaci","erdem_curac",(){}),
                      sendCard("assets/aperson.png","Murat Turan","murat_turan",(){}),
                      sendCard("assets/bluemodel.jpg","Emre Durat","emre_dura",(){}),
                      sendCard("assets/batim1.png","Recep Tutan","recep_tutan",(){}),
                      sendCard("assets/me.png","Ahmet Yel","ahmet_yel",(){}),
                      sendCard("assets/3.jpg","Azad Cin","azad_cin",(){}),
                      sendCard("assets/blue.jpg","Recep Tutan","recep_tutan",(){}),
                      sendCard("assets/me.png","Murat Turan","murat_turan",(){}),
                      sendCard("assets/3.jpg","Murat Turan","murat_turan",(){}),
                      ],
                    ),
                  ));
              }));
            }), 
            Padding(
              padding: const EdgeInsets.only(left: 130),
              child: iconcreate(Icons.turned_in, () => null),
            )
          ]
        )
      ],
    );
  }

  Container sendCard(String imgPath,String genelIsim,String kullaniciAdi,Function() onPressed,{Color buttoncolor=Colors.blue}) {
    return Container(
        height: 75,
        width: 350,
        child: Row(
          children: [
            Expanded(flex: 2,child: CirclePicture(imgPath,height: 48,widht: 60)),
            Expanded(flex: 5,child: Stack(
            children: [
              Text(genelIsim,style: TextStyle(fontWeight: FontWeight.w500),),
              Padding(
                padding: const EdgeInsets.only(top: 19),
                child: Text(kullaniciAdi),
              )
            ]),),
            Expanded(flex: 3,child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttoncolor,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // <-- Radius
              ),
              ),
            child: const Text("Gönder",style: TextStyle(color: Colors.white),),
            onPressed: onPressed))
          ],
        ),
      );
  }

  Row mesajCard(String imgPath,String kisiIsmi,String mesaj,{bool gondericiKontrol=false}) {
    return Row(
      children: [
        Expanded( //resim
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(top: 10,left: 5),
            child: CirclePicture(imgPath,height: 40,widht: 40),
          ),
        ),
        Expanded( //Kişi ismi,mesaj gönderi ve yanıtla
          flex:8,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Text(kisiIsmi,style: TextStyle(fontWeight:  FontWeight.w500),),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 20),
                child: Text(mesaj,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
              ),
              gondericiKontrol==false?
              Row(
                children: [
                  Padding(
                  padding: const EdgeInsets.only(top:60,right: 10),
                  child: Text("Yanıtla"),
                ) ,Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Text("Gönder"),
                ) 
                ],
              ):
              SizedBox(height: 0,width: 0,)
               
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 20,bottom: 20,),
            child: Icon(Icons.favorite,color: Colors.black26,),
          )),                     
      ],
    );
  }

  Container iconcreate(IconData myIcons,Function() onTop,{double iconSize=29}){
    return Container(height: 18,width: 50,
    child: InkWell(
      child: Icon(myIcons,size: iconSize,color: Colors.black54,),
      onTap: onTop
    ),);
  }

  Widget sharePicture(String imgPath) { //share top photo
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
            width: 50,height: 50,  
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
                image:  DecorationImage(image: AssetImage(imgPath),
                fit: BoxFit.cover)
              ),
        ),
    );
  }

  Widget shareUserText(String name){
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Text(name,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.w500),),
    );
  }

  Widget shareTime(String time){
    return  Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Text(time,style: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),),
    );
  }
}