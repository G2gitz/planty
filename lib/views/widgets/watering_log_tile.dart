import 'dart:ui';
import 'package:flutter/material.dart';
import '../../models/watering_log.dart';

class WateringLogTile extends StatelessWidget {
  final WateringLog log;
  const WateringLogTile({required this.log});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: ListTile(
          title: Text(
            log.time,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          subtitle: Text(
            "Temp: ${log.temperature}°C, Hum: ${log.humidity}%, Moisture: ${log.soilMoisture}",
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
