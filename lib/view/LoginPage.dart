

import 'dart:convert';
import 'dart:io';

import 'package:far_glory_construction_register/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../Constants.dart';
import '../datamodel/V1LoginResponse.dart';
import 'AddNewPage.dart';
import 'MainMenu.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final dio = Dio();

  FullScreenDialog _myDialog = new FullScreenDialog();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    _usernameController.text = default_user;
    _passwordController.text = default_pass;
  }

  Future<bool> checkNetwork() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      // I am connected to a ethernet network.
    } else if (connectivityResult == ConnectivityResult.vpn) {
      // I am connected to a vpn network.
      // Note for iOS and macOS:
      // There is no separate network interface type for [vpn].
      // It returns [other] on any device (also simulator)
    } else if (connectivityResult == ConnectivityResult.bluetooth) {
      // I am connected to a bluetooth.
    } else if (connectivityResult == ConnectivityResult.other) {
      // I am connected to a network which is not in the above mentioned networks.
    } else if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  Widget welcome() {
    Widget w1 = Image.asset(
      'images/farbackbig.jpg',
      width: double.infinity,
    );

    Widget w2 = const Text('歡迎使用AI臉辨平台\n註冊系統', style: TextStyle(
      fontSize: 26,
      color: Colors.black87,
    ),);

    //change host
    Widget gest = GestureDetector(
        onTap: () {
          Navigator.push(context, new MaterialPageRoute(
            builder: (BuildContext context) => _myDialog,
            fullscreenDialog: true,
          ));
        },
        child: w1
    );

    return Column(children: [
      gest, w2
    ],);
  }

  //歡迎使用智慧工地平台
  Widget InputAccount() {
    return Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: TextFormField(
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
      ),);

  }

  Widget InputPassword() {
    return Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: TextFormField(
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
      ),);
  }

  Future<void> v1login(String acct, String pwd) async {
    //@POST("/api/v1/session/login")
    //Observable<LoginResult> v1login(@Body LoginBody loginBody);
    //{"type":"manager","username":"admin","password":"admin","remember":true}
    //{"code": 200, "result": {"token": "2d4db94a241e4be9eb2be3e6651eb7a6"}}
    Map<String, dynamic> param ={"type":"manager","username":acct,"password":pwd,"remember":true};
    try {
      var response = await dioV1postNoToken(dio,
          '/api/v1/session/login',
          param);
      print("art response=" +response.toString());
      V1LoginResponse v1 = v1LoginResponseFromJson(response.toString());
      if(v1.code==200) {
        if(v1.result!.token != null) {
          print("art token=" + v1.result!.token!);
          v1token = v1.result!.token!;
          vendorAccount = acct;
          gotoNextPage();
          //v2login(acct, pwd);
        } else {
          show("登入失敗 login in fail");
        }
      } else {

        show(response.toString());
      }

    } catch (e) {
      print(e);
      show("請確定網路連線");
    }

  }

  Future<void> v2login(String acct, String pwd) async {
    //{"type":"manager","username":"admin","password":"admin","remember":true}
    //{"code": 200, "result": {"token": "2d4db94a241e4be9eb2be3e6651eb7a6"}}
    Map<String, dynamic> param ={"type":"manager","username":acct,"password":pwd,"remember":true};
    try {
      var response = await dioV2PostNoToken(dio,
          '/api/v2/session/login',
          param);
      print("art response=" +response.toString());
      Map<String, dynamic> v1 = jsonDecode(response.toString());
      if(v1['code']==200) {
        var token = v1['result']['token'];
        if(token != null) {
          print("art v2 token=" + token);
          V2_TOKEN = token;
          vendorAccount = acct;
          //gotoNextPage();
        } else {
          show("登入失敗 login in fail");
        }
      } else {
        show(response.toString());
      }
      gotoNextPage();
    } catch (e) {
      print(e);
      show("請確定網路連線");
    }

  }

  void show(String msg) {
    showMsg(context, msg);
  }

  void gotoNextPage() {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => const MainMenuPage()),
    );
  }

  Widget submit() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          v1login(_usernameController.text, _passwordController.text);
        }
      },
      child: const Text('登入',style: TextStyle(
        fontSize: 22,
      )),
    );
  }

  Widget DIV() {
    return const SizedBox(height: 20.0);
  }

  @override
  Widget build(BuildContext context) {
    Widget col1 = Column(
      children: <Widget>[
        welcome(),
        DIV(),
        InputAccount(),
        DIV(),
        InputPassword(),
        DIV(),
        submit(),
        DIV(),
        //Expanded(child: Text(HOST.substring(HOST.length-4), style: const TextStyle(fontSize: 14))),
      ],
    );


    return Scaffold(
        appBar: AppBar(
        title: Text('臉辨註冊  $version'),
    ),
        resizeToAvoidBottomInset: false,
    body: Form(
    key: _formKey,
    child: Column(
    children: <Widget>[
    Expanded(child: Container(child: col1,)),
    assetImageWidth('land_logo.png', 150),
    //Expanded(child: assetImageWidth('land_logo.png', 300)),
    ],
    ),)
    );
  }
}

class FullScreenDialog extends StatefulWidget {
  String _skillOne = "You have";
  String _skillTwo = "not Added";
  String _skillThree = "any skills yet";

  @override
  FullScreenDialogState createState() => new FullScreenDialogState();
}

class FullScreenDialogState extends State<FullScreenDialog> {
  TextEditingController _skillOneController = new TextEditingController();
  TextEditingController _skillTwoController = new TextEditingController();

  TextEditingController _skillThreeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _skillThreeController.text = HOST;
    return Scaffold(
        appBar: AppBar(
          title: Text("Setting"),
        ),
        body: Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0),child: ListView(
          children: <Widget>[
            Text('HOST',),
            TextField(controller: _skillThreeController,),
            Row(
              children: <Widget>[
                Expanded(child: TextButton(onPressed: () {
                  HOST = _skillThreeController.text;
                  widget._skillTwo = _skillTwoController.text;
                  widget._skillOne = _skillOneController.text;
                  Navigator.pop(context);
                }, child: const Text("Save"),))
              ],
            )
          ],
        ),)
    );
  }


}