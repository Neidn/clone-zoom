import 'dart:math';

import 'package:flutter/material.dart';

import '/resources/jitsi_meet_methods.dart';

import '/widgets/home_meeting_button.dart';

import '/screens/video_call_screen.dart';

class MeetingScreen extends StatelessWidget {
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  MeetingScreen({super.key});

  void createNewMeeting() async {
    var rand = Random();
    final String roomName = 'testRoom${rand.nextInt(999999)}';
    _jitsiMeetMethods.createMeeting(
      myRoom: roomName,
      isAudioMuted: true,
      isVideoMuted: true,
    );
  }

  void joinMeeting(BuildContext context) async {
    await Navigator.of(context).pushNamed(VideoCallScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // New Meeting, Join Meeting, Schedule, Share Screen
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButton(
              onPressed: () => createNewMeeting(),
              icon: Icons.videocam,
              text: 'New Meeting',
            ),
            HomeMeetingButton(
              onPressed: () => joinMeeting(context),
              icon: Icons.add_box,
              text: 'Join Meeting',
            ),
            HomeMeetingButton(
              onPressed: () {},
              icon: Icons.calendar_today,
              text: 'Schedule',
            ),
            HomeMeetingButton(
              onPressed: () {},
              icon: Icons.arrow_upward_rounded,
              text: 'Share Screen',
            ),
          ],
        ),

        //
        const Expanded(
          child: Center(
            child: Text(
              'Create/Join Meetings with just a tap!!',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
