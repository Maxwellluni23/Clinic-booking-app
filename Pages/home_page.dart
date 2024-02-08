// ignore_for_file: prefer_const_constructors

import 'package:dibrimak_mobile/Pages/bmi.dart';
import 'package:dibrimak_mobile/Pages/chatbot.dart';
import 'package:dibrimak_mobile/Pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'active_appointments.dart';
import 'book_appointment.dart';
import 'daily_services.dart';
import 'profile_page.dart';
import 'review_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Card buildRoundedCard({required Widget child}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15.0), // Adjust the radius as needed
      ),
      child: child,
    );
  }

  Widget buildRoundedListTile({
    required String title,
    required IconData icon,
    required IconData trailor,
    required Function() onPressed,
    Color? iconColor,
    Color? trailorColor,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22.0), // Adjust the radius as needed
      child: Card(
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 40.0), // Add horizontal padding
          leading: Icon(
            icon,
            color: iconColor,
            size: 32,
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.black, fontSize: 17),
          ),
          tileColor: Colors.white60,
          trailing: Icon(
            trailor,
            color: trailorColor,
            size: 31,
          ),
          onTap: onPressed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 153, 240, 235),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 90, bottom: 30),
            child: Column(
              children: [
                Image.asset(
                  'lib/Assets/South_African_National_Department_of_Health_logo_2023.png',
                  width: 320,
                  height: 135,
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 50,
                    right: 50,
                  ),
                  child: buildRoundedListTile(
                    title: 'Book Appointments',
                    icon: Icons.event,
                    trailor: Icons.arrow_forward,
                    trailorColor: Color.fromARGB(255, 22, 18, 3),
                    iconColor: Colors.cyan,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookingPage()),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 50,
                    right: 50,
                  ),
                  child: buildRoundedListTile(
                    title: 'My Profile',
                    icon: Icons.person,
                    trailor: Icons.arrow_forward,
                    trailorColor: Color.fromARGB(255, 22, 18, 3),
                    iconColor: Colors.cyan,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyProfile()),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 50,
                    right: 50,
                  ),
                  child: buildRoundedListTile(
                    title: 'Active Appointments',
                    icon: Icons.access_time,
                    trailor: Icons.arrow_forward,
                    trailorColor: Color.fromARGB(255, 22, 18, 3),
                    iconColor: Colors.cyan,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActiveAppointments(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 50,
                    right: 50,
                  ),
                  child: buildRoundedListTile(
                    title: 'Review',
                    icon: Icons.rate_review,
                    trailor: Icons.arrow_forward,
                    trailorColor: Color.fromARGB(255, 22, 18, 3),
                    iconColor: Colors.cyan,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewPage(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 50,
                    right: 50,
                  ),
                  child: buildRoundedListTile(
                    title: 'Daily Services',
                    icon: Icons.access_alarm,
                    trailor: Icons.arrow_forward,
                    iconColor: Colors.cyan,
                    trailorColor: Color.fromARGB(255, 22, 18, 3),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DailyServices(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 50,
                    right: 50,
                  ),
                  child: buildRoundedListTile(
                    title: 'BMI Calculator',
                    icon: Icons.calculate_outlined,
                    trailor: Icons.arrow_forward,
                    trailorColor: Color.fromARGB(255, 22, 18, 3),
                    iconColor: Colors.cyan,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BMICalculator(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 50,
                    right: 50,
                  ),
                  child: buildRoundedListTile(
                    title: 'Healthly Chat',
                    icon: Icons.chat_bubble_outline,
                    trailor: Icons.arrow_forward,
                    trailorColor: Color.fromARGB(255, 22, 18, 3),
                    iconColor: Colors.cyan,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyChatPage(),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 50,
                    right: 50,
                  ),
                  child: buildRoundedListTile(
                    title: 'Signout',
                    icon: Icons.exit_to_app,
                    trailor: Icons.arrow_forward,
                    iconColor: Color.fromARGB(255, 192, 22, 7),
                    trailorColor: Color.fromARGB(255, 192, 22, 7),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
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
