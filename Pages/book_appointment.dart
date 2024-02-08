// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:intl/intl.dart';
import 'package:dibrimak_mobile/Pages/home_page.dart';
import 'package:dibrimak_mobile/Widgets/home_button.dart';
import 'package:dibrimak_mobile/services/service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TextEditingController clinicController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref();

  String dropDownValue = "Choose Clinic";

  Future<void> _selectedDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
    );
    if (picked != null) {
      setState(() {
        // Format the picked date using intl package
        String formattedDate = DateFormat('yyyy-dd-MM').format(picked);
        dateController.text = formattedDate;
      });
    }
  }

  Future<void> _selectedTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    final startTime = TimeOfDay(hour: 9, minute: 0);
    final endTime = TimeOfDay(hour: 16, minute: 0);
    final List<TimeOfDay> availableTimes = [];
    for (var time = startTime;
        time.hour < endTime.hour;
        time = time.replacing(hour: time.hour + 1)) {
      availableTimes.add(time);
    }

    if (picked != null) {
      setState(() {
        // Format the picked time to a string in 'hh:mm a' format
        String formattedTime = picked.format(context);
        timeController.text = formattedTime;
      });
    }
  }

  // show snack bar after the user has added appoints
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text(message),
          ],
        ),
      ),
    );
  }

  Future<void> _submitBooking() async {
    // Show the "Adding your booking" Snackbar with a progress indicator
    _showSnackbar("Adding your booking");

    // Simulate a delay to represent the booking process
    await Future.delayed(Duration(seconds: 2));

    // Services().bookingData(...) // Your booking data service

    // Hide the Snackbar after the booking process is complete
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 153, 240, 235),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                Image.asset(
                  'lib/Assets/South_African_National_Department_of_Health_logo_2023.jpg',
                  width: 320,
                  height: 150,
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 100,
                  ),
                  child: Text(
                    "Book An Appointment",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 160,
                    left: 20,
                  ),
                  child: Text(
                    "-Choose Weekdays only! (Mon- Friday)",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                    left: 20,
                  ),
                  child: Text(
                    "-Choose Time within clinic Operating Hours!(09:00-16:00)",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                        borderSide: BorderSide(color: Colors.white60, width: 2),
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
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    onTap: () {
                      _selectedDate();
                    },
                    readOnly: true,
                    controller: dateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter date";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "yyyy-dd-mm",
                      fillColor: Color.fromARGB(140, 255, 255, 255),
                      filled: true,
                      border: InputBorder.none,
                      labelText: "Date",
                      prefixIcon: Icon(
                        Icons.calendar_month,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    onTap: () {
                      _selectedTime();
                    },
                    readOnly: true,
                    controller: timeController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter time";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "hh:mm",
                      fillColor: Color.fromARGB(140, 255, 255, 255),
                      filled: true,
                      border: InputBorder.none,
                      labelText: "Time",
                      prefixIcon: Icon(
                        Icons.timer,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: TextFormField(
                    controller: reasonController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter reason";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "flu/Testing",
                      fillColor: Color.fromARGB(140, 255, 255, 255),
                      filled: true,
                      border: InputBorder.none,
                      labelText: "Reason",
                      prefixIcon: Icon(
                        Icons.medication,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                Container(
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
                  height: 45,
                  child: GestureDetector(
                    onTap: () {
                      Services().bookingData(
                        dropDownValue,
                        dateController.text,
                        reasonController.text,
                        timeController.text,
                      );
                      _submitBooking();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        "Submit",
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
    );
  }
}
