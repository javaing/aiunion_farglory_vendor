

import 'package:far_glory_construction_register/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../Constants.dart';
import '../datamodel/V1LoginResponse.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final dio = Dio();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    _usernameController.text = 'vendor';
    _passwordController.text = 'vendor';
  }

  Widget welcome() {
    Widget w1 = Image.asset(
      'images/farbackbig.jpg',
      width: double.infinity,
    );
    Widget w2 = const Text('歡迎使用智慧工地平台\n註冊系統', style: TextStyle(
      fontSize: 26,
      color: Colors.black87,
    ),);
    return Column(children: [
      w1, w2
    ],);
  }

  //歡迎使用智慧工地平台
  Widget InputAccount() {
    return TextFormField(
      controller: _usernameController,
      decoration: const InputDecoration(
        hintText: '帳號',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '請輸入帳號';
        }
        return null;
      },
    );
  }

  Widget InputPassword() {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        hintText: '密碼',
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '請輸入密碼';
        }
        return null;
      },
      obscureText: true,
    );
  }

  Future<void> v1login(String acct, String pwd) async {
    //@POST("/api/v1/session/login")
    //Observable<LoginResult> v1login(@Body LoginBody loginBody);
    //{"type":"manager","username":"admin","password":"admin","remember":true}
    //{"code": 200, "result": {"token": "2d4db94a241e4be9eb2be3e6651eb7a6"}}
    var response = (await dio.post('http://'+ HOST +'/api/v1/session/login', data: {"type":"manager","username":acct,"password":pwd,"remember":true}));
    print("art response=" +response.toString());
    V1LoginResponse v1 = v1LoginResponseFromJson(response.toString()) ;
    print("art token=" + v1.result!.token!);

  }
  
  Widget submit() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          v1login(_usernameController.text, _passwordController.text);
        }
      },
      child: const Text('登入'),
    );
  }
  
  Widget DIV() {
    return const SizedBox(height: 20.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('包商管理-工人註冊'),
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              welcome(),
              DIV(),
              InputAccount(),
              DIV(),
              InputPassword(),
              DIV(),
              submit(),
            ],
          ),
        ),
      ),
      )
    );
  }
}