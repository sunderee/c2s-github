import 'package:c2sgithub/api/repositories/profile.repository.dart';
import 'package:c2sgithub/api/repositories/repo.repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should fetch headline info', () async {
    final repository = ProfileRepository.instance();
    final headline = await repository.fetchProfile();
    print('${headline.first}, total count: ${headline.second}');
    expect(headline.first.fullName?.isNotEmpty ?? false, true);
    expect(headline.second > 0, true);
  });

  test('should fetch repositories', () async {
    final repository = RepoRepository.instance();
    final data = await repository.fetchRepositories(39);
    print('Fetched ${data.first.length} repositories, ${data.second} stars');
    expect(data.first.isNotEmpty, true);
    expect(data.second > 0, true);
  });
}
