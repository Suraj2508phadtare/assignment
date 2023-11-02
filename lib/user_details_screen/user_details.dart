import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widgets_demo/constant_variable/constant_var.dart';
import 'package:flutter_widgets_demo/dashboard/scroll_list.dart';

class UserDetails extends StatefulWidget {
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  List employeData = [];
  bool isLoading = false;
  List users = [];
  String name = '', email = '', phoneNumber = '', dob = '', address = '';
  int age = 0;

  @override
  void initState() {
    //this._getTimecardData(page);
    lodingData();
    super.initState();
  }

  Future<void> lodingData() async {
    final String response = await rootBundle.loadString('assets/employee.json');
    final data = await json.decode(response);

    setState(() {
      name = data[ConstantVar.indexCont]['firstName'] +
          ' ' +
          data[ConstantVar.indexCont]['lastName'];
      email = data[ConstantVar.indexCont]['email'];
      dob = data[ConstantVar.indexCont]['dob'];
      address = data[ConstantVar.indexCont]['address'];
      phoneNumber = data[ConstantVar.indexCont]['contactNumber'];
      age = data[ConstantVar.indexCont]['age'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Do something here
        print("After clicking the Device Back Button");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()));

        return false;
      },
      child: Scaffold(
        //backgroundColor: const Color(0xff121421),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardScreen())),
              );
            },
          ),
          title: const Text("Profile ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal)),
          backgroundColor: Colors.amber[500],
          elevation: 0.0,
        ),
        body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 250.0,
                      width: double.infinity,
                      //color: Color(getColorHexFromStr('#FDD148')),
                      color: Colors.amber[300],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 20.0),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 3, left: 10.0, right: 10.0),
                            child: Container(
                              margin: const EdgeInsets.all(1.0),
                              child: Container(
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  border: Border.all(
                                      color: Colors.transparent,
                                      style: BorderStyle.none,
                                      width: 1.5),
                                  image: const DecorationImage(
                                      image: AssetImage('assets/user.png')),
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            name,
                            // 'Pranjali Maske'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 23.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10.0, right: 10.0),
                          child: Material(
                            elevation: 4.0,
                            borderRadius: BorderRadius.circular(5.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title: const Text(
                                    'Date Of Birth',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    (dob).toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: const Text(
                                    'Mobile Number',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  subtitle: Text(
                                    (phoneNumber).toString(),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: const Text(
                                    'Email',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  subtitle: Text(
                                    (email).toString(),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: const Text(
                                    'Address',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  subtitle: Text(
                                    (address),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                ListTile(
                                  title: const Text(
                                    'Age',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  subtitle: Text(
                                    (age).toString(),
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ],
                ),
              ],
            );
            // }
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
