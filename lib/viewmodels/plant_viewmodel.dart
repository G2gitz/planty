import 'package:flutter/material.dart';
import '../core/services/firebase_service.dart';
import '../models/plant_data.dart';
import '../models/watering_log.dart';

class PlantViewModel extends ChangeNotifier {
  final _firebaseService = FirebaseService();

  PlantData? currentData;
  List<WateringLog> logs = [];

  Future<void> fetchPlantData() async {
    final snapshot = await _firebaseService.plantMonitorRef.get();
    if (snapshot.exists) {
      currentData = PlantData.fromMap(snapshot.value as Map);
      notifyListeners();
    }
  }

  Future<void> fetchWateringLogs() async {
    final snapshot = await _firebaseService.wateringLogsRef.get();
    if (snapshot.exists) {
      logs = [];
      final data = snapshot.value as Map;
      data.forEach((key, value) {
        logs.add(WateringLog.fromMap(key, value));
      });
      logs.sort((a, b) => b.time.compareTo(a.time)); // Latest first
      notifyListeners();
    }
  }
}
