import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:song_app/Playing/song_playing_screen.dart';
import 'package:song_app/constant/loder.dart';
import 'package:song_app/provider/get_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool play1 = false;
  bool play2 = false;
  GetProvider getProvider = GetProvider();

  @override
  void initState() {
    getProvider = Provider.of<GetProvider>(context, listen: false);
    getProvider.getProviderPermission();
    getProvider.getProviderData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Consumer<GetProvider>(
                builder: (context, value, child) {
                  if (value.listOfSongModel != null) {
                    return ListView.builder(
                      itemCount: value.listOfSongModel?.length,
                      itemBuilder: (context, index) {
                        SongModel nData = value.listOfSongModel![index];

                        return ListTile(
                          title: Text(nData.title.toString()),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SongPlaying(
                                  songName: nData.title,
                                  songPath: nData.data,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
