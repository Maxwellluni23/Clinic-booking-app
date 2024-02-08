// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_print, use_build_context_synchronously

import 'package:dibrimak_mobile/Widgets/home_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:table_calendar/table_calendar.dart';

class ActiveAppointments extends StatefulWidget {
  ActiveAppointments({Key? key}) : super(key: key);

  @override
  State<ActiveAppointments> createState() => _ActiveAppointmentsState();
}

class _ActiveAppointmentsState extends State<ActiveAppointments> {
  final ref = FirebaseDatabase.instance.ref();
  User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> bookingDataList = [];

  bool isLoading = true;

  Future<void> refreshPage() async {
    setState(() {
      isLoading = true;
    });
    await fetchUserData(); // Fetch and update booking data
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    Future.delayed(Duration(seconds: 3), () {
      // Stop loading
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Future<void> updateBooking(String bookingKey, String clinic, String date,
      String reason, String time) async {
    try {
      final userUid = user?.uid;
      if (userUid != null) {
        final bookingRef = ref.child('bookings/$userUid/$bookingKey');
        await bookingRef.update({
          'clinic': clinic,
          'date': date,
          'reason': reason,
          'time': time,
        });
      }
    } catch (e) {
      print('Error updating booking: $e');
      // Handle the error as needed
    }
  }

  Future<void> showEditDialog(Map<String, dynamic> booking) async {
    final TextEditingController clinicController = TextEditingController();
    final TextEditingController dateController = TextEditingController();
    final TextEditingController reasonController = TextEditingController();
    final TextEditingController timeController = TextEditingController();

    clinicController.text = booking['clinic'];
    dateController.text = booking['date'];
    reasonController.text = booking['reason'];
    timeController.text = booking['time'];

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Booking"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: clinicController,
                  decoration: InputDecoration(labelText: "Clinic"),
                ),
                TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(labelText: "Date"),
                ),
                TextFormField(
                  controller: reasonController,
                  decoration: InputDecoration(labelText: "Reason"),
                ),
                TextFormField(
                  controller: timeController,
                  decoration: InputDecoration(labelText: "Time"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                // Update the booking data here using the controller values
                await updateBooking(
                    booking['key'],
                    clinicController.text,
                    dateController.text,
                    reasonController.text,
                    timeController.text);

                Navigator.of(context).pop(); // Close the dialog
                // Refresh the UI after the booking is updated
                fetchUserData();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showDeleteConfirmationDialog(String bookingKey) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Are you sure you want to delete this booking?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                refreshPage();
                await deleteBooking(bookingKey);
                Navigator.of(context).pop(); // Close the dialog
                // Refresh the UI after the booking is deleted
                fetchUserData();
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteBooking(String bookingKey) async {
    try {
      final userUid = user?.uid;
      if (userUid != null) {
        final bookingRef = ref.child('bookings/$userUid/$bookingKey');
        await bookingRef.remove();
        // Refresh the UI by fetching data again
        fetchUserData();
      }
    } catch (e) {
      print('Error deleting booking: $e');
      // Handle the error as needed
    }
  }

  Future<void> fetchUserData() async {
    final snapshot = await ref.child('bookings/${user?.uid}').get();

    if (snapshot.value != null) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      final List<Map<String, dynamic>> bookings = [];

      data.forEach((key, value) {
        if (value is Map<dynamic, dynamic>) {
          // Iterate through the dynamic map and convert keys and values to String and dynamic
          Map<String, dynamic> bookingData = {};
          value.forEach((dynamicKey, dynamicValue) {
            if (dynamicKey is String) {
              bookingData[dynamicKey] = dynamicValue;
            }
          });
          // Store the booking key in the data
          bookingData['key'] = key;

          if (bookingData.isNotEmpty) {
            bookings.add(bookingData);
          }
        }
      });

      setState(() {
        bookingDataList = bookings;
      });
    }
  }

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
                  "Active Appointments",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 320,
                  child: TableCalendar(
                    rowHeight: 30,
                    locale: 'en_US',
                    onDaySelected: (selectedDay, focusedDay) {
                      focusedDay;
                    },
                    headerStyle: HeaderStyle(
                        formatButtonVisible: false, titleCentered: true),
                    firstDay: DateTime.utc(2010, 01, 10),
                    lastDay: DateTime.utc(2070, 01, 70),
                    focusedDay: DateTime.now(),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 2,
                          left: 10,
                        ),
                        child: Text(
                          "Please note! your booking time may be updated by the clinic you booked at continuously monitor your booking(s)",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      if (isLoading)
                        CircularProgressIndicator()
                      else if (bookingDataList.isNotEmpty)
                        Column(
                          children: bookingDataList.map((booking) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 39,
                                    right: 39,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(
                                          13,
                                        )),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.medical_services_sharp,
                                        color: Color.fromARGB(255, 50, 57, 58),
                                        size: 30,
                                      ),
                                      title: Text(
                                          'Clinic :   ${booking['clinic']}'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 39,
                                    right: 39,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(
                                          13,
                                        )),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.calendar_month_rounded,
                                        color: Color.fromARGB(255, 50, 57, 58),
                                        size: 30,
                                      ),
                                      title:
                                          Text('Date  :  ${booking['date']}'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 39,
                                    right: 39,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(
                                          13,
                                        )),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.medication_outlined,
                                        color: Color.fromARGB(255, 50, 57, 58),
                                        size: 30,
                                      ),
                                      title:
                                          Text('Reason: ${booking['reason']}'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 39,
                                    right: 39,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(
                                          13,
                                        )),
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.watch_later_sharp,
                                        color: Color.fromARGB(255, 50, 57, 58),
                                        size: 30,
                                      ),
                                      title: Text('Time: ${booking['time']}'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 90,
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.yellow),
                                          onPressed: () {
                                            showEditDialog(booking);
                                          },
                                          child: Text(
                                            "Edit",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                          onPressed: () {
                                            showDeleteConfirmationDialog(
                                              booking['key'],
                                            );
                                          },
                                          child: Text("Delete"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            );
                          }).toList(),
                        )
                      else if (bookingDataList.isEmpty)
                        Center(
                          child: Text(
                            " You Do Not have any Bookings",
                            style: TextStyle(
                              fontSize: 23,
                            ),
                          ),
                        )
                      else
                        Center(
                          child: Text(
                            "Check your internet connection",
                            style: TextStyle(
                              fontSize: 23,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
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
