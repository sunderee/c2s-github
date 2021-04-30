final String profileQuery = r'''
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

String repositoriesQuery(int count) => '''
query {
    viewer {
        repositories(first: $count) {
            nodes {
                name
                description

                url
                isPrivate
                primaryLanguage {
                    color
                    name
                }

                stargazerCount
            }
        }
    }
}
''';
