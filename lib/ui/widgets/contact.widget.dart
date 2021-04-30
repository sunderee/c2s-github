import 'package:c2sgithub/utils/constants/color.const.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactWidget extends StatelessWidget {
  final String? company;
  final String? location;
  final String? website;

  const ContactWidget({
    Key? key,
    this.company,
    this.location,
    this.website,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        company != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_city_outlined),
                  SizedBox(width: 4.0),
                  Text(
                    company!,
                    style: TextStyle(
                      color: COLOR_TEXT_PRIMARY,
                      fontSize: 16.0,
                    ),
                  )
                ],
              )
            : SizedBox(),
        SizedBox(height: 8.0),
        location != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_on_outlined),
                  SizedBox(width: 4.0),
                  Text(
                    location!,
                    style: TextStyle(
                      color: COLOR_TEXT_PRIMARY,
                      fontSize: 16.0,
                    ),
                  )
                ],
              )
            : SizedBox(),
        SizedBox(height: 8.0),
        website != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.link_outlined),
                  SizedBox(width: 4.0),
                  GestureDetector(
                    onTap: () async {
                      try {
                        await launch(website!);
                      } catch (e) {
                        print(e);
                        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                          SnackBar(
                            content: Text('Could not open the link'),
                          ),
                        );
                      }
                    },
                    child: Text(
                      website!,
                      style: TextStyle(
                        color: COLOR_TEXT_PRIMARY,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              )
            : SizedBox(),
      ],
    );
  }
}
