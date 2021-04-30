import 'package:c2sgithub/ui/widgets/contact.widget.dart';
import 'package:c2sgithub/ui/widgets/socials.widget.dart';
import 'package:c2sgithub/utils/constants/color.const.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String avatarURL;
  final String fullName;
  final String username;
  final String bio;

  const ProfileWidget({
    Key? key,
    required this.avatarURL,
    required this.fullName,
    required this.username,
    required this.bio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 44,
                backgroundImage: NetworkImage(avatarURL),
              ),
              SizedBox(width: 20.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      fullName,
                      style: TextStyle(
                        color: COLOR_TEXT_PRIMARY,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      username,
                      style: TextStyle(
                        color: COLOR_TEXT_SECONDARY,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            bio,
            style: TextStyle(
              color: COLOR_TEXT_PRIMARY,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 8.0),
          SocialsWidget(
            followers: 4,
            following: 3,
            stars: 35,
          ),
          SizedBox(height: 8.0),
          ContactWidget(
            company: 'IPM Group',
            location: 'Ljubljana, Slovenia',
            website: 'https://sunderee.github.io',
          ),
        ],
      );
}
