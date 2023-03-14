import 'package:flutter/material.dart';
import 'package:flutter_application_1/pictureShow.dart';
import 'package:flutter_application_1/userclass/shareclass.dart';

class DiscoverPage extends StatelessWidget {
  final UserClass myUser;
  const DiscoverPage({required this.myUser,super.key});
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
         Padding(
           padding: const EdgeInsets.only(top: 5),
           child: genelYapi(context),
         ),     
        ],
      );
  }

  Column genelYapi(context) { //4 foto 1 reeels
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
        children: [
          rowsagResim("assets/model1.jpg","assets/bluemodel.jpg","assets/model3.jpg","assets/model4.jpg","assets/reels1.png",context,myUser),
          yanresimlerUc("assets/3.jpg","assets/reels2.jpg","assets/model3.jpg"),
          yanresimlerUc("assets/me.png","assets/model3.jpg","assets/modelgrid1.jpg"),
          rowsolresim("assets/model1.jpg","assets/model2.jpg","assets/model3.jpg","assets/model1.jpg","assets/reels2.jpg"),
          yanresimlerUc("assets/model1.jpg","assets/model2.jpg","assets/model3.jpg"),
          yanresimlerUc("assets/modelgrid3.jpg","assets/batim1.png","assets/model3.jpg"),
             
        ],
       );
  }

  Row rowsagResim(String imag1,String image2,String image3,String image4,String reelspath,context,UserClass myUser) { //4 foto ve sağda reels
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
          Row(
            children: [
              kesfetpaylasim(imag1),
              kesfetpaylasim(image2),
            ],
          ),
          Row(
            children: [
                kesfetpaylasim(image3),
              kesfetpaylasim(image4),
            ],
            ),
          ],
        ),
        Expanded(flex: 1,child: InkWell(
          onLongPress: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PicturePage(imgPath: reelspath, myUser: myUser,))),
          child: kesfetpaylasim(reelspath,height: 260))),
      ],
    );
  }

  Row rowsolresim(String imag1,String image2,String image3,String image4,String reelspath) {  //4 foto ve solda reels
    return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(flex: 1,child: kesfetpaylasim(reelspath,height: 260)),
            Column(
              children: [
              Row(
                children: [
                  kesfetpaylasim(imag1),
                  kesfetpaylasim(image2),
                ],
              ),
              Row(
                children: [
                  kesfetpaylasim(image3),
                  kesfetpaylasim(image4),
                ],
               ),
              ],
            ),  
          ],
    );
  }

  Row yanresimlerUc(String imgPat1,String imgPat2,String imgPat3) {
    return Row(
          children: [
            Expanded(flex: 1,child: kesfetpaylasim(imgPat1)),
            Expanded(flex: 1,child: kesfetpaylasim(imgPat2)),
            Expanded(flex: 1,child: kesfetpaylasim(imgPat3)),
          ],
        );
  }

  Container kesfetpaylasim(String imgPat,{double height=130,double widht=140}) {
    return Container(
      padding: const EdgeInsets.all(1),
      height: height,width: widht,
      child: Image.asset(imgPat,fit: BoxFit.cover,),
      );
  }


}