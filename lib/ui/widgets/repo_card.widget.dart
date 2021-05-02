import 'package:c2sgithub/api/models/repo.model.dart';
import 'package:c2sgithub/utils/helpers/hex_color.helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoCardWidget extends StatelessWidget {
  final RepoModel data;

  const RepoCardWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(data.title ?? 'Unknown title'),
      subtitle: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(data.description ?? 'No description'),
            SizedBox(height: 8.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: HexColor.fromHex(
                      data.languageCode?.replaceFirst('#', '') ?? '#000000',
                    ),
                  ),
                ),
                SizedBox(width: 24.0),
                Text(data.language ?? 'Unknown language'),
              ],
            )
          ],
        ),
      ),
      trailing: GestureDetector(
        onTap: () async {
          try {
            await launch(data.url!);
          } catch (e) {
            print(e);
            ScaffoldMessenger.maybeOf(context)?.showSnackBar(
              SnackBar(
                content: Text('Could not open the link'),
              ),
            );
          }
        },
        child: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }
}
