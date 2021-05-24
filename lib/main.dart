//import 'dart:html';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:convert';
import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;


Future<void> main() async {
  //query
  String readRepositories = """
  {
  testQuery {
    str
  }
 }
  """;

  Query(
    options: QueryOptions(
      document: gql(readRepositories), // this is the query string you just created
      variables: {
        'nRepositories': 50,
      },
      pollInterval: Duration(seconds: 10),
    ),
    // Just like in apollo refetch() could be used to manually trigger a refetch
    // while fetchMore() can be used for pagination purpose
    builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
      if (result.hasException) {
        return Text(result.exception.toString());
      }

      if (result.isLoading) {
        return Text('Loading');
      }

      // it can be either Map or List
      List repositories = result.data['viewer']['repositories']['nodes'];

      return ListView.builder(
          itemCount: repositories.length,
          itemBuilder: (context, index) {
            final repository = repositories[index];

            return Text(repository['name']);
          });
    },
  );


  //final dynamic body = {"query": "query testQuery { str }"};

  //https://ichi.pro/flutter-de-http-rikuesuto-o-okonau-hoho-229998064442607

  //リクエストにクエリパラメータを追加
  var url = Uri.parse("http://ec2-13-231-122-164.ap-northeast-1.compute.amazonaws.com:8000/graphql/");
  //Map<String, String> headers = {"Content-type": "application/json"};
  //String json = '{"title": "Hello", "body": "body text"}';
  //var response = await http.post(url, headers:headers,body: json);
  //int statusCode = response.statusCode;
  //String body =response.body;
  // {
  //   "title": "Hello",
  //   "body": "body text",
  // }


  var response1 = await http.get(url);
  int statusCode = response1.statusCode;
  Map<String, String> headers = response1.headers;
  String contentType = headers['content-type'];
  String json = response1.body;


  print("Response status: ${response1.statusCode}");
  print("Response body: ${response1.body}");
  //print("http read" + await http.read(url));

}




