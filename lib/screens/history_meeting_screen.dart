import 'package:clone_zoom/resources/firestore_methods.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryMeetingScreen extends StatelessWidget {
  const HistoryMeetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreMethods().meetingHistoryStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong!'),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data?.docs.length,
          itemBuilder: (context, index) {
            final String meetingName =
                snapshot.data?.docs[index]['meetingName'];
            final String createdAt = DateFormat.yMMMd().format(
              snapshot.data?.docs[index]['createdAt'].toDate(),
            );

            return ListTile(
              title: Text(
                'Room Name: $meetingName',
              ),
              subtitle: Text(
                'Joined On: $createdAt',
              ),
            );
          },
        );
      },
    );
  }
}
