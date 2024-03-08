import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyDemoApp());

class MyDemoApp extends StatelessWidget {
  const MyDemoApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter app',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const BirdsHome(),
      );
}

class BirdsHome extends StatefulWidget {
  const BirdsHome({super.key});

  @override
  State<BirdsHome> createState() => _BirdsHomeState();
}

class _BirdsHomeState extends State<BirdsHome> {
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    setAudio();

    player.onPlayerStateChanged.listen((state) => setState(() => isPlaying = state == PlayerState.playing));

    player.onDurationChanged.listen((newDuration) => setState(() => duration = newDuration));

    player.onPositionChanged.listen((newPosition) => setState(() => position = newPosition));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Play the sound of the Wild Babbler bird"),
          backgroundColor: Colors.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  'https://images.pexels.com/photos/4256925/pexels-photo-4256925.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  width: double.infinity,
                  height: 350,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "The Wild Babbler sings",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Slider(
                min: 0.0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final newPosition = Duration(seconds: value.toInt());
                  await player.seek(newPosition);
                  if (!isPlaying) await player.resume();
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatTime(position)),
                    Text(formatTime(duration)),
                  ],
                ),
              ),
              CircleAvatar(
                radius: 35,
                child: IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  iconSize: 50,
                  onPressed: () async {
                    if (isPlaying) {
                      await player.pause();
                    } else {
                      player.play(AssetSource("audio/video.mp3"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      );

  String formatTime(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return [if (duration.inHours > 0) hours, minutes, seconds].join(":");
  }

  Future<void> setAudio() async {
    player.setReleaseMode(ReleaseMode.loop);
    final mplayer = AudioCache(prefix: 'assets/audio/');
    final url = await mplayer.load('assets/audio/video.mp3');
    player.setSource(url.path as Source);
  }
}
