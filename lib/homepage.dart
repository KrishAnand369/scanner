import 'package:flutter/material.dart';
import 'package:scanner/scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Day Scholars',style: TextStyle(color: Colors.black),),
      actions: <Widget>[Text('Data Entry',style: TextStyle(color:Colors.black87,
      fontSize: 16, ),),
        IconButton(onPressed: () {
          
        },icon: const Icon(Icons.power_settings_new,color: Colors.redAccent,)),
        
      ],),
      body:  SingleChildScrollView(
        child: 
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(50,200,50,1),
          
          child: ElevatedButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const QRScanner()));
        
          }, child: const Text('camera'),style:ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.black45;
              }
              return Colors.black;
            }),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            )) ,
          ),
        ),
      ),
    );
  }
}