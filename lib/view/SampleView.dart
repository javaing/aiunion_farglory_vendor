
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SampleView extends StatefulWidget {
  const SampleView({super.key});

  @override
  State<SampleView> createState() => _SampleViewState();
}

class _SampleViewState extends State<SampleView> {



  @override
  void initState() {
    super.initState();
    
  }


  
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30,0,30,0),
        child: Text('Hello'),
      ),
    );
  }



  @override
  void dispose() {
    super.dispose();
  }
  

}