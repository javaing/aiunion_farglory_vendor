
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:far_glory_construction_register/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Utils/Utils.dart';


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
    print('art call get facelib $url');
    http.Response response = await http.get(Uri.parse(url));
    var map = jsonDecode(response.toString());
    print('art call get facelib 1');
    if (map['code'] == 200) {
      var list = map('result');
      print('art call get facelib ${list.toString()}');
      return list;
    } else {
      print('art call get facelib fail! code: ${response.statusCode}');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(vendorFacetypeName),
      ),
      body: FutureBuilder<List<dynamic>?>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Text(snapshot.data?[index]['name'] ?? "got null");
                },
              );
            }

            /// handles others as you did on question
            else {
              return Center(child: CircularProgressIndicator(),);
            }
          }),
    );
  }



  @override
  void dispose() {
    super.dispose();
  }


}