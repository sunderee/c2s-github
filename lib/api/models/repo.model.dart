import 'package:meta/meta.dart';

@immutable
class RepoModel {
  final String? title;
  final String? description;
  final String? url;
  final String? languageCode;
  final String? language;

  const RepoModel._({
    this.title,
    this.description,
    this.url,
    this.languageCode,
    this.language,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) => RepoModel._(
        title: json['name'],
        description: json['description'],
        url: json['url'],
        languageCode: json['primaryLanguage'] != null
            ? json['primaryLanguage']['color']
            : '#000000',
        language: json['primaryLanguage'] != null
            ? json['primaryLanguage']['name']
            : '#000000',
      );
}
