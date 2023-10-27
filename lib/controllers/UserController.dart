import 'package:fincodern/utils/Queries.dart';
import 'package:flutter/cupertino.dart';
import 'package:fincodern/models/UserModel.dart';
import 'package:fincodern/utils/Endpoints.dart';
import 'package:fincodern/utils/StockageKeys.dart';
import 'package:get_storage/get_storage.dart';

class UserController with ChangeNotifier {
  UserModel? user;
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
      user = UserModel.fromJson(response.data?['user'] ?? {});
      stockage?.write("user", response.data?["user"] ?? {});
      stockage?.write("token", response.data?["token"]?? "");

      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> login(Map data) async {
    var url = "${Endpoints.login}";
    HttpResponse response = await postData(url, data);
    if (response.status) {
      user = UserModel.fromJson(response.data?['user'] ?? {});
      stockage?.write(StockageKeys.tokenKey, response.data?["token"] ?? "");
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> logout(Map data) async {
    var url = "${Endpoints.logout}";
    stockage?.remove(StockageKeys.tokenKey);
    HttpResponse response = await postData(url, data);
    return response;
  }

  Future<HttpResponse> SendOTPRequest(Map data) async {
    var url = "${Endpoints.sendOTP}";
    HttpResponse response = await sendOTP(url, data);
    if (response.status) {
      user = UserModel.fromJson(response.data?['user'] ?? {});
      stockage?.write(StockageKeys.tokenKey, response.data?["token"] ?? "");
      notifyListeners();
    }
    return response;
  }

  Future<HttpResponse> verifyOTPRequest(Map data) async {
    var url = "${Endpoints.verifyOTP}";
    HttpResponse response = await verifyOTP(url, data);
    if (response.status) {
      user = UserModel.fromJson(response.data?['user'] ?? {});
      stockage?.write(StockageKeys.tokenKey, response.data?["token"] ?? "");
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
}
