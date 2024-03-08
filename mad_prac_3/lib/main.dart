
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mad_prac_3/new_screen.dart';

final Uri _url = Uri.parse('https://xaviers.ac/');

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyTextButton(),
    );
  }
}

class MyTextButton extends StatelessWidget {
  const MyTextButton({Key? key}) : super(key: key);

  Future<void> _launchUrl() async {
    if (await canLaunch(_url.toString())) {
      await launch(_url.toString());
    } else {
      // can't launch url
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextButton demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Icon(
                Icons.business,
                size: 100,
              ),
            ),
            TextButton(
              child: const Text(
                "St. Xaviers College Mumbai",
                style: TextStyle(fontSize: 30),
              ),
              onPressed: _launchUrl,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                elevation: 2,
                backgroundColor: Colors.red,
              ),
            ),
            ElevatedButton(
              child: const Text('Open route'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



