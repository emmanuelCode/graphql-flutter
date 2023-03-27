import 'package:graphql/client.dart';


GraphQLClient graphQLClientInit() {


final httpLink = HttpLink(
  'https://localhost:8080/graphql',
);

final authLink = AuthLink(
  getToken: () async => '', //'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
);

Link link = authLink.concat(httpLink);

// /// subscriptions must be split otherwise `HttpLink` will. swallow them
// if (websocketEndpoint != null){
//   final _wsLink = WebSocketLink(websockeEndpoint);
//   _link = Link.split((request) => request.isSubscription, _wsLink, _link);
// }

return GraphQLClient(
  /// **NOTE** The default store is the InMemoryStore, which does NOT persist to disk
  cache: GraphQLCache(),
  link: link,
);
}



