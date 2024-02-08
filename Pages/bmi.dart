// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../Widgets/home_button.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  BMICalculatorState createState() => BMICalculatorState();
}

class BMICalculatorState extends State<BMICalculator> {
  
  double height = 170;
  double weight = 70;
  double bmi = 0;

  void calculateBMI() {
    setState(() {
      // Calculate BMI using the provided formula
      bmi = weight / ((height / 100) * (height / 100));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 153, 240, 235),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 70,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: 300,
              ),
              child: HomeButton(),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Calculate your BMI",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            // Additional Information
            Padding(
              padding: const EdgeInsets.only(
                right: 100,
                top: 30,
                bottom: 20,
              ),
              child: Text(
                'Benefits of Knowing Your BMI:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 100,
              ),
              child: Text(
                '1. Assessment of Weight Status\n2. Health Risk Assessment\n3. Weight Management\n4. Nutritional Guidance\n5. Fitness and Exercise\n6. Medical Screening\n7. Preventive Health',
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text('Enter your height (in cm):'),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Rounded edges
                  color: Colors.white,
                ),
                child: Slider(
                  value: height,
                  min: 100,
                  max: 220,
                  onChanged: (value) {
                    setState(() {
                      height = value;
                    });
                  },
                ),
              ),
            ),
            Text(height.toStringAsFixed(1)),
            Text('Enter your weight (in kg):'),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // Rounded edges
                  color: Colors.white,
                ),
                child: Slider(
                  value: weight,
                  min: 30,
                  max: 200,
                  onChanged: (value) {
                    setState(() {
                      weight = value;
                    });
                  },
                ),
              ),
            ),
            Text(weight.toStringAsFixed(1)),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // White60 background color
              ),
              onPressed: calculateBMI,
              child: Text(
                'Calculate BMI',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Your BMI: ${bmi.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
