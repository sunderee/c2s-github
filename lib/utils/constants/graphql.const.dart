const String PROFILE_QUERY = r'''
query {
    viewer {
        name
        login
        avatarUrl
        bio

        company
        location
        url

        followers { totalCount }
        following { totalCount }

        repositories { totalCount }
    }
}
''';
