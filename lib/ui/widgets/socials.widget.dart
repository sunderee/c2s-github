import 'package:c2sgithub/utils/constants/color.const.dart';
import 'package:flutter/material.dart';

class SocialsWidget extends StatelessWidget {
  final int followers;
  final int following;
  final int stars;

  const SocialsWidget({
    Key? key,
    required this.followers,
    required this.following,
    required this.stars,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _followersWidget(),
          SizedBox(width: 8.0),
          _starsWidget(),
        ],
      );

  Widget _followersWidget() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.people_outline),
          SizedBox(width: 4.0),
          RichText(
            text: TextSpan(
              text: followers.toString(),
              style: TextStyle(
                color: COLOR_TEXT_PRIMARY,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: ' followers • ',
                  style: TextStyle(
                    color: COLOR_TEXT_SECONDARY,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: following.toString(),
                  style: TextStyle(
                    color: COLOR_TEXT_PRIMARY,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' following',
                  style: TextStyle(
                    color: COLOR_TEXT_SECONDARY,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                  ),
                ),
                TextSpan(
                  text: '   •',
                  style: TextStyle(
                    color: COLOR_TEXT_PRIMARY,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        ],
      );

  Widget _starsWidget() => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_outline),
          SizedBox(width: 4.0),
          RichText(
            text: TextSpan(
              text: stars.toString(),
              style: TextStyle(
                color: COLOR_TEXT_PRIMARY,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: ' stars',
                  style: TextStyle(
                    color: COLOR_TEXT_SECONDARY,
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}
