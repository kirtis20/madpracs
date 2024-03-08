import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const title = 'List';

    final items = [
      {'icon': Icons.map, 'text': 'Map'},
      {'icon': Icons.photo_album, 'text': 'Album'},
      {'icon': Icons.phone, 'text': 'Phone'},
      {'icon': Icons.email, 'text': 'Email'},
      {'icon': Icons.camera, 'text': 'Camera'},
    ];

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: ListView.separated(
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(),
          itemBuilder: (context, index) {
            return MyListTile(
              icon: items[index]['icon'] as IconData,
              text: items[index]['text'] as String,
            );
          },
        ),
      ),
    );
  }
}

class MyListTile extends StatelessWidget {
  final IconData icon;
  final String text;

  const MyListTile({required this.icon, required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(content: Text('$text pressed'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: ListTile(
        leading: Icon(icon),
        title: Text(text),
      ),
    );
  }
}
