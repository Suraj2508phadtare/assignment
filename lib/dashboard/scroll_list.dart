import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widgets_demo/constant_variable/constant_var.dart';
import 'package:flutter_widgets_demo/dashboard/alphabet_list_scroll_view.dart';
import 'package:flutter_widgets_demo/user_details_screen/user_details.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List employeeName = [];
  List<String> name = [];
  List<String> images = [];

  @override
  void initState() {
    loadingData();
    super.initState();
  }

  Future<void> loadingData() async {
    final String response = await rootBundle.loadString('assets/employee.json');
    final data = await json.decode(response);

    setState(() {
      employeeName = data;
      print("debugLength :: " + employeeName.length.toString());
      addDataList();
    });
  }

  void addDataList() {
    for (int i = 0; i < employeeName.length; i++) {
      name.add(
          employeeName[i]['firstName'] + ' ' + employeeName[i]['lastName']+':'+employeeName[i]['id'].toString());
      images.add(employeeName[i]['imageUrl'].toString());
      //print("debugList : " + name[i]);
      print("debugList : " + images[i].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employee List"),
        centerTitle: true,
      ),
      body: AlphabetScrollPage(
        items: name,
        images: images,
        // onClickedItem: (value) {
          
        // },
        
        onClickedItem: (String value) {
          final snackbar = SnackBar(
              content: Text(
            "Clicked Item $value",
            style: const TextStyle(fontSize: 16),
          ));
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(snackbar);

            print("name : " +employeeName[ConstantVar.indexCont]['firstName'] + ' ' + employeeName[ConstantVar.indexCont]['lastName']);

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UserDetails(),
          ));
           //final SnackBar = SnackBar(content: Text("Clicked Item $value",style: const TextStyle(fontSize: 20),));
        },
      ),
    );
  }
}
