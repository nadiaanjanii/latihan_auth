import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _idToken, userId;
  DateTime? _expiryDate;

  String? _tempidToken, tempuserId;
  DateTime? _tempexpiryDate;

  void temDate() {
    _idToken = _tempidToken;
    userId = tempuserId;
    _expiryDate = _tempexpiryDate;
    notifyListeners();
  }

  bool get isAuthProvider {
    return token != null;
  }

  String? get token {
    if (_idToken != null &&
        _expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now())) {
      return _idToken;
    } else {
      return null;
    }
  }

  Future<void> signup(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBEzJo6cIp2SlTW_UICfzhHoz2g9GnThwU");

    try {
      var response = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      var responseData = json.decode(response.body);

      if (responseData["error"] != null) {
        throw responseData["error"]["message"];
      }
      _tempidToken = responseData["idToken"];
      tempuserId = responseData["userId"];
      _tempexpiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData["expriyDate"],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBEzJo6cIp2SlTW_UICfzhHoz2g9GnThwU");

    try {
      var response = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      var responseData = json.decode(response.body);

      if (responseData["error"] != null) {
        throw responseData["error"]["message"];
      }
      _tempidToken = responseData["idToken"];
      tempuserId = responseData["userId"];
      _tempexpiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData["expriyDate"],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
