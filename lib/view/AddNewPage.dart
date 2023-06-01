
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:far_glory_construction_register/Utils/Utils.dart';
import 'package:far_glory_construction_register/datamodel/ServerFaceType.dart';
import 'package:far_glory_construction_register/datamodel/ServerSetting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cross_file_image/cross_file_image.dart';
import '../Constants.dart';
import '../FaceViewModel.dart';
import 'MainMenu.dart';
//import 'package:progress_dialog/progress_dialog.dart';


/*
  vendor:限定臉庫
  admin, root, faceadmin: 可選臉庫
  other: 沒有功能
 */
class AddNewPage extends StatefulWidget {
  const AddNewPage({super.key});

  @override
  State<AddNewPage> createState() => _SampleViewState();
}

class _SampleViewState extends State<AddNewPage> {
  FaceViewModel _viewModel = FaceViewModel();
  final dio = Dio();
  List<String> worktitle = <String>[""];
  //List<String> workcompany = <String>[""];
  List<String> faceTypeID = <String>[""];
  List<String> faceTypeName = <String>[""];

  final _usernameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _workTitleController = TextEditingController();
  final _validDateController = TextEditingController();
  String _selectedWorktitle = '';
  FaceType? _selectedFaceLib = null;

  XFile? xf = null;
  String? base64Image = null;
  List<FaceType> faceLibs = [];

  @override
  void initState() {
    super.initState();

    if(isAllowChooseFaceLib()) {
      loadFacelib();
      //showMsg(context, "loadFaceType()");
    } else {
      loadSetting();
    }

    setState(() {
      _validDateController.text = '2023/5/1 ~ 2023/7/31';

    });
  }

  bool isAllowChooseFaceLib() {
    return allowChooseUsers.contains(roleId);
  }

  Future<void> loadFacelib() async {
    var resp = await _viewModel.loadFaceType() ?? [];
    setState(() {
      faceLibs = resp;
      print('art 0527 load faceLib fnish');
    });
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
    var response = await dioV2Get(dio, "/api/v2/settings?pageSize=1000");
    setState(() {
      ServerSetting setting = serverSettingFromJson(response.toString()) ;

      //print('art debug ' + response.toString());
      worktitle = parseSetting(setting.result! , "工種");
      _selectedWorktitle = worktitle[0];
      //workcompany = parseSetting(setting.result! , "承包商");
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
          child:  ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: Image(image: XFileImage(xf!)),
          ),
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
        onLongPress: () {
          OpenPicker(ImageSource.gallery);
        },
        onTap: () {
          OpenPicker(ImageSource.camera);
        },
        child: w
    );
  }

  int getFaceId() {
    int facetypeId = vendorFaceTypeId;
    if(isAllowChooseFaceLib()) {
      facetypeId = _selectedFaceLib?.id ?? faceLibs[0].id!;
    }
    return facetypeId;
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

    int facetypeId = getFaceId();

    FocusManager.instance.primaryFocus?.unfocus(); //for hide keyboard

    List<int> imageBytes = await XFileImage(xf!).file.readAsBytes();
    base64Image = base64Encode(imageBytes);
    base64Image = base64Image!.replaceAll(RegExp(r'\s'), '');
    saveFile(base64Image!);

    List<dynamic> result = await _viewModel.getSimilarImage(base64Image!, facetypeId);
    print('art await getQuerytokenByImage ' + result.toString());
    if(result.isEmpty) {
      sendReg();
    } else {
      showSimilarDialog(context, result);
    }



  }

