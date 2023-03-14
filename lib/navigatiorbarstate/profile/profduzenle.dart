import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase/allfirebase.dart';
import 'package:flutter_application_1/userclass/shareclass.dart';
import '../../commanusage/commonfunc.dart';

class ProfiDuzenle extends StatefulWidget {
  UserClass myUser;
  ProfiDuzenle({required this.myUser,super.key});

  @override
  State<ProfiDuzenle> createState() => _ProfiDuzenleState();
}

class _ProfiDuzenleState extends State<ProfiDuzenle> {
  late TextEditingController adController;
  late TextEditingController klncController;
  late TextEditingController gnlController;
  @override
  void initState() {
    super.initState();
    adController=TextEditingController();
    klncController=TextEditingController();
    gnlController=TextEditingController();
    adController.text=widget.myUser.kullaniciGenelAdi;
    klncController.text=widget.myUser.kullaniciAdi;
    gnlController.text=widget.myUser.genelOzellik;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding( //geri icon
            padding: const EdgeInsets.only(right: 50),
            child: InkWell(child: const Icon(Icons.arrow_back_ios_new,color: Colors.black,size: 25,),
            onTap: () {
              Navigator.pop(context);
            },
            ),
          ),
          const Padding( //profili düzenle
            padding:  EdgeInsets.only(top: 14,right: 135),
            child: Text("Profili Düzenle",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
          ),
          Padding( //tamam
            padding: const EdgeInsets.only(right: 8,bottom: 5),
            child: IconButton(onPressed: (){
              DataBase().veriEkleme(widget.myUser.ID, klncController.text,adController.text,gnlController.text).then((value) => {
                if(value=="T"){
                  showMessage("İşlem Tamam", context),
                  setState(() {
                    widget.myUser.genelOzellik=gnlController.text;
                    widget.myUser.kullaniciAdi=klncController.text;
                    widget.myUser.kullaniciGenelAdi=adController.text;
                    const Duration(seconds: 1);
                    Navigator.pop(context,[gnlController.text,klncController.text,adController.text]);
                  })
                }
                else{
                  showMessage("Hata", context)
                }
              });
            }, icon: const Icon(Icons.done,color: Colors.blue,size: 30,)),
          )
        ],
      ),
      body: ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          InkWell(child: circlePicture("assets/model4.jpg")),
          circlePicture(""),
        ],),
        TextButton(onPressed: (){}, child: const Text("Resmi veya avatari düzenle")),
         _textField("Ad",adController),
         _textField("Kullanici Adi",klncController),
         _textField("Biyografi",gnlController,maxLength: 50),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bottomText("Bağlantilar"),
            _bottomText("Profesyonel hesaba geçiş yap"),
            _bottomText("Kişisel bilgi ayarlari"),
          ],
        )
      ],)
    );
  }
  Widget _bottomText(String baslik) {
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: TextButton(onPressed: (){}, child: Text(baslik,style: const TextStyle(fontSize: 16),)),
    );
  }
  Widget _textField(String baslik,TextEditingController controller,{int maxLength=15}){
    return Container(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.only(left: 17,right: 17),
        child: TextField(
          controller: controller,
          maxLength: maxLength,
          decoration: InputDecoration(
            labelText: baslik
            //label: Text(baslik),
          )
        ),
      ),
    );
  }

}

