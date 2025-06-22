import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final _db = FirebaseDatabase.instance;

  DatabaseReference get plantMonitorRef => _db.ref('plant_monitor');
  DatabaseReference get wateringLogsRef => _db.ref('watering_logs');
}
