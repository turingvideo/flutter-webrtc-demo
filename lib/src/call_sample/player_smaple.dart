import 'package:flutter/material.dart';
import 'package:flutter_webrtc_demo/src/player/webrtc_player_controller.dart';
import 'package:flutter_webrtc_demo/src/player/webrtc_player_state.dart';

import '../player/player_panel/player_live_view.dart';
import '../player/player_panel/player_settings.dart';
import '../player/player_panel/webrtc_player_panel.dart';
import '../player/webrtc_error.dart';
import '../player/webrtc_player_controls.dart';

class PlayerSample extends StatefulWidget {
  @override
  PlayerSampleState createState() => PlayerSampleState();
}

class PlayerSampleState extends State<PlayerSample> {
  WebRTCPlayerController playerController = WebRTCPlayerController();
  TextEditingController textEditingController = TextEditingController();

  String url = 'test';

  bool isCodeH264 = true;

  @override
  void initState() {
    super.initState();
    textEditingController.text = url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Webrtc Player'),
      ),
      body: Column(
        children: [
          TextField(
            controller: textEditingController,
            onChanged: (v) {
              setState(() {
                url = v;
              });
            },
            decoration: InputDecoration(
                suffix: IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                textEditingController.text = '';
                setState(() {
                  url = '';
                });
              },
            )),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              const Spacer(),
              Checkbox(
                  value: isCodeH264,
                  onChanged: (v) {
                    setState(() {
                      isCodeH264 = v!;
                    });
                  }),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isCodeH264 = true;
                    });
                  },
                  child: Text('H264')),
              const Spacer(),
              Checkbox(
                  value: !isCodeH264,
                  onChanged: (v) {
                    setState(() {
                      isCodeH264 = !v!;
                    });
                  }),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isCodeH264 = false;
                    });
                  },
                  child: Text('H265')),
              const Spacer(),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                playerController.setDataSource(url: url);
                // playerController.setTuringError(WebrtcError.none);
              },
              child: Text('Confirm')),
          SizedBox(height: 80),
          Container(
            height: (MediaQuery.of(context).size.width - 32) * 9 / 16,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: WebRTCPlayerControls(
              code: isCodeH264 ? WebrtcCodeType.h264 : WebrtcCodeType.h265,
              controller: playerController,
              panelBuilder: (context, rect) {
                return WebrtcPlayerPanel(
                  controller: playerController,
                  texturePos: rect,
                  settings: PlayerSettings.live(),
                  builder: (context) => PlayerLiveView(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
