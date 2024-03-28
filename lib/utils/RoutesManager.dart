import 'package:flutter/material.dart';
import 'package:mobile_fincopay/pages/introduction/DiscoverPage.dart';
import 'package:mobile_fincopay/pages/BottomNavigationPage.dart';
import 'package:mobile_fincopay/pages/connexion/FindYourAccountPage.dart';
import 'package:mobile_fincopay/pages/connexion/ForgotYourPasswordPage.dart';
import 'package:mobile_fincopay/pages/connexion/LoginPage.dart';
import 'package:mobile_fincopay/pages/connexion/LoginWithPhoneNumberRequestOTPPage.dart';
import 'package:mobile_fincopay/pages/connexion/PasswordChangedPage.dart';
import 'package:mobile_fincopay/pages/connexion/SignUpPage.dart';
import 'package:mobile_fincopay/pages/home/MyHomePage.dart';
import 'package:mobile_fincopay/pages/home/NavigationDrawerMenu.dart';
import 'package:mobile_fincopay/pages/introduction/OnBoardingPage.dart';
import 'package:mobile_fincopay/pages/introduction/SplashScreen.dart';
import 'package:mobile_fincopay/pages/news/NotificationsPage.dart';
import 'package:mobile_fincopay/pages/user/EditProfilePage.dart';
import 'package:mobile_fincopay/pages/user/ProfilPage.dart';
import 'package:mobile_fincopay/settings/SettingsPage.dart';
import 'package:mobile_fincopay/settings/changepassword/ChangePasswordPage.dart';
import 'package:mobile_fincopay/settings/lockthumbprint/LockByThumbPrintPage.dart';
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

      case Routes.LoginWithPhoneNumberRequestOTPPageRoutes:
        return MaterialPageRoute(builder: (_) => LoginWithPhoneNumberRequestOTPPage());

      case Routes.FindYourAccountPageRoutes:
        return MaterialPageRoute(builder: (_) => FindYourAccountPage());

      case Routes.SignUpPagePageRoutes:
        return MaterialPageRoute(builder: (_) => SignUpPage());

      case Routes.ForgotYourPasswordPageRoutes:
        return MaterialPageRoute(builder: (_) => ForgotYourPassword());

      /*case Routes.CreateNewPasswordPageRoutes:
        return MaterialPageRoute(builder: (_) => CreateNewPasswordPage());*/

      case Routes.PasswordChangedPageRoutes:
        return MaterialPageRoute(builder: (_) => PasswordChangedPage());

      case Routes.BottomNavigationPageRoutes:
        return MaterialPageRoute(builder: (_) => BottomNavigationPage());

      case Routes.HomePageRoutes:
        return MaterialPageRoute(builder: (_) => MyHomePage());

      case Routes.ProfilPageRoutes:
        return MaterialPageRoute(builder: (_) => ProfilPage());

      case Routes.SettingsPageRoutes:
        return MaterialPageRoute(builder: (_) => SettingsPage());

      case Routes.NotificationsPageRoutes:
        return MaterialPageRoute(builder: (_) => NotificationsPage());

      case Routes.ChangePasswordPageRoutes:
        return MaterialPageRoute(builder: (_) => ChangePasswordPage());

      case Routes.NavigationDrawerMenuRoutes:
        return MaterialPageRoute(builder: (_) => NavigationDrawerMenu());

      case Routes.VerifyOtpLoginWithPhonePageRoutes:
        return MaterialPageRoute(builder: (_) => LoginWithPhoneNumberRequestOTPPage());

      case Routes.EditProfilePageRoutes:
        return MaterialPageRoute(builder: (_) => EditProfilePage());

      case Routes.OnBoardingPageRoutes:
        return MaterialPageRoute(builder: (_) => OnBoardingPage());

      case Routes.LockByThumbPrintPageRoutes:
        return MaterialPageRoute(builder: (_) => LockByThumbPrintPage());

      default:
        return null;
    }
  }
}