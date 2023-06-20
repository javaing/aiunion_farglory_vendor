
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:far_glory_construction_register/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Utils/Utils.dart';
import 'ModifyPage.dart';


class EmployeeList extends StatefulWidget {
  const EmployeeList({super.key});

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {

  Dio dio = Dio();


  @override
  void initState() {
    super.initState();

  }

  Future<List<dynamic>?> getData() async {
    var url = 'http://$HOST/api/faces?typeId=$vendorFaceTypeId&pageSize=999';
    //debugPrint('art call get facelib $url');
    var response = await http.get(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader: "Bearer $v1token"
        });
    //debugPrint('art call get facelib 0');
    //debugPrint(response.body);
    var map = jsonDecode(response.body);
    //debugPrint('art call get facelib 1');
    if (map['code'] == 200) {
      var list = map['result'];
      //debugPrint('art call get facelib ${list.toString()}');
      return list;
    } else {
      //debugPrint('art call get facelib fail! code: ${response.statusCode}');
      return null;
    }
  }


  Widget getGridCell(String photo, String name) {
    return Container(
      //color: Colors.green, // color of grid items
      child: Center(
        child:Column(children: [
          SizedBox(height: 0,),
          Expanded(child: getUrlImage2(makeUrl(photo),150)),
          Text(name ?? "my name",
            style: TextStyle(fontSize: 18.0, color: Colors.blue),
          ),],),

      ),
    );
  }

  Widget projectW() {
    return FutureBuilder<List<dynamic>?>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            // return ListView.builder(
            //   itemCount: snapshot.data!.length,
            //   itemBuilder: (context, index) {
            //     return Text(snapshot.data?[index]['person'] ?? "got null");
            //   },
            // );


            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:2, // number of items in each row
                mainAxisSpacing: 8.0, // spacing between rows
                crossAxisSpacing: 8.0, // spacing between columns
              ),
              padding: const EdgeInsets.all(8.0), // padding around the grid
              itemCount: snapshot.data!.length, // total number of items
              itemBuilder: (context, index) {
                var model = snapshot.data?[index];
                return GestureDetector(
                  child: getGridCell(model['photo'], model['person']),
                  onTap: () => {
                    //showMsg(context, "Tap")
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ModifyPage(profile: model,),
                    ))

                  }, //点击
                );
              },
            );

          }
          else {
            return const Center(child: CircularProgressIndicator(),);
          }
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(vendorFacetypeName),
      ),
      body: Container(
    //color: Colors.black, // color of grid items
    child:projectW(),),
    );
  }



  @override
  void dispose() {
    super.dispose();
  }


}