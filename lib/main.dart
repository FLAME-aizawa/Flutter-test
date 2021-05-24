//import 'dart:html';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;


Future<void> main() async {
  String readRepositories = """
  query testQuery { str }
  """;

  final dynamic body = {"query": "query testQuery { str }"};
  var url = Uri.parse("http://ec2-13-231-122-164.ap-northeast-1.compute.amazonaws.com:8000/graphql/");
  //http.post(Uri.parse(url,body));

  //var response = await http.post(url,body: body);
  var response1 = await http.get(url);
  int statusCode = response1.statusCode;
  Map<String, String> headers = response1.headers;
  String contentType = headers['content-type'];
  String json = response1.body;

  print("Response status: ${response1.statusCode}");
  print("Response body: ${response1.body}");
  print(await http.read(url));
}




