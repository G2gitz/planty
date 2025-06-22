import 'dart:ui';
import 'package:flutter/material.dart';
import '../../models/plant_data.dart';

class PlantInfoCard extends StatelessWidget {
  final PlantData data;

  const PlantInfoCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        _dataCard("${data.soilMoisture}%", "Soil Moisture"),
        _dataCard("${data.temperature}°C", "Temperature"),
        _dataCard("${data.humidity}%", "Humidity"),
        _dataCard(data.pumpStatus == "ON" ? "🟢 ON" : "⚪ OFF", "Pump Status"),
      ],
    );
  }

  Widget _dataCard(String value, String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          height: 80,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1), // translucent glass effect
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withOpacity(0.05), width: 1),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
