import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:song_app/constant/loder.dart';
import 'package:song_app/provider/get_provider.dart';

class SongPlaying extends StatefulWidget {
  const SongPlaying({
    Key? key,
    required this.songName,
    required this.songPath,
  }) : super(key: key);
  final String songName;
  final String songPath;

  @override
  State<SongPlaying> createState() => _SongPlayingState();
}

class _SongPlayingState extends State<SongPlaying> {
  AudioPlayer audioPlayer = AudioPlayer();

  GetProvider getProvider = GetProvider();
  AudioCache audioCache = AudioCache();

  @override
  void initState() {
    getProvider = Provider.of<GetProvider>(context, listen: false);
    getProvider.playSong;
    getProvider.stopPlaying;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () {
          getProvider.stopPlaying();
          screenBack(context);
        }),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.songName),
              Text(widget.songPath),
              ElevatedButton(
                onPressed: () {
                  getProvider.playSong(widget.songPath);
                },
                child: Consumer<GetProvider>(
                  builder: (context, value, child) =>
                      Text(value.isPlay ? "Pause" : "Play"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
