class WateringLog {
  final String time;
  final double temperature;
  final double humidity;
  final int soilMoisture;

  WateringLog({
    required this.time,
    required this.temperature,
    required this.humidity,
    required this.soilMoisture,
  });

  factory WateringLog.fromMap(String key, Map<dynamic, dynamic> data) {
    return WateringLog(
      time: key,
      temperature: (data['temperature'] ?? 0).toDouble(),
      humidity: (data['humidity'] ?? 0).toDouble(),
      soilMoisture: (data['soil_moisture'] ?? 0).toInt(),
    );
  }
}
