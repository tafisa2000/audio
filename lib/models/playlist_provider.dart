import 'package:audio/models/songs.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlayListProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
        songName: 'Angel Numbers',
        artistName: 'Chriss Brown',
        albumArtImagePath: 'assets/images/chriss.jpg',
        audioPath: 'assets/audios/angels.mp3'),
    Song(
        songName: 'The way life goes',
        artistName: 'nick minaj',
        albumArtImagePath: 'assets/images/nick.jpg',
        audioPath: 'assets/audios/the_life_goes.mp3'),
    Song(
        songName: 'pounds & dollers',
        artistName: 'diamond platnamz',
        albumArtImagePath: 'assets/images/diamond.jpg',
        audioPath: 'assets/audios/the_life_goes.mp3'),
  ];

  // Current song playing index
  int? _currentSongIndex;
  /*
  AUDIO PLAYERS
  */
// audio players
  final AudioPlayer _audioPlayer = AudioPlayer();
  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  //constructor
  PlayListProvider() {
    listenToDuration();
  }
//initially not playing
  bool _isPlaying = false;
// playing the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); // stop the current song
    await _audioPlayer.play(AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

//pause curentsong
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

// resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

//pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

//seek to specific position
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

//play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        // go to song next
        currentSongIndex = currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

//play prev song
  void playPreviousSong() async {
    //if more than two second passed restart the song
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    }
    // if it's within 2 seconds of a song go to previous song
    else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

// listen duration
  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  /*
  GETTERS
  */
  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDurattion => _totalDuration;
  /*
  SETTERS
  */
  set currentSongIndex(int? newIndex) {
    // update curent song index
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }
    // update UI
    notifyListeners();
  }
}
