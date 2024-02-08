// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:dibrimak_mobile/Widgets/home_button.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final ref = FirebaseDatabase.instance.ref();
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final snapshot = await ref.child('users/${user?.uid}').get();

    if (snapshot.value != null) {
      setState(() {
        userData = Map<String, dynamic>.from(snapshot.value as Map);
      });
    }
  }

  final TextEditingController cellNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> updateUserData(
    String cellNumber,
    String email,
  ) async {
    try {
      final userUid = user?.uid;
      if (userUid != null) {
        // Update email in Firebase Authentication
        await updateEmailInAuth(email);

        // Update user data in Firebase Database
        final userRef = ref.child('users/$userUid');
        await userRef.update({
          'contactNumber': cellNumber,
          'email': email,
        });
      }
    } catch (e) {
      print('Error updating user data: $e');
      // Handle the error as needed
    }
  }

  // New function to update email in Firebase Authentication
  Future<void> updateEmailInAuth(String newEmail) async {
    newEmail = emailController.text;
    try {
      await user?.updateEmail(newEmail);
    } catch (e) {
      print('Error updating email in Firebase Authentication: $e');
      // Handle the error as needed
    }
  }

  Future<void> showEditDialog() async {
    cellNumberController.text = userData!['contactNumber'];
    emailController.text = userData!['email'];

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Edit Profile"),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: "Email"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: cellNumberController,
                  decoration: InputDecoration(labelText: "Cell Number"),
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
                // Update the user's information in Firebase using the controller values
                await updateUserData(
                  cellNumberController.text,
                  emailController.text,
                );

                Navigator.of(context).pop(); // Close the dialog
                // Refresh the UI after the user's information is updated
                fetchUserData();
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 153, 240, 235),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                  userData != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "My Profile",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 39, right: 39),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.white54),
                                child: ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text("Name  :   ${userData!['name']}"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 39, right: 39, top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.white54),
                                child: ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text(
                                      "Surname  :   ${userData!['surname']}"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, right: 39, left: 39),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.white54),
                                child: ListTile(
                                  leading: Icon(Icons.numbers),
                                  title: Text(
                                      "ID Number: ${userData!['idNumber']}"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 39, right: 39, top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.white54),
                                child: ListTile(
                                  leading: Icon(Icons.calendar_month),
                                  title: Text("Age  :   ${userData!['age']}"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 39, right: 39, top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.white54),
                                child: ListTile(
                                  leading: Icon(Icons.phone),
                                  title: Text(
                                      "Contact Number  : ${userData!['contactNumber']}"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 39, right: 39, top: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.white54),
                                child: ListTile(
                                  leading: Icon(Icons.email),
                                  title:
                                      Text("Email  :   ${userData!['email']}"),
                                ),
                              ),
                            ),
                          ],
                        )
                      : CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        showEditDialog();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white54,
                      ),
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
