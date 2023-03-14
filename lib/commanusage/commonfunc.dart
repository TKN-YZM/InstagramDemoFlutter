import 'package:flutter/material.dart';

  //ScaffoldMessenger ile alt kısımdan mesaj çıkarma
  void showMessage(String data,context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data,style: const TextStyle(fontSize: 16),)));
  }

  //Hikayelerdeki yuvarlak kullanıcı resmi ve yazısı cihazdan
  Stack circlePicture(String pictureName,{String name="",bool hikayeKontrol=false,double widht=70,double height=70}) {
    return Stack(
      children:  [
          Padding( //hikaye resmi
            padding: const EdgeInsets.only(right: 20,left: 6,top: 13),
            child: Container( //hikaye resmi
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                image: pictureName==""?  const DecorationImage(image: AssetImage("assets/aperson.png"),fit: BoxFit.cover):DecorationImage(image: AssetImage(pictureName),fit: BoxFit.cover)
              ),
              width: widht,height: height),
          ),
          hikayeKontrol==false? const SizedBox(height: 0,width: 0,):
          const Positioned (
            top: 60,
            left: 53,
            child:  SizedBox(height: 10,width: 10,child:  Icon(Icons.add,size: 22),)),
          Padding( //Yazının kordinatları
            padding: const EdgeInsets.only(top: 85,left: 18),
            child: Text(name,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500),),
          )
      ],
    );
}

    //Hikayelerdeki yuvarlak kullanıcı resmi ve yazısı İnternetten 
  Stack circlePictureNetwork(String picturPath,{String name="",double widht=70,double height=70}){
    return Stack(
      children:  [
        Padding(
          padding: const EdgeInsets.only(right: 20,left: 6,top: 13),
          child: Container( //hikaye resmi
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              image: picturPath==""?   const DecorationImage(image: AssetImage("assets/aperson.png"),fit: BoxFit.cover):DecorationImage(image: NetworkImage(picturPath),fit: BoxFit.cover/*AssetImage(picturPath),fit: BoxFit.cover*/)
            ),
            width: widht,height: height),
        ),
        Padding( //Yazının kordinatları
          padding: const EdgeInsets.only(top: 85,left: 18),
          child: Text(name,style: const TextStyle(fontSize: 15),),
        )
      ],
    );
  }


  //Keşfet Yapısı (yan yana 2 kare ve sağında reels)
  Column karePicture(Size size,String imgPath1,String imgPath2,String imgPath3) { 
    return Column(
      children: [    
        Row( 
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 3,),
            Expanded(
              flex: 1,
              child: Container(
                child:imgPath1==""? const Text(""):pictures(size,imgPath1),
              ),
            ),
            const SizedBox(width: 3),
            Expanded(
              flex: 1,
              child: Container(
                child:imgPath2==""? const Text(""):pictures(size,imgPath2),
                  ),
            ),
            const SizedBox(width: 3,),
            Expanded(
        flex: 1,
         child: Container(
           child: imgPath3==""? const Text(""):pictures(size,imgPath3),
             ),
       )
          ],
        ),
      ],
    );
  }
  
  //Kare içinde resim / galeriden ya da internetten 
  Container pictures(Size size,String picturePath) => Container(height: 150,width: 130,child: picturePath==""? 
  Container():Image.network(picturePath,fit: BoxFit.cover,));

 