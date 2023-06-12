import 'package:flutter/material.dart';

import '/utils/colors.dart';

import '/resources/auth_methods.dart';
import '/resources/jitsi_meet_methods.dart';

import '/widgets/meeting_option.dart';

class VideoCallScreen extends StatefulWidget {
  static const routeName = '/video-call';

  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  late final TextEditingController _meetingIdController;
  late final TextEditingController _nameController;

  bool isAudioMute = true;
  bool isVideoMute = true;

  @override
  void initState() {
    _meetingIdController = TextEditingController();
    _nameController = TextEditingController(
      text: _authMethods.currentUser.displayName,
    );
    super.initState();
  }

  @override
  void dispose() {
    _meetingIdController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  _joinMeeting() {
    _jitsiMeetMethods.createMeeting(
      myRoom: _meetingIdController.text.trim(),
      username: _nameController.text.trim(),
      isAudioMuted: isAudioMute,
      isVideoMuted: isVideoMute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          'Join a Meeting',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Meeting ID
          SizedBox(
            height: 60,
            child: TextField(
              controller: _meetingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: secondaryColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Meeting ID',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),

          // Name
          SizedBox(
            height: 60,
            child: TextField(
              controller: _nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                fillColor: secondaryColor,
                filled: true,
                border: InputBorder.none,
                hintText: 'Name (Optional)',
                contentPadding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Join Button
          InkWell(
            onTap: () => _joinMeeting(),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Join',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Audio Mute
          MeetingOption(
            text: 'Mute Audio',
            isMute: isAudioMute,
            onChanged: (value) {
              setState(() {
                isAudioMute = value;
              });
            },
          ),

          // Video Mute
          MeetingOption(
            text: 'Turn Off Video',
            isMute: isVideoMute,
            onChanged: (value) {
              setState(() {
                isVideoMute = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
