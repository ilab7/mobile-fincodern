import 'package:flutter/material.dart';
import 'package:mobile_fincopay/introduction/DiscoverPage.dart';
import 'package:mobile_fincopay/introduction/SplashScreen.dart';
import 'package:mobile_fincopay/pages/BottomNavigationPage.dart';
import 'package:mobile_fincopay/pages/connexion/AccountFoundedPage.dart';
import 'package:mobile_fincopay/pages/connexion/CreateNewPasswordPage.dart';
import 'package:mobile_fincopay/pages/connexion/FindYourAccountPage.dart';
import 'package:mobile_fincopay/pages/connexion/ForgotYourPasswordPage.dart';
import 'package:mobile_fincopay/pages/connexion/LoginPage.dart';
import 'package:mobile_fincopay/pages/connexion/LoginWithOTPPage.dart';
import 'package:mobile_fincopay/pages/connexion/PasswordChangedPage.dart';
import 'package:mobile_fincopay/pages/connexion/SignUpPage.dart';
import 'package:mobile_fincopay/pages/home/HomePage.dart';
import 'package:mobile_fincopay/pages/home/NavigationDrawerMenu.dart';
import 'package:mobile_fincopay/pages/news/NotificationsPage.dart';
import 'package:mobile_fincopay/pages/user/EditProfilePage.dart';
import 'package:mobile_fincopay/pages/user/ProfilPage.dart';
import 'package:mobile_fincopay/settings/SettingsPage.dart';
import 'package:mobile_fincopay/settings/updatepassword/CreateNewPasswordUpdatedPage.dart';
import 'package:mobile_fincopay/settings/updatepassword/UpdatePasswordPage.dart';
import 'Routes.dart';


class RoutesManager {
  static Route? route(RouteSettings r) {
    switch (r.name) {
      case Routes.SplashScreenPageRoutes:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case Routes.DiscoverPageRoutes:
        return MaterialPageRoute(builder: (_) => DiscoverPage());

      case Routes.LoginPageRoutes:
        return MaterialPageRoute(builder:  (_) => LoginPage());

      case Routes.LoginWithOTPPageRoutes:
        return MaterialPageRoute(builder: (_) => LoginWithOTPPage());

      case Routes.FindYourAccountPageRoutes:
        return MaterialPageRoute(builder: (_) => FindYourAccountPage());

      case Routes.AccountFoundedPageRoutes:
        return MaterialPageRoute(builder: (_) => AccountFoundedPage());

      case Routes.SignUpPagePageRoutes:
        return MaterialPageRoute(builder: (_) => SignUpPage());

      case Routes.ForgotYourPasswordPageRoutes:
        return MaterialPageRoute(builder: (_) => ForgotYourPassword());

      case Routes.CreateNewPasswordPageRoutes:
        return MaterialPageRoute(builder: (_) => CreateNewPasswordPage());

      case Routes.PasswordChangedPageRoutes:
        return MaterialPageRoute(builder: (_) => PasswordChangedPage());

      case Routes.BottomNavigationPageRoutes:
        return MaterialPageRoute(builder: (_) => BottomNavigationPage());

      case Routes.HomePageRoutes:
        return MaterialPageRoute(builder: (_) => HomePage());

      case Routes.ProfilPageRoutes:
        return MaterialPageRoute(builder: (_) => ProfilPage());

      case Routes.SettingsPageRoutes:
        return MaterialPageRoute(builder: (_) => SettingsPage());

      case Routes.NotificationsPageRoutes:
        return MaterialPageRoute(builder: (_) => NotificationsPage());

      case Routes.UpdatePasswordPageRoutes:
        return MaterialPageRoute(builder: (_) => UpdatePasswordPage());

      case Routes.CreateNewPasswordUpdatedPageRoutes:
        return MaterialPageRoute(builder: (_) => CreateNewPasswordUpdatedPage());

      case Routes.NavigationDrawerMenuRoutes:
        return MaterialPageRoute(builder: (_) => NavigationDrawerMenu());

      case Routes.EditProfilePageRoutes:
        return MaterialPageRoute(builder: (_) => EditProfilePage());

      default:
        return null;
    }
  }
}