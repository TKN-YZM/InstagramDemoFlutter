import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/userclass/shareclass.dart';
import "dart:io";


import 'package:image_picker/image_picker.dart';
class DataBase{
  final FirebaseAuth auth=FirebaseAuth.instance;
  final FirebaseFirestore store=FirebaseFirestore.instance;
  
  Future<String> kayit(String email,String password,String kullaniciAdi,String isim) async{
    try {
      UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,); 
      veriEkleme(user.user!.uid, kullaniciAdi, isim,"abcd");
      return (user.user!.uid).toString();
    } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return "Zayıf Şifre Seçimi,Lütfen daha güçlü şifre seçiniz";
    } else if (e.code == 'email-already-in-use') {
      return "E Mail zaten kullanılmakta. Lütfen başka bir e mail adresi giriniz.";
    }
    else{
      return "Hata";
    }
  } catch (e) {
    return "Bir hata meydana geldi";
  }
  }

  Future<String> signIntoSystem(String email,String password) async{
    try {
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: password);
      return (user.user!.uid.toString());
    } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return "Girilen E Mail adresine ait kullanıcı bulunamadı";
    } else if (e.code == 'wrong-password') {
      return "Şifre hatalıdır. lütfen tekrar gözden geçiriniz";
    } 
    else{
      return "Girilen bilgilerde hata bulunmaktadır.Lütfen tekrar gözden geçiriniz";
    } }
    catch(e){
      return "Bir hata meydana geldi";
    }

  }

  Future<UserClass> kullaniciOzellik(String id) async {
    try{
      //var userDoc=await store.collection("Users").get();
      var userData=await store.doc("Users/$id").get();
      String isim=userData["IsimSoyisim"];
      String genelOzellik=userData["GenelOzellikler"];
      String kullaniciAdi=userData["KullaniciAdi"];
    
      return UserClass(userData.id, kullaniciAdi, isim, genelOzellik);//UserClass(userData.id, kullaniciAdi, isim, genelOzellik);
    }
    catch(e){
      debugPrint("Hata aldık");
      debugPrint(e.toString());
      return  UserClass("", "", "", ""); //UserClass("1","", "", "");
    }
  }

  Future<String> veriEkleme(String id,String KullaniciAdi,String IsimSoyisim,String yeniOzellik) async{
    try{

      await store.doc("Users/$id").set({"KullaniciAdi": KullaniciAdi,"IsimSoyisim": IsimSoyisim,"GenelOzellikler":yeniOzellik},SetOptions(merge: true));
      return "T";
    }
    catch(e){
      debugPrint("---------------Hata ALdık--------------------");
      debugPrint(e.toString());
      return "F";
    }

  }

  Future cikisYap()async{
    await auth.signOut();
  }

  Future<String> cameraOpen(String id) async{
    try{
      File yuklenecekDosya;
      var alinanDosya=await ImagePicker().pickImage(source: ImageSource.camera);
      if(alinanDosya==null){
        return "";
      }
      else{
           yuklenecekDosya=File(alinanDosya.path);
          var data=FirebaseStorage.instance.ref().child("profilresimleri").child(id).child("profilresim.png");
          var url=await data.getDownloadURL();
          var gorev=data.putFile(yuklenecekDosya);
          return url;
      }
    }
    catch(e){
      debugPrint(e.toString());
      return "";
    }
  }

  Future<String> galleryOpen(String id) async{
    try{
    File yuklenecekDosya;
    var alinanDosya=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(alinanDosya== null){
      return "";
    }
    else{
      yuklenecekDosya=File(alinanDosya.path);
      var data=FirebaseStorage.instance.ref().child("profilresimleri").child(id).child("Profil").child("1.jpg");
      var gorev=data..putFile(yuklenecekDosya);
      var url=data.getDownloadURL();
      debugPrint(url.toString());
      return url;
    }   
    }
    catch(e){
      return "Hata";
    }
  }
  
  Future<String> takeUserPhoto(String id) async{
    try{
      var ref=FirebaseStorage.instance.ref().child("profilresimleri").child(id).child("Profil").child("1.jpg");
      String getDownloadURL= await ref.getDownloadURL();
      return getDownloadURL;
    }
    catch(e){
      return "";
    }
  }

  Future<List> takeUserAllPhoto(String id) async {
    List<String> myList=[];
    try{
      for(int i=2;i<6;i++){
         var ref=FirebaseStorage.instance.ref().child("profilresimleri").child(id).child("Paylasimlar").child("$i.jpg");
          String getDownloadURL= await ref.getDownloadURL();
         myList.add(getDownloadURL);
      }
    
      return myList;
    }
    catch(e){
      return [];
    }
  }

  Future<List<String>> takeUserHistory(String id) async {
      List<String> myList=[];
      try{
        for(int i=1;i<=3;i++){
          var ref=FirebaseStorage.instance.ref().child("profilresimleri").child(id).child("Hikayeler").child("$i.jpg");
            String getDownloadURL= await ref.getDownloadURL();
          myList.add(getDownloadURL);
        }
      
        return myList;
      }
      catch(e){
        return [];
      }
    }
  Future<String> takeUserHistoryPersonal(String id) async {
      try{
         var ref=FirebaseStorage.instance.ref().child("profilresimleri").child(id).child("Hikayeler").child("1.jpg");
          String getDownloadURL= await ref.getDownloadURL();
          return getDownloadURL;
      }
      catch(e){
        return "";
      }
    }
 
  Future<ListResult> sonProva(String id) async {
    ListResult result=await FirebaseStorage.instance.ref('profilresimleri').child(id).child("Hikayeler").listAll();
    return result;
  }

  Future<String> getImagePathForList(String id,String imgName) async{
     try{
      var ref=FirebaseStorage.instance.ref().child("profilresimleri").child(id).child("Hikayeler").child(imgName);
      String getDownloadURL= await ref.getDownloadURL();
      return getDownloadURL;
    }
    catch(e){
      return "";
    }
  }

}