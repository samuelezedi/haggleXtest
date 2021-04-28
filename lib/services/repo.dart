import 'package:graphql_flutter/graphql_flutter.dart';

class Repository {
  String _baseUrl = "https://hagglex-backend-staging.herokuapp.com/graphql";
  Future<Map<String, dynamic>> registerUser(
      {String email,
      String password,
      String username,
      String phone,
      String refCode}) async {
    HttpLink httpLink =
        HttpLink("$_baseUrl");
    GraphQLCache cache = GraphQLCache();
    GraphQLClient graphQLClient = GraphQLClient(link: httpLink, cache: cache);
    String register = """
                          mutation {
                            register(
                                data: {
                                  email: "$email"
                                  username: "$username"
                                  password: "$password"
                                  phonenumber: "$phone"
                                  country: "Nigeria"
                                  currency: "NGN"
                                }
                              ) {
                                user {
                                  email,
                                  username,
                                  active,
                                  phonenumber,
                                  emailVerified,
                                  _id
                                }
                                token
                              }
                          }
                        """;
    MutationOptions options = MutationOptions(document: gql(register));
    try {
      QueryResult result = await graphQLClient.mutate(options);
      if(result.hasException)
        return {"type" : "error", "message" : result.exception.graphqlErrors[0].message};
      print(result. data);
      return {"type" : "success", "token" : result.data['register']['token'],"user":result.data['register']['user']};
    }catch(e){
      print(e.toString());
      return {"type": "error", "message":e.toString()};
    }
  }

  Future<Map<String, dynamic>> loginUser(
      {String email,
        String password,}) async {
    HttpLink httpLink =
    HttpLink("$_baseUrl");
    GraphQLCache cache = GraphQLCache();
    GraphQLClient graphQLClient = GraphQLClient(link: httpLink, cache: cache);
    String login = """
                          mutation {
                            login(
                                data: {
                                  input: "$email"
                                  password: "$password"
                                }
                              ) {
                                user {
                                  email,
                                  username,
                                  active,
                                  phonenumber,
                                  emailVerified,
                                  _id
                                }
                                token
                              }
                          }
                        """;
    MutationOptions options = MutationOptions(document: gql(login));
    try {
      QueryResult result = await graphQLClient.mutate(options);
      if(result.hasException) {

        return {
          "type": "error",
          "message": result.exception.graphqlErrors[0].message
        };
      }
      print(result. data);
      return {"type" : "success", "token" : result.data['login']['token'],"user":result.data['login']['user']};
    }catch(e){
      print(e.toString());
      return {"type": "error", "message":e.toString()};
    }
  }

  Future<Map> verifyUser(String code,String token)async {
    var headers = {
      "Authorization" : "Bearer $token"
    };
    HttpLink httpLink =
    HttpLink("https://hagglex-backend-staging.herokuapp.com/graphql",defaultHeaders: headers);
    GraphQLCache cache = GraphQLCache();
    GraphQLClient graphQLClient = GraphQLClient(link: httpLink, cache: cache);
    String verify = """
        mutation {
              verifyUser(data:{code:$code}) {
                token
              }
          }
        """;
    MutationOptions options = MutationOptions(document: gql(verify));
    try {
      QueryResult result = await graphQLClient.mutate(options);
      print(result.data);
      if(result.hasException)
        return {"type": "error", "message":result.exception.graphqlErrors[0].message};

      return {"type" : "success", "token" : result.data['verifyUser']['token']};
    }catch(e){
      print(e.toString());
      return {"type": "error", "message":e.toString()};
    }
  }

  Future<bool> resendVerification(String token,String email) async {
    var headers = {
      "Authorization" : "Bearer $token"
    };
    HttpLink httpLink =
    HttpLink("https://hagglex-backend-staging.herokuapp.com/graphql",defaultHeaders: headers);
    GraphQLCache cache = GraphQLCache();
    GraphQLClient graphQLClient = GraphQLClient(link: httpLink, cache: cache);
    String resendVerificationCode = """
                          query {
                              resendVerificationCode(data:{
                                email: "$email"
                              })
                            }
                        """;
    QueryOptions options = QueryOptions(document: gql(resendVerificationCode));
    try{
      QueryResult result = await graphQLClient.query(options);
      print(result.data);
      return result.data['resendVerificationCode'];
    }catch(e){
      print(e.toString());
      return false;
    }

  }

  Future<Map> getUser(String token, String id) async {
    print('here');
    print(id);
    print(token);
    var headers = {
      "Authorization" : "$token"
    };
    HttpLink httpLink =
    HttpLink("https://hagglex-backend-staging.herokuapp.com/graphql",defaultHeaders: headers);
    GraphQLCache cache = GraphQLCache();
    GraphQLClient graphQLClient = GraphQLClient(link: httpLink, cache: cache);
    String resendVerificationCode = """
                          query {
                              getUser(data:{
                                userId:"$id"
                              }){
                                username,
                                email,
                                active,
                                emailVerified,
                                phonenumber,
                                _id
                              }
                            }
                        """;
    QueryOptions options = QueryOptions(document: gql(resendVerificationCode));
    try{
      QueryResult result = await graphQLClient.query(options);
      print(result.data);
      return {"type":"success","user":result.data};
    }catch(e){
      print(e.toString());
      return {"type":"error","message":e.toString()};
    }
  }
}
