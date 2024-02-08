// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:dibrimak_mobile/Widgets/home_button.dart';
import 'package:flutter/material.dart';

class DailyServices extends StatefulWidget {
  const DailyServices({super.key});

  @override
  State<DailyServices> createState() => _DailyServicesState();
}

class _DailyServicesState extends State<DailyServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 153, 240, 235),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
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
                Text(
                  "Daily Services",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                // Each day's services are displayed in a structured layout
                // with appropriate styling and spacing.
                Container(
                  margin: EdgeInsets.all(20),
                  color: Colors.white30,
                  alignment: Alignment.center,
                  height: 100,
                  width: 800,
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        "Monday Services",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Immunasation",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  color: Colors.white30,
                  alignment: Alignment.center,
                  height: 100,
                  width: 800,
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        "Tuesday Services",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "antenatal care and family planning",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  color: Colors.white30,
                  alignment: Alignment.center,
                  height: 100,
                  width: 800,
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        "Wednesday Services",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "chronic diseases and tuberculosis treatment",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  color: Colors.white30,
                  alignment: Alignment.center,
                  height: 100,
                  width: 800,
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        "Thursday Services",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Dental and eye care",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  color: Colors.white30,
                  alignment: Alignment.center,
                  height: 100,
                  width: 800,
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        "Friday Services",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Mental health care",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
