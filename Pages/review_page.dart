// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:dibrimak_mobile/Widgets/home_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home_page.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final DateTime now = DateTime.now();
  String formattedDate =
      DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());
  final databaseRef = FirebaseDatabase.instance.ref();

  TextEditingController reviewController = TextEditingController();

  TextEditingController dateTimeController = TextEditingController();

  void saveReviewData(
    String clinic,
    String review,
    String dateTime,
  ) async {
    // Show the snackbar while submitting the review
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text("Submitting your review..."),
        duration: Duration(seconds: 2),
      ),
    );
    try {
      // Get the currently authenticated user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Construct the data to be saved
        Map<String, dynamic> userData = {
          'clinic': clinic,
          'text': review,
          'time': dateTime,
        };

        if (dropDownValue == "Thabong" || dropDownValue == "Thabong clinic") {
          await databaseRef
              .child("reviews/Thabong Clinic/${user.uid}")
              .push()
              .set(userData);
        } else if (dropDownValue == "Welkom" ||
            dropDownValue == "Welkom clinic") {
          await databaseRef
              .child("reviews/Welkom Clinic/${user.uid}")
              .push()
              .set(userData);
        }
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error saving user data: $error');
    }
  }

  String dropDownValue = "Choose Clinic";

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 153, 240, 235),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 300,
                    ),
                    child: HomeButton(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Center(
                      child: Text(
                        'Reviews',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  //Center(child: DropdownButton1()),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 21,
                      right: 21,
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white60,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white60, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey, width: 2),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(13),
                      value: dropDownValue,
                      icon: Icon(
                        Icons.medical_services,
                        color: Colors.grey,
                      ),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          dropDownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Choose Clinic', // Corrected value
                        'Welkom',
                        'Thabong',
                        'Not Found'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      maxLines: 5,
                      minLines: 1,
                      controller: reviewController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter review";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Great Service/ Nurse Was Bad",
                        fillColor: Color.fromARGB(140, 255, 255, 255),
                        filled: true,
                        border: InputBorder.none,
                        labelText: "review",
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  _isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
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
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isLoading = true;
                              });
                              saveReviewData(
                                  dropDownValue,
                                  reviewController.text,
                                  dateTimeController.text = formattedDate);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                "Submit Review",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
