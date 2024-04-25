import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_nxt/Constants/api_constants.dart';
import 'package:grocery_nxt/Services/network_util.dart';
import 'package:grocery_nxt/Utils/shared_pref_utils.dart';
import 'package:grocery_nxt/Utils/toast_util.dart';
import 'package:http/http.dart' as http;

class HttpService {
  // ignore: non_constant_identifier_names
  static String BASE_URL = ApiConstants().baseUrl;

  //
  static Future<dynamic> postRequest(
      String apiEndPoint, Map<String, dynamic> postData,
      {bool insertHeader = false}) async {
    if(NetworkUtil.connectivityResult == ConnectivityResult.none){
      ToastUtil().showToast(color: Colors.red,message: "No Internet Connection");
      throw NoServiceFoundException('No Service Found');
    }
    Uri uri = Uri.parse(BASE_URL + apiEndPoint);
    var client = http.Client();
    try {
      var response = await client.post(
        uri,
        headers: insertHeader
            ? {
                'content-type': 'application/json',
                'accept': 'application/json',
                'authorization': 'Bearer '+await SharedPrefUtils().getToken()
              }
            : {'content-type': 'application/json'},
        body: json.encode(postData),
      );
      return response;
    } on SocketException catch (e) {
      return e;
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    }
  }

  //
  static Future<dynamic> getRequest(String apiEndPoint,
      {bool insertHeader = true}) async {
    if(NetworkUtil.connectivityResult == ConnectivityResult.none){
      ToastUtil().showToast(color: Colors.red,message: "No Internet Connection");
      throw NoServiceFoundException('No Service Found');
    }
    print(await SharedPrefUtils().getToken());
    var response;
    Uri uri = Uri.parse(BASE_URL + apiEndPoint);
    print(uri.query);
    var client = http.Client();
    try {
      response = await client
          .get(uri,
              headers: insertHeader
                  ? {
                      'content-type': 'application/json',
                      'accept': 'application/json',
                      'authorization': "Bearer "+await SharedPrefUtils().getToken(),
                      'x-api-key': "b8f4a0ba4537ad6c3ee41ec0a43549d1"
                    }
                  : {'content-type': 'application/json'})
          .timeout(const Duration(seconds: 10), onTimeout: () {
        return http.Response('Timeout', 408);
      });
      //handleExceptions(response);
      return response;
    } on SocketException catch (e) {
      return e;
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    }
  }

 /* //
  static handleExceptions(http.Response response){

    if(response.statusCode==401){
      ToastUtil().showToast(color: Colors.red,message: "Session Expired");
      Get.offAll(()=>const LoginScreen());
    }
    else if(response.statusCode==400){
      if((jsonDecode(response.body)as Map<String,dynamic>).containsKey("error")){
        ToastUtil().showToast(color: Colors.red,message: jsonDecode(response.body)["error"]);
      }else if((jsonDecode(response.body)as Map<String,dynamic>).containsKey("errors")){
        ToastUtil().showToast(color: Colors.red,message: jsonDecode(response.body)["errors"][0]["msg"]);
      }
    }
  }*/

}

class NoInternetException {
  String message;

  NoInternetException(this.message);
}

class NoServiceFoundException {
  String message;

  NoServiceFoundException(this.message);
}

class InvalidFormatException {
  String message;

  InvalidFormatException(this.message);
}

class UnknownException {
  String message;

  UnknownException(this.message);
}
