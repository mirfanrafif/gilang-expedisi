import 'package:flutter/material.dart';

const BASE_URL = 'https://api.gilangexpedisi.com';

void showErrorSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
