
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import 'Constants.dart';

class FaceViewModel {
  final dio = Dio();


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
  // void loadFaceType() async {
  //   var url = "http://192.168.0.109/api/v2/face-types?pageSize=1000";
  //   var response = await dio.get(url);
  //   setState(() {
  //     //print('art find ' + response.toString() );
  //
  //     ServerFaceType setting = serverFaceTypeFromJson(response.toString()) ;
  //
  //     if(setting!=null) {
  //       setting.result?.forEach((element) {
  //         faceTypeID.add(element.id!.toString());
  //         faceTypeName.add(element.name!.toString());
  //       });
  //       //print('art find ' + faceTypeID.toString());
  //       //print('art find ' + faceTypeName.toString());
  //       //print('art find 3 faceType');
  //       if(vendorName.isEmpty) {
  //         vendorName = faceTypeName[1];
  //         vendorFaceTypeId = faceTypeID[1];
  //       }
  //     }
  //
  //   });
  //
  // }


  Future<String> loadUserName() async {
    /*
    "result": [
{
"id": 9,
"username": "vendor2",
"name": "vendor2",
"phone": "",
"address": "",
"title": "",
"enabled": true,
"roleId": 9,
"roleName": "供應商管理員",
"email": "",
"memo": "",
"faceTypeIds": "6",
"faceTypes": [
{
"id": 6,
"name": "遠雄營造 - 冬至",
"rtc_enabled": true,
"threshold": 75,
"created_at": 1684309408000,
"updated_at": null,
"deleted_at": 0,
"memo": "",
"face_count": 0,
"dynamic": true
}
],
"face": null
},
     */
    var response = await dio.get(makeUrl('/api/users/'));
    Map map = jsonDecode(response.toString());
    //print("art map=" + map.toString());
    var code = map["code"];
    print("art find=${response.statusCode}" );
    print("art find=${map["result"]}" );
    if(response.statusCode==200) {
      List result = map["result"];
      //print("art result=" + result.toString());
      var find = result.where((element) => element["name"]==vendorAccount);
      //print("art find=" + find.first["faceTypeIds"]);
      List faces = find.first["faceTypes"];
      print("art find=$faces");
      print("art find name=" + faces.first['name']);
      vendorName = faces.first['name'];
      vendorFaceTypeId = faces.first['id'];
      return vendorName;
    } else {
      return "";
    }
  }

  Future<List<dynamic>> getSimilarImage(String imageString) async {
    var params =  {
      "photo": imageString,
      "threshold": 85,
    };
    //{"code": 200, "result": {"query_token": 694}}
    var response = await dio.post(makeUrl('/api/v1/query'),
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $v1token",
      }),
      data: jsonEncode(params),);
    //print('art getQuery-tokenByImage $response');
    if(response.statusCode==200) {
      Map map = jsonDecode(response.toString());
      var queryToken = map['result']["query_token"];
      return getSimilarFace(queryToken);
    }
    return List.empty();
  }

  /*
    {
"status": "processed",
"code": 200,
"result": [
{
"host_tel": "",
"status": "pending",
"type_id": 37,
"autoid": 1957,
"photo": "/static/face/photo/1957/c/e9/950/3daf/76d06b518a12ce0d77abf1.jpg",
"serial_no": "",
"host_eng_name": "",
"recognized_times": 0,
"host_department": "",
"id": "737c89ee786555df8c7294af7ff4bf5b",
"lob": "",
"card_serial_no": "",
"title": "點工",
"similarity": 89.4645004272461,
"pass_categories": "",
"department": {},
"pass_devices": "",
"company": "榮工處",
"email": "",
"host_name": "",
"website": "",
"category": "common",
"customize": "",
"memo": "",
"phone": "",
"face_type": {
"rtc_enabled": true,
"id": 37,
"name": "耀祖"
},
"identity": "",
"pass_started_at": 0,
"dob": "",
"gender": "u",
"created_at": 1684315742000,
"greeting_msg": "",
"enabled": true,
"photos": [
{
"status": "processed",
"photo": "/static/face/photo/1957/c/e9/950/3daf/76d06b518a12ce0d77abf1.jpg",
"memo": "",
"face_id": 1957,
"quality": 89.2,
"id": 2000
}
],
"pass_ended_at": 0,
"person": "art",
"avatar": "#",
"tenant_id": 0
},
     */
  Future<List<dynamic>> getSimilarFace(int queryToken) async {
    // api/v1/query/{queryTokn}
    var response = await dio.get(makeUrl('/api/v1/query/$queryToken'));
    if(response.statusCode==200) {
      Map map = jsonDecode(response.toString());
      List result = map["result"];
      print('art getSimilarFace size=${result.length} $result');
      return result;
    }
    return List.empty();
  }

  List<Object> photosToObjects(List<dynamic> photos) {
    List<Object> myPhotos = [];
    for (int i = 0; i < photos.length; i++) {
      myPhotos.add(photos[i]['id']);
    }
    return myPhotos;
  }


  Future<String> goAddFace(dynamic data, String base64Image) async {
    List ll = data['photos'];
    print('art size=${ll.length}');
    List photos = photosToObjects(ll);
    if(photos.length>=3)
      photos = photos.sublist(0,2);
    photos.add(base64Image);
    print('art size=${photos.length}   $photos');

    var params =  {
      "company": data['company'],
      "enabled": data['enabled'],
      "typeId": data['type_id'],
      "name": data['person'],
      "phone": data['phone'],
      "photos": photos,
      "title": data['title'],
      'identity':data['identity'],
      'serialNo':data['serial_no'],

    };
    print(params);

    Response response = await dio.put('http://$HOST/api/faces/'+data['autoid'].toString(),
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
      },),
      data: jsonEncode(params),
    );
    print(response);
    Map map = jsonDecode(response.toString());
  if(map['code']==200) {
    return "OK";
  } else {
    return map['message'] ?? response.statusCode.toString();
  }


  }

}