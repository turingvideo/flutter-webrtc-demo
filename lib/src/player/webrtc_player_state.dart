import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_demo/src/player/player_panel/player_state.dart';
import 'package:flutter_webrtc_demo/src/player/webrtc_error.dart';

extension RTCPeerConnectionStateToPlayerState on RTCPeerConnectionState {
  PlayerState get playerState {
    switch (this) {
      case RTCPeerConnectionState.RTCPeerConnectionStateFailed:
        return PlayerState.error;
      case RTCPeerConnectionState.RTCPeerConnectionStateClosed:
      case RTCPeerConnectionState.RTCPeerConnectionStateConnected:
      case RTCPeerConnectionState.RTCPeerConnectionStateConnecting:
      case RTCPeerConnectionState.RTCPeerConnectionStateDisconnected:
      case RTCPeerConnectionState.RTCPeerConnectionStateNew:
        return PlayerState.connecting;
    }
  }
}

const webRTCConnectionError =
    WebrtcError(ErrorCode.socket, 'Connection Error', "Connection Error");

extension StringExtension on String {
  bool get isValidUri => Uri.tryParse(this)?.hasAbsolutePath ?? false;
}
