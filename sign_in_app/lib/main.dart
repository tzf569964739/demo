import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sign_in_app/teacher.dart';
import 'package:sign_in_app/studets.dart';

void main() {
  runApp(const MyApp());
}
//tianjiade
//tianjiade
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '课堂签到系统',
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _unameController = TextEditingController();

  @override
  void initState() {
    //显示初始值
    _unameController.text="hello world";
    _unameController.selection = TextSelection(
        baseOffset: 2,//起始编辑处
        extentOffset: _unameController.text.length
    );
    //监听输入改变
    _unameController.addListener((){
      print(_unameController.text);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("课堂签到系统"),
      ),
      body: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: double.infinity, //宽度尽可能大
                maxHeight: 300.0 //最小高度为50像素
            ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                  top: 18.0,
                  child: Image.asset("images/school.jpg"),
                  width: 300,
                  height: 300,
                ),
              ],
            ) ,
          ),
          Text("签到系统",style: TextStyle(fontSize: 30),),
          //登陆窗口
          Container(
            width: 400,
            height: 310,
            child: FormTestRoute(),
          )
          //FormTestRoute(),
        ],
      )
    );
  }
}

class FormTestRoute extends StatefulWidget {
  @override
  _FormTestRouteState createState() => _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  bool _teacherselected=false;
  bool _studentsselected=true;

  @override
  Widget build(BuildContext context) {
    return //Scaffold(
      //body: //Center(
        //child:
        Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _unameController,
                decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  icon: Icon(Icons.person),
                ),
                // 校验用户名
                validator: (v) {
                  return v!.trim().length > 0 ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
                //校验密码
                validator: (v) {
                  return v!.trim().length > 5 ? null : "密码不能少于6位";
                },
              ),
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text("登录"),
                        ),
                        onPressed: () {
                          // 通过_formKey.currentState 获取FormState后，
                          // 调用validate()方法校验用户名密码是否合法，校验
                          // 通过后再提交数据。
                          if ((_formKey.currentState as FormState).validate()) {
                            //验证通过提交数据
                            print("验证通过");
                            navigate();
                          }
                          else{
                            print("验证不通过");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                          value: _teacherselected,
                          activeColor: Colors.red,
                          onChanged: (value){
                            setState(() {
                              _teacherselected = value!;
                              _studentsselected = !value;
                            });
                          }
                      ),
                      Text('教师'),
                      Checkbox(
                          value: _studentsselected,
                          activeColor: Colors.red,
                          onChanged: (value){
                            setState(() {
                              _studentsselected = value!;
                              _teacherselected = !value;
                            });
                          }
                      ),
                      Text('学生'),
                    ]
                ),
              ),
            ],
          ),
        );
  }
  void navigate(){
    //教师界面
    if(_teacherselected==true)
      {
        Navigator.push(context,
           MaterialPageRoute(builder: (contex){
             return Teacher(name:_unameController.text,pwd:_pwdController.text);
           }),
        );
      }
    //学生界面
    else
      {
        Navigator.push(context,
          MaterialPageRoute(builder: (contex){
            return Students(name:_unameController.text,pwd:_pwdController.text);
          }),
        );
      }
  }
}
