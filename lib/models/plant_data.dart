class PlantData {
  final double temperature;
  final double humidity;
  final int soilMoisture;
  final String pumpStatus;

  PlantData({
    required this.temperature,
    required this.humidity,
    required this.soilMoisture,
    required this.pumpStatus,
  });

  factory PlantData.fromMap(Map<dynamic, dynamic> data) {
    return PlantData(
      temperature: (data['temperature'] ?? 0).toDouble(),
      humidity: (data['humidity'] ?? 0).toDouble(),
      soilMoisture: (data['soil_moisture'] ?? 0).toInt(),
      pumpStatus: data['pump_status'] ?? 'OFF',
    );
  }
}
