import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageScreen(),
    );
  }
}

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  bool isVisible = true;
  double valueOfTarget = 150;
  final imageUrl = "https://images.pexels.com/photos/20333851/pexels-photo-20333851/free-photo-of-waves-on-sea-shore.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  label: Text(isVisible ? "Hide Image" : "Show image"),
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      valueOfTarget = valueOfTarget == 150 ? 300 : 150;
                    });
                  },
                  label: Text(valueOfTarget == 150 ? "Zoom in " : "Zoom out"),
                ),
              ],
            ),
            Visibility(
                visible: isVisible,
                child: Transform(
                  transform: Matrix4.rotationZ(pi * 1 / 4),
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: valueOfTarget),
                    duration: const Duration(milliseconds: 600),
                    builder: (BuildContext context, double size, Widget? child) =>
                        Image.network(
                      imageUrl,
                      height: size,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'dart:math';

// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   bool isVisible = true;
//   double valueOfTarget = 150;
//   final imagePath = 'assets/images/rose.jpg';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text("Tween animation"),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   FloatingActionButton.extended(
//                     onPressed: () {
//                       setState(() {
//                         isVisible = !isVisible;
//                       });
//                     },
//                     label: Text(isVisible ? "Hide Image" : "Show image"),
//                   ),
//                   FloatingActionButton.extended(
//                     onPressed: () {
//                       setState(() {
//                         valueOfTarget = valueOfTarget == 150 ? 300 : 150;
//                       });
//                     },
//                     label: Text(valueOfTarget == 150 ? "Zoom in " : "Zoom out"),
//                   ),
//                 ],
//               ),
//               Visibility(
//                 visible: isVisible,
//                 child: Transform(
//                   transform: Matrix4.rotationZ(pi * 1 / 4),
//                   child: TweenAnimationBuilder(
//                     tween: Tween<double>(begin: 0, end: valueOfTarget),
//                     duration: const Duration(milliseconds: 600),
//                     builder: (BuildContext context, double size, Widget? child) =>
//                       Image.asset(
//                         imagePath,
//                         height: size,
//                       ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
