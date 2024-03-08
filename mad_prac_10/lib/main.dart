import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedOption = '';

  void handleOptionChange(String value) {
    setState(() {
      selectedOption = value;
    });
  }

  void showPicture() {
    String imageUrl = '';
    String description = '';

    switch (selectedOption) {
      case 'KOALA':
        imageUrl = 'https://thumbs.dreamstime.com/b/koala-sitting-gold-coin-cute-creative-kawaii-cartoon-mascot-logo-253102998.jpg';
        description = 'The koala is an arboreal herbivorous marsupial native to Australia.';
        break;
      case 'PENGUIN':
        imageUrl = 'https://media.istockphoto.com/id/1152538876/vector/cute-baby-penguin-cartoon-in-different-poses-vector-illustration.jpg?s=612x612&w=0&k=20&c=zm9H_FKjHURthgvzfhtYh1qEVfkdRy_obe-gsDzIvzw=';
        description = 'Penguins are a group of aquatic flightless birds.';
        break;
      case 'DAFFODIL':
        imageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRtc613fzp6yXBLMWLk7vw0kz_3Md_Bd7sjJA&usqp=CAU';
        description = 'Daffodil is a common English name for narcissus, a genus of predominantly spring perennial plants in the Amaryllidaceae family.';
        break;
      default:
        break;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PicturePage(imageUrl: imageUrl, description: description),
      ),
    );
  }

  Widget buildRadioOption(String title) {
    return RadioListTile(
      title: Text(title),
      value: title,
      groupValue: selectedOption,
      onChanged: (value) => handleOptionChange(value!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select an Option'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildRadioOption('KOALA'),
          buildRadioOption('PENGUIN'),
          buildRadioOption('DAFFODIL'),
          ElevatedButton(
            onPressed: selectedOption.isNotEmpty ? showPicture : null,
            child: Text('Show Picture'),
          ),
        ],
      ),
    );
  }
}

class PicturePage extends StatelessWidget {
  final String imageUrl;
  final String description;

  const PicturePage({Key? key, required this.imageUrl, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Picture Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: precacheImage(NetworkImage(imageUrl), context),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return CircularProgressIndicator();
                }
                if (snapshot.error != null) {
                  return Text('Error loading image');
                }
                return Image.network(
                  imageUrl,
                  width: 500,
                  height: 500,
                );
              },
            ),
            SizedBox(height: 20),
            Text(description),
          ],
        ),
      ),
    );
  }
}
