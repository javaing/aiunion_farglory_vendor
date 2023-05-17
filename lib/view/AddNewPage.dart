
import 'dart:convert';
import 'dart:core';
import 'dart:io' as Io;
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:far_glory_construction_register/Utils/Utils.dart';
import 'package:far_glory_construction_register/datamodel/ServerFaceType.dart';
import 'package:far_glory_construction_register/datamodel/ServerSetting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cross_file_image/cross_file_image.dart';
import '../Constants.dart';
import 'MainMenu.dart';
//import 'package:progress_dialog/progress_dialog.dart';


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

  XFile? xf = null;
  String? base64Image = null;


  @override
  void initState() {
    super.initState();
    //initCamera();
    loadSetting();
    loadFaceType();
    _validDateController.text = '2023/5/1 ~ 2023/7/31';
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
   */
  void loadSetting() async {
    var url = "http://192.168.0.109/api/v2/settings?pageSize=1000";
    var response = await dio.get(url);
    setState(() {
      ServerSetting setting = serverSettingFromJson(response.toString()) ;

      worktitle = parseSetting(setting.result! , "工種");
      workcompany = parseSetting(setting.result! , "承包商");

      _selectedWorktitle = worktitle[0];
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
      //print('art find ' + response.toString() );

      ServerFaceType setting = serverFaceTypeFromJson(response.toString()) ;

      if(setting!=null) {
        setting.result?.forEach((element) {
          faceTypeID.add(element.id!.toString());
          faceTypeName.add(element.name!.toString());
        });
        //print('art find ' + faceTypeID.toString());
        //print('art find ' + faceTypeName.toString());
        //print('art find 3 faceType');
        if(vendorName.isEmpty) {
          vendorName = faceTypeName[1];
          vendorFaceTypeId = faceTypeID[1];
        }
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

  Widget preparePhoto() {
    Widget w;
    if (xf != null) {
      w = SizedBox(
          width: 120,
          //height: 200,
          child: Image(image: XFileImage(xf!))
      );
    } else {
      w =  Container(
        padding: EdgeInsets.all(10.0),
        // Padding between the icon and the border
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey, // Border color
            width: 2.0, // Border width
          ),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.camera_alt,
          size: 50.0,
        ),
      );
    }

    return GestureDetector(
        onTap: () {
          OpenPicker(ImageSource.camera);
        },
        child: w
    );
  }


  void postToserver() async {
    //check
    if(_usernameController.text.isEmpty) {
      showMsg(context, '姓名未填');
      return;
    }
    if(_selectedWorktitle==null) {
      showMsg(context, '工種未選');
      return;
    }
    if(xf==null) {
      showMsg(context, ' 照片未拍');
      return;
    }

    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    List<int> imageBytes = await XFileImage(xf!).file.readAsBytes();
    base64Image = base64Encode(imageBytes);

    var params =  {
      "company": vendorName,
      "enabled": true,
      "faceTypeId": int.parse(vendorFaceTypeId),
      "name": _usernameController.text,
      "phone": _phoneNumberController.text,
      "photoInBase64String": base64Image,
      "title": _selectedWorktitle,
    };
    //print(params);

    Response response = await dio.post('http://$HOST/api/face/photoString',
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + V2_TOKEN
      }, validateStatus: (statusCode){
          if(statusCode == null){
            return false;
          }
          if(statusCode == 400||statusCode == 409||statusCode == 500){ // your http status code
            return true;
          }else{
            return statusCode >= 200 && statusCode < 300;
          }
        },),
      data: jsonEncode(params),
    );

    Navigator.pop(context);

    // Close the dialog programmatically
    // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning
    //if (!mounted) return;

    setState(() {
    print('art response '+ response.statusCode.toString() +', ' + response.toString());
    if(response.statusCode==200) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('新增成功'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MainMenuPage()),
                    );
                  },
                ),
              ],
            );
          });
    } else if(response.statusCode==400) {
      showMsg(context, '新增失敗, 照片有誤');
    } else {
      showMsg(context, '新增失敗 ' +(response.statusMessage??"") );
    }
    //Navigator.of(context).pop();

    });


    // var resp = jsonDecode(response.toString());
    // if(resp.containsKey('id') && resp.containsKey('photoUri')) {
    //   //showMsg(context, '新增成功');
    //
    //
    //
    // } else {
    //   showMsg(context, '新增失敗');
    // }


  }



  Widget page() {
    //姓名 請填 電話號碼 工種 通勤期間 通勤區域 照片
    Widget col1 = Column(children: [
      TextFormField(
        controller: _usernameController,
        decoration: const InputDecoration(
          hintText: '*姓名',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '請填姓名';
          }
        },
      ),
      DIV(),

      TextFormField(
        controller: _phoneNumberController,
        decoration: const InputDecoration(
          hintText: '電話號碼',
        ),
      ),
      DIV(),
      Row(children: [
        Text('*工種', style: TextStyle(fontSize: 18,)),
        SizedBox(width: 30,),
        DropdownButton<String>(
          items: worktitle.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          value: _selectedWorktitle,
          onChanged: (String? newValue) {
            setState(() {
              _selectedWorktitle = newValue!;
            });
          },),
      ],),

      // TextFormField(
      //   controller: _workTitleController,
      //   decoration: const InputDecoration(
      //     hintText: '工種',
      //   ),
      //   validator: (value) {
      //     if (value == null || value.isEmpty) {
      //       return '請填工種';
      //     }
      //   },
      // ),
      // SizedBox(height: 15,),
      DIV(),
      Row(children: [
        Text( '*通勤期間', style: TextStyle(fontSize: 18,),),
      ],),
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
      DIV(),
      Row(children: [
        Text( '*照片', style: TextStyle(fontSize: 18,),),
      ],),
      preparePhoto(),
      DIV(),
      prepareBottom(),
      // if(base64Image!=null)
      //   Center(
      //     child: Image.memory(base64Decode(base64Image!)),
      //   ),

    ],);

    return col1;
  }


  Widget prepareBottom() {
    Widget btn1 = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green.shade200, // background
      ),
      onPressed: () {
        postToserver();
      },
      child: Text('新增'),
    );
    Widget btn2 = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey, // background
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('取消'),
    );
    return Row(children: [
      Expanded(child: btn1, flex: 1,),
      SizedBox(width: 5,),
      Expanded(child: btn2, flex: 1,),
    ],);
  }

  Widget DIV() {
    return SizedBox(height: 20,);
  }

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