  String maskName(String name) {
    if(name.length<3) return name;
    return "${name.substring(0,1)} * ${name.substring(2)}";
  }
  String format(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 2);
  }
  String makeText(Map<String,dynamic> map) {
    return maskName(map['person'].toString()) + "\n" + format(map['similarity'] as double) + "%";
  }

  void showSimilarDialog(BuildContext context, List<dynamic> items) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    Widget w = ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(children: [
          Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: getUrlImage2( makeUrl((items[index] as Map<String,dynamic>)["photo"].toString()),120 ),
            ),
            const SizedBox(width: 10,),
            Center(child: Text( makeText(items[index] as Map<String,dynamic>) ),),
          ],
        ),
          const SizedBox(height: 10,),
        ]);

      },
    );

    Widget box = SizedBox(height: height*0.7,
        width: width * 0.9,
      child: w,);

    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: const Text('已有相似資料'),
        content: box,
        actions: <Widget>[
          BasicDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            title: const Text('取消'),
          ),
          BasicDialogAction(
            onPressed: () {
              gotoAdd(items[0]);
            },
            title: const Text('在既有紀錄加臉'),
          ),
        ],
      ),
    );
  }

  Future<void> gotoAdd(dynamic item) async {
    print('art input ' + item.toString());
    var result = await _viewModel.goAddFace(item, base64Image!);
    if(result!="OK") {
      showMsg(context, result);
      Navigator.of(context).pop();
    } else {
      exitDailog('加臉成功');
    }
  }

  void exitDailog(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(msg),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                dismissDialogThenBack();
              },
            ),
          ],
        );
      },
    );

  }


  Future<void> sendReg() async {
    // show the loading dialog
    showDialog(
      // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return const Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Loading...')
                ],
              ),
            ),
          );
        });

    int faceTypeid = getFaceId();
    var params =  {
      "company": vendorAccount,
      "enabled": true,
      "faceTypeId": faceTypeid,
      "name": _usernameController.text,
      "phone": _phoneNumberController.text,
      "photoInBase64String": base64Image,
      "title": _selectedWorktitle,
    };
    if(isAllowChooseFaceLib()) {
      params =  {
        "enabled": true,
        "faceTypeId": faceTypeid,
        "name": _usernameController.text,
        "phone": _phoneNumberController.text,
        "photoInBase64String": base64Image,
      };
    }
    print(params);

    Response response = await dioV2post(dio, '/api/face/photoString', params);

    Navigator.pop(context);

    setState(() {
      print('art response '+ response.statusCode.toString() +', ' + response.toString());
      if(response.toString()==null) {
        showMsg(context, '新增失敗, 照片有誤');
        return;
      }
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
                      dismissDialogThenBack();
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
    });
  }

  void dismissDialogThenBack() {
    Navigator.of(context).pop();
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => const MainMenuPage()),
    );
  }


  Widget vendorPage() {
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

  Widget faceLibPage() {
    var pick = _selectedFaceLib;
    if(faceLibs.length>0 && _selectedFaceLib==null ) pick = faceLibs[0];

    Widget col1 = Column(children: [
        Row(children: [
          Text('*臉庫', style: TextStyle(fontSize: 18,)),
          SizedBox(width: 30,),
          DropdownButton<FaceType>(
            items: faceLibs.map<DropdownMenuItem<FaceType>>((FaceType value) {
              return DropdownMenuItem<FaceType>(
                value: value,
                child: Text(value.name!),
              );
            }).toList(),
            value: pick ,
            onChanged: (FaceType? newValue) {
              setState(() {
                _selectedFaceLib = newValue!;
              });
            },),
        ],),

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
      child: const Text('新增'),
    );
    Widget btn2 = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey, // background
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('取消'),
    );
    return Row(children: [
      Expanded(flex: 1,child: btn1,),
      const SizedBox(width: 5,),
      Expanded(flex: 1,child: btn2,),
    ],);
  }

  Widget DIV() {
    return SizedBox(height: 20,);
  }

  debugImage() async {

  }

  //處理拍照
  OpenPicker(ImageSource source) async
  {


    //print('art image go!');
    xf = await ImagePicker().pickImage(source: source,
        maxWidth: 400,
        imageQuality: 50);

    Uint8List imageBytes;
    if(source == ImageSource.camera) {
      File rotatedImage =  await FlutterExifRotation.rotateImage(path: xf!.path);
      imageBytes = await rotatedImage.readAsBytes();
    } else {
      imageBytes = await XFileImage(xf!).file.readAsBytes();
    }
    base64Image = base64Encode(imageBytes);
    //base64Image = base64Image!.replaceAll(RegExp(r'\s'), '');
    //saveFile(base64Image!);

    setState(() {
      if(xf!=null) {
        print('art image=' + xf!.path);




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
    Widget w;
    String _title = "";
    if (isAllowChooseFaceLib()) {
      _title = '新增人員';
      w = faceLibPage();
    }
    else {
      _title = '新增工班人員';
      w = vendorPage();
    }

    return Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                Text(_title),
              ],
            )
        ),
        body: SingleChildScrollView(child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: w,
        ),
        )
    );
  }


  @override
  void dispose() {
    super.dispose();
  }


}