import 'package:c2sgithub/ui/widgets/profile.widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String ROUTE_NAME = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('C2SGitHub'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            ProfileWidget(
              avatarURL: 'https://avatars.githubusercontent.com/u/67547990?v=4',
              fullName: 'Peter A. Bizjak',
              username: 'sunderee',
              bio:
                  'Native and cross-platform mobile development, full-stack web development, microcontroller programming, and Linux administration. Linux guy.',
            ),
          ],
        ),
      ),
    );
  }
}
