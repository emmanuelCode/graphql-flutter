import 'package:graphql/client.dart';

GraphQLClient graphQLClientInit() {
  final httpLink = HttpLink(
    'http://localhost:8080/graphql',
  );

  final authLink = AuthLink(
    getToken: () async => '', //'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
  );

  Link link = authLink.concat(httpLink);

  return GraphQLClient(
    cache: GraphQLCache(),
    link: link,
  );
}
