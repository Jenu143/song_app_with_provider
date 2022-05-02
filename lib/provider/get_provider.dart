import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GetProvider extends ChangeNotifier {
  OnAudioQuery onAudioQuery = OnAudioQuery();
  AudioPlayer audioPlayer = AudioPlayer();

  List<SongModel>? listOfSongModel;
  bool isPlay = false;

  Future<bool> getProviderPermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await onAudioQuery.permissionsStatus();
      if (!permissionStatus) {
        await onAudioQuery.permissionsRequest();
      }
      notifyListeners();
    }
    return onAudioQuery.permissionsRequest();
  }

  Future getProviderData() async {
    listOfSongModel = await onAudioQuery.querySongs(
      sortType: SongSortType.ALBUM,
      orderType: OrderType.DESC_OR_GREATER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    notifyListeners();
    return listOfSongModel;
  }

  void playSong(String path) {
    if (isPlay == false) {
      isPlay == true;
      audioPlayer.play(path);
    } else {
      isPlay == false;
      audioPlayer.pause();
    }

    isPlay = !isPlay;
    notifyListeners();
  }

  stopPlaying() {
    isPlay = false;

    audioPlayer.stop();
    notifyListeners();
  }
}
