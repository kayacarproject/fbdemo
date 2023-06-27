import 'package:fbdemo/model/banner_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

BannerModel? bannerModel;

/*class VideoPage extends StatefulWidget {
  VideoPage(BannerModel bannerModel1, {super.key}) {
    bannerModel = bannerModel1;
  }

  // final String title;

  @override
  State<VideoPage> createState() => MyVideoPageState();
}

class MyVideoPageState extends State<VideoPage> {
// class VideoPage extends StatelessWidget {
//   const VideoPage({super.key});

  late YoutubePlayerController controllerYT;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState");
    controllerYT = YoutubePlayerController(
      initialVideoId: bannerModel?.videoUrl ?? "",
       flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          appBar: (orientation == Orientation.landscape)
              ? null
              : AppBar(
                  backgroundColor: Colors.deepPurple,
                  leading: InkWell(
                    hoverColor: Colors.black12,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      color: Colors.transparent,
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  title: const Text(
                    'Video',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      splashColor: Colors.deepOrangeAccent,
                      highlightColor: Colors.black12,
                      hoverColor: Colors.black12,
                      icon: const Icon(
                        Icons.share_sharp,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
          body: Container(
            child: Column(
              children: [
                YoutubePlayerBuilder(
                 onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },

                  player: YoutubePlayer(
                    controller: controllerYT,
                     showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
                    onReady: () {
                      print("ready to call =-=-==-=-=>");
                    },
                  ),
                  builder: (context, player) {
                    return player;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    controllerYT.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }
}
*/

/// Creates [YoutubePlayerDemoApp] widget.
/*class YoutubePlayerDemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Youtube Player Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.blueAccent,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.blueAccent,
        ),
      ),
      home: MyHomePage(),
    );
  }
}*/

/// Homepage
class VideoPage extends StatefulWidget {
  VideoPage(BannerModel bannerModel1, {super.key}) {
    bannerModel = bannerModel1;
  }

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<VideoPage> {
  late YoutubePlayerController _controller;

  // late TextEditingController _idController;
  // late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  //
  // final List<String> _ids = [
  //   'nPt8bK2gbaU',
  //   'gQDByCdjUXw',
  //   'iLnmTe5Q2Qw',
  //   '_WoCV4c6XOE',
  //   'KmzdUe0RSJo',
  //   '6jZDSSZZxjQ',
  //   'p2lYr3vM_1w',
  //   '7QUtEmBT_-w',
  //   '34_PXCzGw1M',
  // ];

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: bannerModel?.videoUrl ?? "",
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    // _idController = TextEditingController();
    // _seekToController = TextEditingController();
    // _videoMetaData = const YoutubeMetaData();
    // _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    // _idController.dispose();
    // _seekToController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarIconBrightness: Brightness.dark,
    //     statusBarColor: Colors.deepPurple,
    //   ),
    // );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarIconBrightness: Brightness.dark,
    //     statusBarColor: Colors.transparent,
    //   ),
    // );
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        print("onExitFullScreen=-=-=->");
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.deepPurple,
          ),
        );
        SystemChrome.setEnabledSystemUIMode(
            SystemUiMode.edgeToEdge);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          // _controller
          //     .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
        },
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          leading: InkWell(
            hoverColor: Colors.black12,
            child: Container(
              padding: EdgeInsets.only(left: 10),
              color: Colors.transparent,
              child: const Icon(
                Icons.arrow_back_ios,
                size: 28,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title:  Text(
              _controller.metadata.title ?? "",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          /* actions: [
            IconButton(
              onPressed: () {},
              splashColor: Colors.deepOrangeAccent,
              highlightColor: Colors.black12,
              hoverColor: Colors.black12,
              icon: const Icon(
                Icons.share_sharp,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],*/
        ),
        body: player,
      ),
    );
  }
}
