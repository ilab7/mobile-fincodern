import 'package:fincodern/pages/user/EditProfilePage.dart';
import 'package:fincodern/settings/updatepassword/CreateNewPasswordUpdatedPage.dart';
import 'package:fincodern/settings/updatepassword/PasswordUpdatedPage.dart';
import 'package:fincodern/settings/updatepassword/UpdatePasswordPage.dart';
import 'package:fincodern/settings/SettingsPage.dart';
import 'package:fincodern/pages/news/NotificationsPage.dart';
import 'package:flutter/material.dart';
import 'Routes.dart';
import 'package:fincodern/introduction/DiscoverPage.dart';
import 'package:fincodern/introduction/SplashScreen.dart';
import 'package:fincodern/pages/BottomNavigationPage.dart';
import 'package:fincodern/pages/connexion/AccountFoundedPage.dart';
import 'package:fincodern/pages/connexion/CreateNewPasswordPage.dart';
import 'package:fincodern/pages/connexion/FindYourAccountPage.dart';
import 'package:fincodern/pages/connexion/ForgotYourPasswordPage.dart';
import 'package:fincodern/pages/connexion/LoginWithOTPPage.dart';
import 'package:fincodern/pages/connexion/PasswordChangedPage.dart';
import 'package:fincodern/pages/connexion/LoginPage.dart';
import 'package:fincodern/pages/connexion/SignUpPage.dart';
import 'package:fincodern/pages/home/HomePage.dart';
import 'package:fincodern/pages/user/ProfilPage.dart';

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

      case Routes.PasswordUpdatedPageRoutes:
        return MaterialPageRoute(builder: (_) => PasswordUpdatedPage());

      case Routes.EditProfilePageRoutes:
        return MaterialPageRoute(builder: (_) => EditProfilePage());
      default:
        return null;
    }
  }
}