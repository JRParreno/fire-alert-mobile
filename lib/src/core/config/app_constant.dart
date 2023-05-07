import 'package:flutter/material.dart';

class AppConstant {
  static const kMockupHeight = 812;
  static const kMockupWidth = 375;
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );
  static const clientId = 'Y97qvQ67JvU3WkORPcshk77koxQ9ly5CrWYASIBY';
  static const clientSecret =
      'CIcoBGUhhxMz3DUORPEfjjdDbdY7g7iLFzd9SzSE9pMkJaOhDlCVmuo1bYJfGpsDt5AC9cBM7kjlOLUpmwrAWfO1vJ5UYljnwJVPWXn3AIJ4efJe7yGZ7g8Tojkf2Ypd';
  static const apiUrl = 'http://192.168.1.3:8000/api';
}
