import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Constants.dart';


void showMsg(BuildContext context,String msg) {
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          elevation: 4,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          content: Text(style: const TextStyle(fontSize: 22), msg),
          actions: <Widget>[
            TextButton(
              child: const Text(style: TextStyle(fontSize: 22),"OK"),
              onPressed: (){
                //Navigator.of(context).pop();
                Navigator.pop(context,true);
              },)
          ],
        );
      }
  );
}

String formatDateTime(DateTime dateTime) {
  return DateFormat('yyyy/MM/dd hh:mm:s').format(dateTime);
}

String getformatNow() {
  final DateTime now = DateTime.now();
  return formatDateTime(now);
}

String getHHMM() {
  final DateTime now = DateTime.now();
  return DateFormat('hh:mm').format(now);
}

String formatDateTimeDashBoard(DateTime now) {
  String name = getLocaleWeekDay(now.weekday);
  return DateFormat('yyyy/MM/dd hh:mm:s')
      .format(now)
      .replaceAll(" ", " \n$name ");
}

String formatTimeDashBoard(DateTime now) {
  String name = getLocaleWeekDay(now.weekday);
  return DateFormat(' hh:mm:s')
      .format(now)
      .replaceAll(" ", " \n$name ");
}

Widget loadUrlImage(String url, double width) {
  if(url.contains("svg")) {
    return  SvgPicture.network(
      url,
      semanticsLabel: 'A shark?!',
      placeholderBuilder: (BuildContext context) => Container(
          padding: const EdgeInsets.all(30.0),
          child: const CircularProgressIndicator()),
    );
  } else {
    return getUrlImage2(url, width);
  }

}

Image getUrlImage2(String imagePath, double width) {
  return Image.network(
    imagePath,
    fit: BoxFit.cover,
    //height: 300, // set your height
    width: width, // and width here
  );
}

Image getUrlImage(String imagePath) {
  return getUrlImage2(imagePath, 300);
  // return Image.network(
  //   imagePath,
  //   fit: BoxFit.cover,
  //   height: 300, // set your height
  //   width: 300, // and width here
  // );
}

Image getAssetImage(String name) {
  return getAssetImageSize(name, 300);
}

Image getAssetImageSize(String name, double size) {
  return Image.asset(
    'images/$name',
    width: size,
    height: size,
    fit: BoxFit.contain,
  );
}

Image assetImageWidth(String name, double size) {
  return Image.asset(
    'images/$name',
    width: size,
    fit: BoxFit.contain,
  );
}

String getLocaleWeekDay(int weekday) {
  List<String> name = ['', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六','星期日'];
  return name[weekday % name.length];
}

List<String> toStringList(List<int> intList) {
  List<String> myList = [];
  for (var element in intList) {
    myList.add(element.toString());
  }
  return myList;
}

T randomListItem<T>(List<T> lst) {
  Random rnd = Random();
  return lst[rnd.nextInt(lst.length)];
}


Future<String?> networkImageToBase64(String imageUrl) async {
  http.Response response = await http.get(Uri.parse(imageUrl));
  if (response.statusCode == 200) {
    final bytes = response?.bodyBytes;
    if (bytes != null) {
      String encodedString = base64Encode(bytes);
      return encodedString;
    } else {
      return null;
    }
  } else {
    print('art call $imageUrl fail! code: $response.statusCode');
    return null;
  }
}

String makeUrl(String path) {
  print("http://" + HOST + path);
  return "http://" + HOST + path;
}

Future<Response> dioV2Get(Dio dio, String path) {
  return dio.get(makeUrl(path),
    options: Options(headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $V2_TOKEN"
    }, validateStatus: (statusCode){
      if(statusCode == null){
        return false;
      }
      if(statusCode == 400||statusCode == 405||statusCode == 500){ // your http status code
        return true;
      }else{
        return statusCode >= 200 && statusCode < 300;
      }
    },),);
}

Future<Response> dioV1Get(Dio dio, String path) {
  return dio.get(makeUrl(path),
    options: Options(headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $v1token"
    }, validateStatus: (statusCode){
      if(statusCode == null){
        return false;
      }
      if(statusCode == 400||statusCode == 404||statusCode == 405||statusCode == 500){ // your http status code
        return true;
      }else{
        return statusCode >= 200 && statusCode < 300;
      }
    },),
  );
}

Future<Response> dioV1postNoToken(Dio dio, String path, Map<String, dynamic> param) {
  print('art v1token=' + v1token);
  return dio.post(makeUrl(path),
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }, validateStatus: (statusCode){
        if(statusCode == null){
          return false;
        }
        if(statusCode == 400||statusCode == 404||statusCode == 405||statusCode == 500){ // your http status code
          return true;
        }else{
          return statusCode >= 200 && statusCode < 300;
        }
      },),
      data: param);
}

Future<Response> dioV1post(Dio dio, String path, Map<String, dynamic> param) {
  //print('art v1token=' + v1token);
  print('art param=' + param.toString());

  saveFile( jsonEncode(param));
  

  return dio.post(makeUrl(path),
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $v1token"
      }, validateStatus: (statusCode){
        if(statusCode == null){
          return false;
        }
        if(statusCode == 400||statusCode == 404||statusCode == 405||statusCode == 500){ // your http status code
          return true;
        }else{
          return statusCode >= 200 && statusCode < 300;
        }
      },),
      data: param);
}

Future<Response> dioV2PostNoToken(Dio dio, String path, Map<String, dynamic> param) {
  return dio.post(makeUrl(path),
    options: Options(headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      //HttpHeaders.authorizationHeader: "Bearer " + V2_TOKEN
    }, validateStatus: (statusCode) {
      if (statusCode == null) {
        return false;
      }
      if (statusCode == 400 || statusCode == 409 ||
          statusCode == 500) { // your http status code
        return true;
      } else {
        return statusCode >= 200 && statusCode < 300;
      }
    },),
    data: param,
  );
}

Future<Response> dioV2post(Dio dio, String path, Map<String, dynamic> param) {
  return dio.post(makeUrl(path),
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
    data: param,
  );
}

_write(String text) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final File file = File('${directory.path}/test.txt');
  await file.writeAsString(text);
}

Future<String> getFilePath() async {
  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
  String appDocumentsPath = appDocumentsDirectory.path; // 2
  String filePath = '$appDocumentsPath/test123.txt'; // 3

  return filePath;
}

void saveFile(String str) async {
  File file = File(await getFilePath()); // 1
  file.writeAsString("This is my demo text that will be saved to : demoTextFile.txt"); // 2
}