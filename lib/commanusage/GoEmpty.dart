import 'package:flutter/material.dart';

class GoEmptyPage extends StatelessWidget {
  const GoEmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(child: Text("Make A Different",style: TextStyle(fontSize: 20))),
          Icon(Icons.smart_toy_rounded)
        ],
      ),
    );
  }
}