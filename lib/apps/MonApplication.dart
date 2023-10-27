import 'package:flutter/material.dart';
import 'package:alice/alice.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/utils/Routes.dart';
import 'package:mobile_fincopay/utils/RoutesManager.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';

Alice alice = Alice(showNotification: true);

class MonApplication extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserController(stockage: box)),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (_, themeProvider, __) {
          return MaterialApp(
            theme: ThemeData(
              brightness: themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
              textTheme: GoogleFonts.montserratTextTheme(
                Theme.of(context).textTheme.apply(
                  bodyColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  displayColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            navigatorKey: alice.getNavigatorKey(),
            debugShowCheckedModeBanner: false,
            onGenerateRoute: RoutesManager.route,
            initialRoute: Routes.SplashScreenPageRoutes,
          );
        },
      ),
    );
  }
}