import "package:flutter/material.dart";
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/userclass/shareclass.dart';
import 'package:palette_generator/palette_generator.dart';

class PicturePage extends StatefulWidget {
  final imgPath;
  final UserClass myUser;
  const PicturePage({required this.imgPath,required this.myUser,super.key});

  @override
  State<PicturePage> createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
   late PaletteGenerator generator;
   Color arkaplan_rengi=Colors.white;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ColorState(widget.imgPath);
  }
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: arkaplan_rengi,
      body: Hero(
        tag: "12",
        child: InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => MyMainApp(myUser: widget.myUser))),
          child: Container(
            color: Colors.transparent,
            height: size.height,
            width: size.width,
            child: Image.asset(widget.imgPath),
          ),
        ),
      ),
    );
  }

  void ColorState(String imgPath) async{
    generator=await PaletteGenerator.fromImageProvider(AssetImage(imgPath));
    arkaplan_rengi=generator.dominantColor!.color;
    setState(() {
      print(arkaplan_rengi);
    });
  }
}