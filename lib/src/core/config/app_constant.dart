import 'package:fire_alert_mobile/src/features/fire_alert/data/models/incident_type.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

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
  static const serverUrl = 'http://192.168.1.13:8000';
  static const apiUrl = '$serverUrl/api';
  static const apiUser = '$serverUrl/user';
  static const appName = 'FireGuard';
  static const googleApiKey = 'AIzaSyB6_K36bswcsPI2cK3iYlqr7JXLLpCY8WM';
  static List<IncidentType> incidentTypes = [
    IncidentType(name: "Fire Incidents", abbrv: "FIRE_INCIDENT"),
    IncidentType(name: "Vehicular Accidents", abbrv: "VEHICULAR_ACCIDENT"),
    IncidentType(name: "Natural Calamities", abbrv: "NATURAL_CALAMITIES"),
    IncidentType(name: "Others", abbrv: "OTHERS"),
  ];
  static Coords fireStation = Coords(14.5625316, 121.015261);
}
