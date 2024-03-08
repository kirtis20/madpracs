import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const VerticalStepper(),
    );
  }
}

class VerticalStepper extends StatefulWidget {
  const VerticalStepper({Key? key}) : super(key: key);

  @override
  _VerticalStepperState createState() => _VerticalStepperState();
}

class _VerticalStepperState extends State<VerticalStepper> {
  int _index = 0;
  final steps = const [
    {'title': 'Create Account', 'content': 'first step'},
    {'title': 'Register yourself', 'content': 'Second step'},
    {'title': 'verify yourself', 'content': 'Third step'},
    {'title': 'do it yourself', 'content': 'Fourth step'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stepper Demo'),
      ),
      body: Stepper(
        currentStep: _index,
        steps: steps.map((step) => Step(
          title: Text(step['title']!),
          content: Text(step['content']!),
          isActive: _index == steps.indexOf(step),
        )).toList(),
        onStepContinue: () {
          if (_index < steps.length - 1) {
            setState(() {
              _index += 1;
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("This was the last step")));
          }
        },
        onStepCancel: () {
          if (_index > 0) {
            setState(() {
              _index -= 1;
            });
          } else {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("can't go back")));
          }
        },
        onStepTapped: (idx) {
          setState(() {
            _index = idx;
          });
        },
      ),
    );
  }
}
