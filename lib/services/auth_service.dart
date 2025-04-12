import 'dart:io';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthService {
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  final _secureStorage = FlutterSecureStorage();

  final _clientId = dotenv.env['AUTH0_CLIENT_ID']!;
  final _redirectUri = dotenv.env['AUTH0_REDIRECT_URI']!;
  final _issuer = dotenv.env['AUTH0_ISSUER']!;

  Future<void> login() async {
    final result = await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        _clientId,
        _redirectUri,
        issuer: _issuer,
        scopes: ['openid', 'profile', 'email'],
      ),
    );

    if (result != null) {
      await _secureStorage.write(
          key: 'access_token', value: result.accessToken);
      await _secureStorage.write(key: 'id_token', value: result.idToken);
    }
  }

  Future<void> logout() async {
    await _secureStorage.deleteAll();

    final logoutUrl =
        '$_issuer/v2/logout?client_id=$_clientId&returnTo=com.mentorbridge.app://logout-callback';

    final uri = Uri.parse(logoutUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: Platform.isIOS
            ? LaunchMode
                .platformDefault // for iOS (opens in SafariViewController)
            : LaunchMode.externalApplication, // for Android
      );
    } else {
      throw 'Could not launch logout URL';
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.read(key: 'access_token');
    return token != null;
  }
}
