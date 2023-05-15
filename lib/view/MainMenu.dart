
import 'package:far_glory_construction_register/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AddNewPage.dart';


class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _SampleViewState();
}

class _SampleViewState extends State<MainMenuPage> {



  @override
  void initState() {
    super.initState();
    
  }


  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text('包商管理'),
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
                showMsg(context, "功能製作中");
              },
              child: textWithIcon(Icons.edit, '修改/刪除人員'),
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