
import 'dart:core';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:far_glory_construction_register/datamodel/ServerFaceType.dart';
import 'package:far_glory_construction_register/datamodel/ServerSetting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cross_file_image/cross_file_image.dart';


class AddNewPage extends StatefulWidget {
  const AddNewPage({super.key});

  @override
  State<AddNewPage> createState() => _SampleViewState();
}

class _SampleViewState extends State<AddNewPage> {
  final dio = Dio();
  List<String> worktitle = <String>[""];
  List<String> workcompany = <String>[""];
  List<String> faceTypeID = <String>[""];
  List<String> faceTypeName = <String>[""];


  final _usernameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _workTitleController = TextEditingController();
  final _validDateController = TextEditingController();
  String _selectedWorktitle = '';


  @override
  void initState() {
    super.initState();
    //initCamera();
    loadSetting();
    loadFaceType();
  }

  /*
  {
"id": 82,
"var": "worktitle",
"val": "點工,板模,水泥,排水,電氣",
"type": "string",
"name": "工種",
"memo": ""
},
{
"id": 83,
"var": "workcompany",
"val": "榮工處,華雄營造,大林組,三重組",
"type": "string",
"name": "承包商",
"memo": ""
},
   */
  void loadSetting() async {
    var url = "http://192.168.0.109/api/v2/settings?pageSize=1000";
    var response = await dio.get(url);
    print('art find 2');
    setState(() {
      print('art find ' + response.toString() );

      ServerSetting setting = serverSettingFromJson(response.toString()) ;
      // var find = setting.result?.where((element) => (element.name=="工種") );
      // if(find!=null && find.isNotEmpty) {
      //   print('art find ' + find!.first.toString());
      // }
      worktitle = parseSetting(setting.result! , "工種");
      workcompany = parseSetting(setting.result! , "承包商");
      print('art find ' + worktitle.toString());
      print('art find ' + workcompany.toString());
      print('art find 3 workTitle');
    });

  }

  /*
 "id": 5,
"name": "遠雄營造 - 夏沐",
"threshold": 70,
"description": null,
"faceCount": 940,
"photoCount": 940,
"rtcEnabled": true,
"dynamic": true
  */
  void loadFaceType() async {
    var url = "http://192.168.0.109/api/v2/face-types?pageSize=1000";
    var response = await dio.get(url);
    setState(() {
      print('art find ' + response.toString() );

      ServerFaceType setting = serverFaceTypeFromJson(response.toString()) ;
      // var find = setting.result?.where((element) => (element.name=="工種") );
      // if(find!=null && find.isNotEmpty) {
      //   print('art find ' + find!.first.toString());
      // }
      if(setting!=null) {
        setting.result?.forEach((element) {
          faceTypeID.add(element.id!.toString());
          faceTypeName.add(element.name!.toString());
        });
        print('art find ' + faceTypeID.toString());
        print('art find ' + faceTypeName.toString());
        print('art find 3 faceType');
      }

    });


  }


  List<String> parseFaceTypeName(List<FaceType> result) {
    var faces =  <String>[];
    result.forEach((element) {
      faces.add(element.name!.toString());
    });
    return faces;
  }

  List<String> parseSetting(List<Setting> data, String name) {
    var find = data.where((element) => (element.name==name) );
    if(find!=null && find.isNotEmpty) {
      var val = find.first.val;
      if(val!=null) {
        return val.split(",");
      }
    }
    return <String>[];
  }



  Widget page() {
    //姓名 請填 電話號碼 工種 通勤期間 通勤區域 照片
    Widget col1 = Column(children: [
      TextFormField(
        controller: _usernameController,
        decoration: const InputDecoration(
          hintText: '姓名',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '請填姓名';
          }
        },
      ),
      SizedBox(height: 15,),
      TextFormField(
        controller: _phoneNumberController,
        decoration: const InputDecoration(
          hintText: '電話號碼',
        ),
      ),
      SizedBox(height: 15,),
    DropdownButton<String>(
    items: worktitle.map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
    value: value,
    child: Text(value),
    );
    }).toList(),
    onChanged: (String? newValue) {
    setState(() {
    _selectedWorktitle = newValue!;
    });
    },),

      TextFormField(
        controller: _workTitleController,
        decoration: const InputDecoration(
          hintText: '工種',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '請填工種';
          }
        },
      ),
      SizedBox(height: 15,),
      SizedBox(height: 15,),
      TextFormField(
        controller: _validDateController,
        decoration: const InputDecoration(
          hintText: '通勤期間',
        ),
      ),
      // SizedBox(height: 15,),
      // TextFormField(
      //   controller: _usernameController,
      //   decoration: const InputDecoration(
      //     hintText: '通勤區域',
      //   ),
      // ),
      SizedBox(height: 15,),
      Text( '照片', style: TextStyle(fontSize: 25,),),
      GestureDetector(
          onTap: () {
            print('art Icon is tapped!');
            //takePhoto();
            OpenPicker(ImageSource.camera);
          },
          child:  Container(
            padding: EdgeInsets.all(10.0), // Padding between the icon and the border
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // Border color
                width: 2.0, // Border width
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.camera_alt,
              size: 50.0,
            ),
          )
      ),
      if (xf != null)
        Container(
            width: 300,
            height: 300,
            child: Image(image: XFileImage(xf!))
        )

    ],);

    return col1;
  }


  XFile? xf = null;
  OpenPicker(ImageSource source) async
  {
    //print('art image go!');
    xf = await ImagePicker().pickImage(source: source);
    setState(() {
      if(xf!=null) {
        print('art image=' + xf!.path);
        //pickedImage = File(xf!.path);

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Image(image: XFileImage(xf!)),
                actions: <Widget>[
                  TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
        //print('art image ok?');
        Navigator.pop(context);
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    // print('art find 1');
    // if (!controller!.value.isInitialized) {
    //   return Container();
    // }
    print('art find 1 OK');
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text('新增工班人員'),
            ],
          )
        ),
        body: SingleChildScrollView(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: page(),
        ),
        )
    );
  }


  @override
  void dispose() {
    super.dispose();
  }


}