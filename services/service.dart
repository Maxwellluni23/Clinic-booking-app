import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Services {
  final databaseRef = FirebaseDatabase.instance.ref();

  saveUserData(
    String age,
    String contactNumber,
    String email,
    String idNumber,
    String name,
    String surname,
  ) async {
    try {
      // Get the currently authenticated user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Construct the data to be saved
        Map<String, dynamic> userData = {
          'age': age,
          'contactNumber': contactNumber,
          'idNumber': idNumber,
          'email': email,
          'name': name,
          'surname': surname,
        };

        // Set the data under the user's UID
        await databaseRef.child("users/${user.uid}").set(userData);

        // The data is saved under 'users/$uid' where $uid is the UID of the authenticated user.
      }
    } catch (error) {
      // ignore: avoid_print
      print('Error saving user data: $error');
    }
  }

  bookingData(
    String clinic,
    String date,
    String reason,
    String time,
  ) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Map<String, dynamic> bookingData = {
        "clinic": clinic,
        "date": date,
        "reason": reason,
        "time": time,
      };
      // Set the data under the user's UID
      await databaseRef.child("bookings/${user.uid}").push().set(bookingData);
    }
  }
}
