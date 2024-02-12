import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_fincopay/models/UserModel.dart';
import 'package:mobile_fincopay/utils/Endpoints.dart';
import 'package:mobile_fincopay/utils/Queries.dart';
import 'package:mobile_fincopay/utils/StockageKeys.dart';

class UserController with ChangeNotifier {
  UserModel? user;
  String? token;
  bool loading = false;
  GetStorage? stockage;
  bool _isFirstTimeBienvenue = false;
  bool get isFirstTimeBienvenue {
    return stockage?.read<bool>(StockageKeys.is_first_time) ?? _isFirstTimeBienvenue;
  }

  set isFirstTimeBienvenue(bool value) {
    _isFirstTimeBienvenue = value;
    stockage?.write(StockageKeys.is_first_time, value);
  }

  UserController({this.stockage});

  Future<HttpResponse> register(Map data) async{
    var url = "${Endpoints.register}";
    HttpResponse response = await postData(url, data);
    if (response.status) {
      stockage?.write(StockageKeys.userKey, response.data?['data']['userId'] ?? {});
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> login(Map data) async {
    var url = "${Endpoints.login}";
    HttpResponse response = await postData(url, data);
    if (response.status) {
      stockage?.write(StockageKeys.tokenKey, response.data?["accessToken"] ?? "");
      notifyListeners();
    }
    return response;
  }

  void getDataAPI() async {
    var token = stockage?.read(StockageKeys.tokenKey);
    var url = Endpoints.userDetails;
    loading = true;
    notifyListeners();
    var response = await getData(url, token: token);
    if(response != null){
      user = UserModel.fromJson(response.data?['data']['userId'] ?? {});
      notifyListeners();
    }
    loading = false;
    notifyListeners();
  }

  Future<HttpResponse> logout(Map data) async{
    var url = "${Endpoints.logout}";
    stockage?.read(StockageKeys.tokenKey);
    HttpResponse response = await postData(url, data);
    return response;
  }

  Future<HttpResponse> verifyOTPRequest(Map data) async {
    var url = "${Endpoints.verifyOTP}";
    HttpResponse response = await postData(url, data);
    if (response.status) {
      user = UserModel.fromJson(response.data?['user'] ?? {});
      stockage?.write(StockageKeys.tokenKey, response.data?[""] ?? "");
      //stockage?.read(StockageKeys.tokenKey, response.data?['user']);
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> requestOTPPhoneNumber(Map data) async {
    var url = "${Endpoints.login_with_phoneNumber}";
    HttpResponse response = await postData(url, data);
    if (response.status) {
      stockage?.write(StockageKeys.userKey, response.data?['data']['userId'] ?? {});
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> ResendOTPForLoginWithPhoneNumber(Map data) async {
    var url = "${Endpoints.resend_login_OTP}";
    HttpResponse response = await postData(url, data);
    if (response.status) {
      stockage?.write(StockageKeys.userKey, response.data?['data']['userId'] ?? {});
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> SendOTPRequest(Map data) async {
    var url = "${Endpoints.login_with_phoneNumber}";
    HttpResponse response = await sendOTP(url, data);
    if (response.status) {
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> updateUserPassword(Map data) async{
    var url = "${Endpoints.updatePassword}";
    HttpResponse response = await updatePassword(url, data);

    if (response.status) {
      user = UserModel.fromJson(response.data?['user'] ?? {});
      stockage?.write("user", response.data?["user"] ?? {});
      stockage?.write("token", response.data?["token"]?? "");

      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> updateProfil(Map data) async {
    var url = "${Endpoints.updateProfil}";
    var token = stockage?.read(StockageKeys.tokenKey);

    HttpResponse response = await postData(url, data, token: token);
    if (response.status) {
      user = UserModel.fromJson(response.data?['user'] ?? {});
      stockage?.write("user", response.data?["user"] ?? {});
      stockage?.write("token", response.data?["token"]?? "");

      notifyListeners();
    }
    return response;
  }
}