import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AppHelper {
  void showErrorSnackbar(context, errorMessage) {
    var snackBar = SnackBar(
      content: Text(
        errorMessage,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
        ),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void showSuccessSnackbar(context, successMessage) {
    var snackBar = SnackBar(
      content: Text(
        successMessage,
        style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 16.0, color: Colors.white),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

extension EmailValidator on String? {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this ?? "");
  }
}

enum Status {
  loading,
  loaded,
  error,
}