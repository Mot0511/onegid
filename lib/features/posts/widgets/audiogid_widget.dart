import 'dart:io';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:uuid/uuid.dart';

class AudiogidWidget extends StatefulWidget {
  const AudiogidWidget({super.key, required this.path, required this.isOnDevice});
  final String path;
  final bool isOnDevice;

  @override
  State<AudiogidWidget> createState() => _AudiogidWidgetState();
}

class _AudiogidWidgetState extends State<AudiogidWidget> {

  final player = AudioPlayer(playerId: Uuid().v1());

  double duration = 0;
  Duration position = Duration(seconds: 0);
  bool isPlay = false;

  void initAudio() async {
    if (widget.isOnDevice) {
      await player.play(DeviceFileSource(widget.path));
    } else {
      await player.play(UrlSource(widget.path));
    }
    await player.pause();

    player.onPositionChanged.listen((Duration p) => setState(() => position = p));
    duration = (await player.getDuration())!.inSeconds.toDouble();
  }

  void seek(double value) async {
    await player.seek(Duration(seconds: value.toInt()));
  }
  
  void play() async {
    if (isPlay) {
      await player.pause();
      isPlay = false;
    } else {
      await player.resume();
      isPlay = true;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initAudio();
  }

  @override
  void dispose() async {
    super.dispose();
    await player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 80,
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: play,
              icon: isPlay 
                ? Icon(Icons.pause_circle, size: 50, color: Colors.white)
                : Icon(Icons.play_circle, size: 50, color: Colors.white)
            ),
          ),
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Slider(
                  value: position.inSeconds.toDouble(),
                  max: duration,
                  onChanged: seek,
                  thumbColor: Colors.white,
                  activeColor: const Color.fromARGB(255, 51, 122, 53),
                  inactiveColor: const Color.fromARGB(255, 69, 165, 73)
                ),
                Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Text('${position.inMinutes}:${position.inSeconds >= 60 ? position.inSeconds % 60 : position.inSeconds}', style: theme.textTheme.bodyMedium)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}