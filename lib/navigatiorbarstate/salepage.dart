import 'package:flutter/material.dart';


class SalePage extends StatelessWidget {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return ListView(
      children: [
        Column(
          children: [
          
          rowyapisi(size,"assets/modelgrid3.jpg","assets/model2.jpg"),
          rowyapisi(size,"assets/modelgrid1.jpg","assets/model1.jpg"),
          rowyapisi(size,"assets/model3.jpg","assets/model1.jpg"),
          ],
        )
       
      ],
    );
  }

  Row rowyapisi(Size size,String image1,String image2) {
    return Row(
          children: [
            Expanded(flex:1,child: Container(
              child: pictureSetting(size,image1))
            ),
            Expanded(flex:1,child: Container(
              child: pictureSetting(size,image2))
            ),
          ],
        );
  }

  Widget pictureSetting(Size size,String imagePath){
    return Container(
      padding: const EdgeInsets.all(1),
      height: 200,
      child: Image.asset(imagePath,fit: BoxFit.cover,),
    );
  }

}