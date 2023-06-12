import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

import '/resources/auth_methods.dart';

class JitsiMeetMethods {
  final AuthMethods _authMethods = AuthMethods();

  void createMeeting({
    required String myRoom,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      String name;
      if (username.isEmpty) {
        name = _authMethods.currentUser.displayName ?? 'Unknown';
      } else {
        name = username;
      }

      final JitsiMeetingOptions options = JitsiMeetingOptions(
        roomNameOrUrl: myRoom,
        // Required, spaces will be trimmed
        userDisplayName: name,
        userEmail: _authMethods.currentUser.email ?? 'unknown@email.com',
        userAvatarUrl: _authMethods.currentUser.photoURL ??
            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
        isAudioMuted: isAudioMuted,
        isVideoMuted: isVideoMuted,
      );

      await JitsiMeetWrapper.joinMeeting(
        options: options,
        listener: JitsiMeetingListener(
          onConferenceWillJoin: (url) => print(
            "onConferenceWillJoin: url: $url",
          ),
          onConferenceJoined: (url) => print(
            "onConferenceJoined: url: $url",
          ),
          onConferenceTerminated: (url, error) => print(
            "onConferenceTerminated: url: $url, error: $error",
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
