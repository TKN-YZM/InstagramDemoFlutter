import "package:flutter/material.dart";
import 'package:flutter_application_1/commanusage/commonfunc.dart';

class MenuSearch extends StatefulWidget {
  const MenuSearch({super.key});

  @override
  State<MenuSearch> createState() => _MenuSearchState();
}
class _MenuSearchState extends State<MenuSearch> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(child: textBox()),
          Expanded(
            child:  Padding( //menudeki kartlar
              padding: const EdgeInsets.only(top: 7,left: 2,right: 2),
              child: karePicture(MediaQuery.of(context).size,"assets/model1.jpg","assets/model2.jpg","assets/modelgrid1.jpg"),
            )
          ),
        
        ],
      ),
    );
  }

  Container textBox() {
    return Container(
      width: 360,
      height: 40,
          child: TextField(
              decoration: InputDecoration(
              label: const Text("Ara"),
              filled: true,
              fillColor: Colors.grey.shade100,
              prefixIcon: const Icon(Icons.search,color: Colors.black),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
      ),
    );
  }

}