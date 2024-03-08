//new_screen.dart
import 'package:flutter/material.dart';

class NewScreen extends StatefulWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  State<NewScreen> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreen> {
  TextEditingController num1 = TextEditingController();
  TextEditingController num2 = TextEditingController();
  String result = "0";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Area Calculator"),
        backgroundColor: const Color.fromARGB(255, 105, 106, 200),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: num1,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'First Number',
                hintText: 'Enter First Number',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: num2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Second Number',
                hintText: 'Enter Second Number',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text("area"),
              onPressed: () {
                setState(() {
                  int area = int.parse(num1.text) *
                      int.parse(num2.text);
                  result = area.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}