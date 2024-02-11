import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_fincopay/utils/Constantes.dart';
import '../apps/MonApplication.dart';

class HttpResponse {
  bool status;
  Map? data;
  String? errorMsg;
  bool? isError;
  bool? isException;

  HttpResponse({
    required this.status,
    this.data,
    this.errorMsg,
    this.isError,
    this.isException
  });

}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

Future<dynamic> getData(String url_api, {String? token}) async {
  try {
    var url = Uri.parse("${Constantes.BASE_URL}$url_api");
    var response = await http.get(url,
      headers: {
        "Authorization" : "Bearer ${token}"
      }
    ).timeout(Duration(seconds: 1));
    if (response.statusCode == 200) {
      print('BEHOLD TOKENNNNNNNNNNNNNNNNNNNNNNNN ::::::::: $token');
      return json.decode(response.body);
    }
    return null;
  } catch (e, trace) {
    print(e.toString());
    print(trace.toString());
    return null;
  }
}

Future<HttpResponse> patchData(String api_url, Map data, {String? token}) async {
  try {
    var url = Uri.parse("${Constantes.BASE_URL}$api_url");
    String dataStr = json.encode(data);
    var response = await http.patch(url, body: dataStr, headers: {
      "Content-Type" : "application/json",
      "Authorization" : "Bearer $token"
    }).timeout(Duration(seconds: 1));

    var successList = [200, 201];
    var message = json.decode(response.body);
    var status = successList.contains(response.statusCode);
    return HttpResponse(status: status, data: message);
  } catch (e, trace) {
    print(e.toString());
    print(trace.toString());

    return HttpResponse(
        status: false, errorMsg: "Something wrong happened !", isException: true
    );

  }
}

Future<HttpResponse> postData(String api_url, Map data, {String? token}) async {
  try {
    var url = Uri.parse("${Constantes.BASE_URL}$api_url");

    String dataStr = json.encode(data);
    var _tkn = token;
    var response = await http.post(url, body: dataStr, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $_tkn"
    }).timeout(Duration(seconds: 5));

    if (!kReleaseMode) alice.onHttpResponse(response);
    var successList = [200, 201];

    var msg = json.decode(response.body);
    var st = successList.contains(response.statusCode);
    if (response.statusCode == 500) throw Exception(msg);

    return HttpResponse(status: st, data: msg);
  } catch (e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());
    return HttpResponse(
        status: false,
        errorMsg: "Unexpected error, connexion's problem",
        isException: true);
  }
}

Future<HttpResponse> sendOTP(String api_url, Map data, {String? token}) async {
  try {
    var url = Uri.parse("${Constantes.BASE_URL}$api_url");
    String dataStr = json.encode(data);
    var response = await http.post(
      url,
      body: dataStr, headers: {
      "Content-Type" : "application/json",
      "Authorization" : "Bearer $token"
    }).timeout(Duration(seconds: 1));

    var successList = [200, 201];
    var message = json.decode(response.body);
    var status = successList.contains(response.statusCode);
    if (response.statusCode == 500) throw Exception(message);
    return HttpResponse(status: status, data: message);

  } catch (e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());

    return HttpResponse(
        status: false,
        errorMsg: "Something wrong happened !",
        isException: true
    );
  }
}

Future<HttpResponse> verifyOTP(String api_url, Map data, {String? token}) async {
  try{
    var url = Uri.parse("${Constantes.BASE_URL}$api_url");
    print("url mouvement === $url");

    String dataStr = json.encode(data);
    var response = await http.post(
        url,
        body: dataStr, headers: {
      "Content-Type" : "application/json",
      "Authorization" : "Bearer $token"
    }).timeout(Duration(seconds: 1));

    var successList = [200, 201];
    var message = json.decode(response.body);
    var status = successList.contains(response.statusCode);
    if (response.statusCode == 500) throw Exception(message);
    return HttpResponse(status: status, data: message);

  } catch (e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());

    return HttpResponse(
        status: false,
        errorMsg: "Something wrong happened !",
        isException: true
    );
  }
}

Future<HttpResponse> updateData(String endpoint, Map data, {String? token}) async {
  try {
    final url = "${Constantes.BASE_URL}$endpoint";
    final jsonData = json.encode(data);

    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonData,
    );

    final successList = [200, 201];
    final message = json.decode(response.body);
    final status = successList.contains(response.statusCode);

    if (response.statusCode == 500) {
      throw Exception(message);
    }

    return HttpResponse(status: status, data: message);
  } catch (e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());

    return HttpResponse(
      status: false,
      errorMsg: "Something wrong happened!",
      isException: true,
    );
  }
}

Future<HttpResponse> updatePassword(String endpoint, Map data, {String? token}) async {

  try {
    final url = "${Constantes.BASE_URL}$endpoint";

    final jsonData = json.encode(data);

    final response = await http.put(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
      body: jsonData,
    );

    final successList = [200, 201];
    final message = json.decode(response.body);
    final status = successList.contains(response.statusCode);

    if (response.statusCode == 500) {
      throw Exception(message);
    }

    return HttpResponse(status: status, data: message);
  } catch (e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());

    return HttpResponse(
      status: false,
      errorMsg: "Something wrong happened!",
      isException: true,
    );
  }

}

Future<HttpResponse> deleteData(String endpoint, {String? token}) async {
  try {
    final url = "${Constantes.BASE_URL}$endpoint";

    final response = await http.delete(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );

    final successList = [200, 201];
    final message = json.decode(response.body);
    final status = successList.contains(response.statusCode);

    if (response.statusCode == 500) {
      throw Exception(message);
    }

    return HttpResponse(status: status, data: message);
  } catch (e, trace) {
    printWrapped(e.toString());
    printWrapped(trace.toString());

    return HttpResponse(
      status: false,
      errorMsg: "Something wrong happened!",
      isException: true,
    );
  }
}