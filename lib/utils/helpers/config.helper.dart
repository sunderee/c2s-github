import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

Future<String?> loadToken() async => compute<String, String?>(
      _parseLoadToken,
      'assets/config.json',
    );

Future<String?> _parseLoadToken(String assetPath) async {
  try {
    return (json.decode(await rootBundle.loadString(assetPath))
        as Map<String, dynamic>)['github_token'] as String;
  } catch (exception) {
    print('Exception occurred loading token:\n$exception');
    return null;
  }
}
