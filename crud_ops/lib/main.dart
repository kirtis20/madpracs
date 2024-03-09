import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StudentForm(),
    );
  }
}

class StudentForm extends StatefulWidget {
  @override
  _StudentFormState createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _marksController = TextEditingController();
  final CollectionReference _students = FirebaseFirestore.instance.collection('students');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Form'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _marksController,
              decoration: InputDecoration(labelText: 'Marks'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter marks';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await _students.doc(_nameController.text).set({
                    'name': _nameController.text,
                    'marks': int.parse(_marksController.text),
                  });
                }
              },
              child: Text('Submit'),
            ),
            ElevatedButton(
              onPressed: () async {
                DocumentSnapshot doc = await _students.doc(_nameController.text).get();
                if (doc.exists) {
                  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Student Details'),
                        content: Text('Name: ${data['name']}, Marks: ${data['marks']}'),
                      );
                    },
                  );
                }
              },
              child: Text('Read'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _students.doc(_nameController.text).delete();
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
