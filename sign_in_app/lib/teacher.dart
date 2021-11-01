import 'package:flutter/material.dart';

class Teacher extends StatelessWidget {
  const Teacher({Key? key, required this.name, required this.pwd}) : super(key: key);
  final String name;
  final String pwd;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '教师',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(name: name,pwd: pwd,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,required this.name,required this.pwd}) : super(key: key);

  final String name;
  final String pwd;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('教师'),
      ),
      body:Text(widget.name),
    );
  }
}