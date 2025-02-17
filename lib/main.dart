import 'package:flutter/material.dart';

void main() {
  runApp(
    BMICalculator()
  );
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  double bmi = 0.0;
  String bmiCategory = '';

  void calculateBMI() {
    double height = double.parse(heightController.text) / 100; // Convert cm to meters
    double weight = double.parse(weightController.text);
    setState(() {
      bmi = weight / (height * height);
      if (bmi < 18.5) {
        bmiCategory = 'Underweight';
      } else if (bmi < 24.9) {
        bmiCategory = 'Normal weight';
      } else if (bmi < 29.9) {
        bmiCategory = 'Overweight';
      } else {
        bmiCategory = 'Obesity';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ReusableCard(
                child: TextField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Height (cm)'),
                ),
              ),
              SizedBox(height: 10),
              ReusableCard(
                child: TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Weight (kg)'),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: calculateBMI,
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                  child: Text(
                    'Calculate BMI',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'BMI: ${bmi.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'BMI Category: $bmiCategory',
                style: TextStyle(fontSize: 20, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable Card Widget
class ReusableCard extends StatelessWidget {
  final Widget child;
  const ReusableCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
