import "package:flutter/material.dart";
import 'package:flutter_application_1/commanusage/commonfunc.dart';
import 'package:flutter_application_1/firebase/allfirebase.dart';
import 'package:flutter_application_1/userlogin.dart';



class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white24,elevation: 0,),
        body: const mianPage(),
      ),
    );
  }
}

class mianPage extends StatefulWidget {
  const mianPage({super.key});

  @override
  State<mianPage> createState() => _mianPageState();
}

class _mianPageState extends State<mianPage> {
  final DataBase dataBase=DataBase();
  late TextEditingController epostaController;
  late TextEditingController adiController;
  late TextEditingController klncadiController;
  late TextEditingController sifreController;
  late bool checkBoxState;

  @override
  void initState() {
    super.initState();
    epostaController=TextEditingController();
    adiController=TextEditingController();
    klncadiController=TextEditingController();
    sifreController=TextEditingController();
    debugPrint("ChechBox state trued atandı");
    checkBoxState=true;
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding( //Instagram yazisi
            padding:  EdgeInsets.only(bottom: 20),
            child: Text("Instagram",style: TextStyle(fontSize: 50,fontFamily: "mainfont"),),
          ),        
          textFieldCreate("Telefon numarası veya eposta", epostaController), //Eposta
          textFieldCreate("Adı Soyadı", adiController), //Ad Soyad
          textFieldCreate("Kullanıcı Adı", klncadiController), //Kullanici Adi
          textFieldCreate("Sifre", sifreController), //Sifre
          Row( //CheckBox  ve "Sözleşmeyi kabul ediyorum"
            children: [
            Container( //CheckBox (Okudum onaylıyorum)
            child: Checkbox(value: checkBoxState,onChanged: (value) {
              setState(() {
                checkBoxState=value!;
              });
              },)),
            const Text("Sözleşmeyi kabul ediyorum"),
            ],
          ),
          buttonCreate(context,"Kayıt Ol"),//kayit ol button func
          TextButton(onPressed: (){ //Zaten hesabım var
            Navigator.push(context, MaterialPageRoute(builder: (context) => const UserLoginMain()));
          }, child: const Text("Zaten hesabım var"))
        ],
      ),
    );
  }

  Container buttonCreate(BuildContext context,String title) {
    return Container(
      width: MediaQuery.of(context).size.width-45, 
      child: ElevatedButton(onPressed: (){
        final String isimSoyisim=adiController.text;
        final String email=epostaController.text;
        final String sifre=sifreController.text;
        final String kullaniciAdi=klncadiController.text;
        dataBase.userkayit(email,sifre,kullaniciAdi,isimSoyisim).then((value) => {
            if(value.length==28){ //Kayit olunursa kullanıcı ID döndürülecek 
              showMessage("Kayıt İşlemleri Başarıyla Gerçekleşti", context),
              Navigator.push(context, MaterialPageRoute(builder: (context) => const UserLogin()))
          }
          else{
            showMessage(value, context) //Snackbar ile alttan mesaj çıkartma
          }
        });
      }, child:  Text(title),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), 
        ),
      ),
      ),
    );
  }

   Widget textFieldCreate(String title,TextEditingController controller) { //TextField oluşturma
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade100,
          label: Text(title)
        ),
      ),
    );
  }


}

