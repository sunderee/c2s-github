import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class HeadlineModel extends Equatable {
  final String? avatarURL;
  final String? fullName;
  final String? username;
  final String? bio;
  final String? company;
  final String? location;
  final String? website;
  final int? followers;
  final int? following;

  const HeadlineModel._({
    this.avatarURL,
    this.fullName,
    this.username,
    this.bio,
    this.company,
    this.location,
    this.website,
    this.followers,
    this.following,
  });

  factory HeadlineModel.fromJson(Map<String, dynamic> json) => HeadlineModel._(
        avatarURL: json['data']['viewer']['avatarUrl'],
        fullName: json['data']['viewer']['name'],
        username: json['data']['viewer']['login'],
        bio: json['data']['viewer']['bio'],
        company: json['data']['viewer']['company'],
        location: json['data']['viewer']['location'],
        website: json['data']['viewer']['url'],
        followers: json['data']['viewer']['followers']['totalCount'],
        following: json['data']['viewer']['following']['totalCount'],
      );

  @override
  List<Object?> get props => [
        avatarURL,
        fullName,
        username,
        bio,
        company,
        location,
        website,
        followers,
        following,
      ];
}
