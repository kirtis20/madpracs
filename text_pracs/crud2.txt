import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '/firebase_options.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.cyan),
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String studentName, studentID, programID;
  late double gpa;

  getStudentName(name) {
    this.studentName = name;
  }

  getStudentID(id) {
    this.studentID = id;
  }

  getStudyProgramID(programID) {
    this.programID = programID;
  }

  getStudentGPA(gpa) {
    this.gpa = double.parse(gpa);
  }

  createData() async {
    print("created");
    CollectionReference colref =
        FirebaseFirestore.instance.collection('myStudents');
    //create map

    await colref.doc(studentName).set({
      "studentName": studentName,
      "studentID": studentID,
      "gpa": gpa,
      "courseCode": programID,
    });
  }

  readData() async {
    try {
      CollectionReference colref =
          FirebaseFirestore.instance.collection('myStudents');
      final snapshot = await colref.doc(studentName).get();
      final data = snapshot.data() as Map<String, dynamic>;
      print(data['studentName']);
    } catch (e) {
      print('Error fetching user: $e');
    }
  }

  updateData() {
    print("update");

    CollectionReference colref =
        FirebaseFirestore.instance.collection('myStudents');
    //create map
    Map<String, dynamic> myStudents_map = {
      "studentName": studentName,
      "studentID": studentID,
      "gpa": gpa,
      "courseCode": programID,
    };
    colref
        .doc('NR8enJJw4AWPiUHv7hRu')
        .set(myStudents_map)
        .then((value) => print("user updated"))
        .catchError((error) => print("failed to update user : $error"));
  }

  deleteData() {
    print("delete");

    CollectionReference colref =
        FirebaseFirestore.instance.collection('myStudents');
    colref
        .doc('NR8enJJw4AWPiUHv7hRu')
        .delete()
        .then((colref) => print("document deleted"))
        .catchError((error) => print("failed to delete decument : $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student information"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "Student Name: ",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 0.8),
                  ),
                ),
                onChanged: (String name) {
                  getStudentName(name);
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "GPA: ",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 0.8),
                    ),
                  ),
                  onChanged: (String gpa) {
                    getStudentGPA(gpa);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Create"),
                    onPressed: () {
                      createData();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Read"),
                    onPressed: () {
                      readData();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),  
                    child: Text("Update"),
                    onPressed: () {
                      updateData();
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text("Delete"),
                    onPressed: () {
                      deleteData();
                    },
                      ),
                    ],
                    )
                  ],
                  ),
                ),
   
  );
 }
}