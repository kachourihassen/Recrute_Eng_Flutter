import 'package:flutter/material.dart';
import 'package:gestionuser/Pages/HomePage.dart';
import 'package:gestionuser/Pages/YassinePage/video_player_widget.dart';

import 'package:video_player/video_player.dart';

class AssetPlayerWidget extends StatefulWidget {
  @override
  _AssetPlayerWidgetState createState() => _AssetPlayerWidgetState();
}

class _AssetPlayerWidgetState extends State<AssetPlayerWidget> {
  final asset = 'assets/video.mp4';
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(asset)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMuted = controller.value.volume == 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false)),
        // title: const Text('Upgrade'),
      ),
      backgroundColor: const Color(0x6f354568),
      body: Container(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  VideoPlayerWidget(controller: controller),
                  const SizedBox(height: 32),
                  if (controller != null && controller.value.initialized)
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.red,
                      child: IconButton(
                        icon: Icon(
                          isMuted ? Icons.volume_mute : Icons.volume_up,
                          color: Colors.white,
                        ),
                        onPressed: () => controller.setVolume(isMuted ? 1 : 0),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
