import 'package:audio/components/my_drawer.dart';
import 'package:audio/models/playlist_provider.dart';
import 'package:audio/models/songs.dart';
import 'package:audio/pages/song_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final dynamic playListProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // get Playlist Plovider
    playListProvider = Provider.of<PlayListProvider>(context, listen: false);
  }

  // go to a song
  void goToSong(int songIndex) {
    // update current song index
    playListProvider.currentSongIndex = songIndex;

    // navigate to song page
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SongPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text('P L A Y L I S T'),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlayListProvider>(
        builder: (context, value, child) {
          // get the play list
          final List<Song> playlist = value.playlist;
          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              // individual song
              final Song song = playlist[index];

//return song ui
              return ListTile(
                title: Text(song.songName),
                subtitle: Text(song.artistName),
                leading: Image.asset(song.albumArtImagePath),
                onTap: () => goToSong(index),
              );
            },
          );
        },
      ),
    );
  }
}
