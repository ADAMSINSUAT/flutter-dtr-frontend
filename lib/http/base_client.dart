import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_dtr_prototype/http/http_routes.dart';
import 'dart:developer' as devtools show log;

import '../constants/routes.dart';
import '../ui/alert_dialog.dart';

class BaseClient {
  final BuildContext context;
  var client = http.Client();

  BaseClient(this.context);

  Future<dynamic> getAllUsers() async {
    var url = Uri.parse(baseUrl + httpGetAllUsersRoute);
    var response = await client.get(url);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      devtools.log("Error");
    }
  }

  Future<dynamic> loginUser(dynamic object) async {
    var url = Uri.parse(baseUrl + httpLoginRoute);
    var _payload = json.encode(object);
    var _headers = {
      'Content-Type': 'application/json',
    };

    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var response = await client
            .post(url, body: _payload, headers: _headers)
            .timeout(Duration(seconds: 3))
            .then((response) {
          devtools.log(response.toString());
          return response;
        });
        if (response.statusCode == 200) {
          return response.body;
        } else {
          devtools.log(response.body);
        }
      }
    } on SocketException catch (_) {
      return "Error";
    } on TimeoutException catch (_) {
      return "Timeout";
    } catch (e) {
      devtools.log(e.toString());
    }
  }
}
