 import 'package:flutter/material.dart';
class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);
  final String lastValue = 'X';
  @override
  Widget build(BuildContext context) {
    return Column(
        children: [

        Text("Tic Tac Toe",style: TextStyle(color: Colors.teal,fontSize: 64,fontWeight: FontWeight.bold),),
    Text("$lastValue turn",style: TextStyle(color: Colors.white,fontSize: 50,fontWeight: FontWeight.bold),)

    ],
    );

  }


}

