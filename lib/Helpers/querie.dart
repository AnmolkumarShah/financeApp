// all supporting queries

import 'dart:convert';

import 'package:finance_app/Helpers/network.dart';
import 'package:finance_app/Helpers/url_model.dart';

class Query {
  // method for all  query language commands
  static Future execute({String? query, String? p1 = '0'}) async {
    print(query);
    final UrlGlobal urlObject = UrlGlobal(
      p2: query!,
      p1: p1!,
    );
    try {
      final url = urlObject.getUrl();
      var result = await Network.get(url);
      dynamic data;
      if (result.body == "") throw "No User Found";
      try {
        data = json.decode(result.body) as List<dynamic>;
      } catch (e) {
        data = json.decode(result.body);
        return data;
      }
      return data;
    } catch (e) {
      return [];
    }
  }
}
