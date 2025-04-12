import 'dart:io';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthService {
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  final _secureStorage = FlutterSecureStorage();

  final _clientId = dotenv.env['AUTH0_CLIENT_ID']!;
  final _redirectUri = dotenv.env['AUTH0_REDIRECT_URI']!;
  final _issuer = dotenv.env['AUTH0_ISSUER']!;
  final _logoutRedirectUri = dotenv.env['AUTH0_LOGOUT_REDIRECT_URI']!;
  final _domain = dotenv.env['AUTH0_DOMAIN']!;

  Future<void> login() async {
    final result = await _appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        _clientId,
        _redirectUri,
        issuer: _issuer,
        scopes: ['openid', 'profile', 'email'],
        promptValues: ['login'],
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

    final logoutUrl = Uri.https(
      _domain,
      '/v2/logout',
      {
        'client_id': _clientId,
        'returnTo': _logoutRedirectUri,
        'federated': '',
      },
    );

    if (await canLaunchUrl(logoutUrl)) {
      await launchUrl(logoutUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch logout URL';
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _secureStorage.read(key: 'access_token');
    return token != null;
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    final idToken = await _secureStorage.read(key: 'id_token');
    if (idToken == null) return null;
    return JwtDecoder.decode(idToken);
  }

  Future<String?> getUserId() async {
    final userInfo = await getUserInfo();
    return userInfo?['sub']; // Auth0 user ID
  }

  Future<String?> getAccessToken() async {
    final secureStorage = FlutterSecureStorage();
    return await secureStorage.read(key: 'access_token');
  }

  Future<String?> getIdToken() async {
    final secureStorage = FlutterSecureStorage();
    return await secureStorage.read(key: 'id_token');
  }
}
