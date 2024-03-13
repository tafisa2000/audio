import 'package:audio/components/neu_box.dart';
import 'package:audio/models/playlist_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SongPage extends StatelessWidget {
  const SongPage({super.key});

  // convert into min:sec
  String formartTime(Duration duration) {
    String twoDigitsSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String forrmatedTime = "${duration.inMinutes}: $twoDigitsSeconds";
    return forrmatedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayListProvider>(builder: (context, value, child) {
      // get the playList
      final playlist = value.playlist;
// get current song index
      final currentSong = playlist[value.currentSongIndex ?? 0];
      //return scaffold UI
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // App Bar
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back)),
                      const Text('P L A Y L I S T'),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.menu))
                    ],
                  ),
                ),

                //album art work
                NeuBox(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          currentSong.albumArtImagePath,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentSong.songName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Text(currentSong.artistName)
                            ],
                          ),
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Starting time
                          Text(formartTime(value.currentDuration)),
                          // Shuffle icon
                          const Icon(Icons.shuffle),
                          // Repeate icon
                          const Icon(Icons.repeat),

                          //end time
                          Text(formartTime(value.totalDurattion)),
                        ],
                      ),
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 0)),
                      child: Slider(
                        value: value.currentDuration.inSeconds.toDouble(),
                        min: 0,
                        max: value.totalDurattion.inSeconds.toDouble(),
                        activeColor: Colors.green,
                        onChanged: (value) {
                          // during user sliding around
                        },
                        onChangeEnd: (double double) {
                          // sliding has finished, go that position in song duration
                          value.seek(Duration(seconds: double.toInt()));
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        // Skip previous
                        Expanded(
                          child: GestureDetector(
                            onTap: value.playPreviousSong,
                            child: const NeuBox(
                              child: Icon(Icons.skip_previous),
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),

                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: value.pauseOrResume,
                            child: NeuBox(
                              child: Icon(value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow),
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: GestureDetector(
                            onTap: value.playNextSong,
                            child: const NeuBox(
                              child: Icon(Icons.skip_next),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                //song duration

                //playback controls
              ],
            ),
          ),
        ),
      );
    });
  }
}
