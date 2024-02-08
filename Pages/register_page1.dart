// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:dibrimak_mobile/Pages/login.dart';
import 'package:dibrimak_mobile/services/service.dart';
import 'package:flutter/material.dart';

class RegisterPageOne extends StatefulWidget {
  const RegisterPageOne({Key? key}) : super(key: key);

  @override
  State<RegisterPageOne> createState() => _RegisterPageStateOne();
}

class _RegisterPageStateOne extends State<RegisterPageOne> {
  bool _isLoading = false;
  TextEditingController ageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController idNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 153, 240, 235),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 70),
                child: Text(
                  "User Details",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(140, 255, 255, 255),
                    filled: true,
                    border: InputBorder.none,
                    labelText: "Name",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextFormField(
                  controller: surnameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter surname";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(140, 255, 255, 255),
                    filled: true,
                    border: InputBorder.none,
                    labelText: "surname",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please re-enter email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(140, 255, 255, 255),
                    filled: true,
                    border: InputBorder.none,
                    labelText: "cornfirm email",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextFormField(
                  controller: idNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter id";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(140, 255, 255, 255),
                    filled: true,
                    border: InputBorder.none,
                    labelText: "id number",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextFormField(
                  controller: ageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter age";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(140, 255, 255, 255),
                    filled: true,
                    border: InputBorder.none,
                    labelText: "Age",
                    prefixIcon: Icon(
                      Icons.calendar_view_month,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: TextFormField(
                  controller: contactNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter contact number";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(140, 255, 255, 255),
                    filled: true,
                    border: InputBorder.none,
                    labelText: "contact number",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isLoading = true;
                          });
                          Services().saveUserData(
                            ageController.text.trim(),
                            contactNumberController.text.trim(),
                            emailController.text.trim(),
                            idNumberController.text.trim(),
                            nameController.text.trim(),
                            surnameController.text.trim(),
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text(
                            "register",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 8,
                            )
                          ]),
                      width: 150,
                      height: 40,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
