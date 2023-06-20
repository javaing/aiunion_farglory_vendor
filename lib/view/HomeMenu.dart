
import 'dart:convert';

import 'package:far_glory_construction_register/Utils/Utils.dart';
import 'package:far_glory_construction_register/view/EmployeeList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../Constants.dart';
import '../FaceViewModel.dart';
import 'AddNewPage.dart';

/*
  vendor:限定臉庫
  admin, root, faceadmin: 可選臉庫
  other: 沒有功能
 */
class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _SampleViewState();
}

class _SampleViewState extends State<MainMenuPage> {
  FaceViewModel _viewModel = FaceViewModel();
  String _title = '歡迎使用';



  @override
  initState() {
    super.initState();

    if(_title == '歡迎使用') {
      _viewModel.loadUserName().then((value) { //ask facetype id, verdor name
        setState(() {
          //print('art 3' + value);
          if(value=="OK")
            _title = roleName;
        });
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    //print('art 0' +_title) ;
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30,0,30,0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20,),

          SizedBox(
              width: double.infinity,
              height: 75,
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink.shade200, // background
                ),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddNewPage()),
                  );
                },
                child: textWithIcon(Icons.man, '新增人員'),
              ),
          ),


            SizedBox(height: 25,),
        SizedBox(
          width: double.infinity,
            height: 75,
          child:
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey, // background
            ),
              onPressed: () {
                //showMsg(context, "功能製作中");
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EmployeeList()),
                );
              },
              child: textWithIcon(Icons.edit, '表列人員'),
            )),
            SizedBox(height: 25,),
        SizedBox(
          width: double.infinity,
            height: 75,
          child:
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey, // background
            ),
              onPressed: () {
                showMsg(context, "功能製作中");
              },
              child: textWithIcon(Icons.settings, '更多設定'),
            )),
          ],
        ),
      ),
    );
  }


  Widget textWithIcon(IconData icon, String text) {
    return Row(children: [
      Icon(
        icon, size: 50,
      ),
      Text(text, style: const TextStyle(fontSize: 25),)],);
  }

  @override
  void dispose() {
    super.dispose();
  }
  

}