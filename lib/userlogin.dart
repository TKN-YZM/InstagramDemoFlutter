import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/commanusage/commonfunc.dart';
import 'package:flutter_application_1/firebase/allfirebase.dart';
import 'package:flutter_application_1/signup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
  runApp(const ProviderScope(child: UserLoginMain()));
}

class UserLoginMain extends StatelessWidget {
  const UserLoginMain({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.white10,elevation: 0,),
        body: const UserLogin(),
      ),
    );
  }
}

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});
  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  late TextEditingController emailcontroller;
  late TextEditingController passwordController;
  late bool _textState;
  late FirebaseAuth auth;
  late User userA;
  @override
  void initState() {
    super.initState();
    auth=FirebaseAuth.instance;
    auth.authStateChanges().listen((user) {
      if(user==null){  
        debugPrint("Oturum Kapalı");
      }
      else{
        userA=user;
        debugPrint("Oturum Açık: ${user.email} ve ID: ${user.uid}");
        DataBase().kullaniciOzellik(userA.uid).then((value) => {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyMainApp(myUser: value),))
        });
      }
    });
    emailcontroller=TextEditingController();
    passwordController=TextEditingController();
    _textState=false;
  }
  @override
  void dispose() { 
    super.dispose();
    emailcontroller.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          padding: const EdgeInsets.only(top: 110),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Text("Instagram",style: TextStyle(fontSize: 50,fontFamily: "mainfont"),), 
              Padding( //E posta giriş
                padding: const EdgeInsets.only(top: 20,left: 30,right: 30),
                child: textField("Telefon, kullanıcı adı  veya eposta",emailcontroller),
              ),
              Padding( //Password TextBox
                padding: const EdgeInsets.only(top: 20,left: 30,right: 30),
                child:  textFieldPassword("Sifre",passwordController,),
              ),
              Padding( //Sifremi unuttum
                padding: const EdgeInsets.only(right: 20,top: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){}, child: const Text("Sifreni mi Unuttun"))
                  ],
                ),
              ),  
              Container ( //Giriş Yap Button
                width: 350,
                child: ElevatedButton(onPressed: (){
                  String a=emailcontroller.text;
                  String b=passwordController.text;
                  debugPrint(a+b);
                  DataBase().signIntoSystem(a, b).then((value) => {
                    if(value.length==28){
                      DataBase().kullaniciOzellik(value).then((value) => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyMainApp(myUser: value,)))
                      })
                    }
                    else{
                      showMessage(value, context)
                    }
                  });
                }, child: const Text("Giriş Yap"))),
              Padding( //Ya da and Diveder
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(flex: 2,child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Container(child: const Divider(color: Colors.black,),),
                    )),
                    const Expanded(flex: 1,child: Center(child:  Text(" Ya Da "))),
                    const Expanded(flex: 2,child: Padding(
                      padding:  EdgeInsets.only(right: 30),
                      child:  Divider(color: Colors.black,),
                    )),
                  ],
                ),
              ),
              Padding( //Hesabım Yok? Kaydol
               padding: const EdgeInsets.only(top: 80),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Hesabın mı yok?"),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                  }, child: const Text("Kaydol"))
                ],
               ),
             ),
            ],
      ),
    );
  }

  TextField textField(String title,TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        label: Text(title)
      ),
  );
  }
  TextField textFieldPassword(String title,TextEditingController controller,) {
    return TextField(
      obscureText: _textState,
      controller: controller,
      decoration: InputDecoration(
      label: const Text("Parola"),
      suffixIcon: IconButton(
        icon: const Icon(Icons.key),
        onPressed: () {
          setState(() {
            _textState=!_textState;
          });
        },
      )
  ),

  );
  }
}

