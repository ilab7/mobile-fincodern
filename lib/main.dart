import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_fincopay/apps/MonApplication.dart';

void main() async {
  await GetStorage.init();

  ErrorWidget.builder = (FlutterErrorDetails details) {
    print(details.stack);
    return Scaffold(
      body: Center(
        child: Text("Erreur inattendue"),
      ),
    );
  };
  runApp(MonApplication());
}
