import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/plant_viewmodel.dart';
import 'widgets/plant_info_card.dart';
import 'widgets/watering_log_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime _now;
  late final PlantViewModel vm;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    vm = Provider.of<PlantViewModel>(context, listen: false);
    vm.fetchPlantData();
    vm.fetchWateringLogs();
    _startClock();
  }

  void _startClock() {
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
      if (!mounted) return false;
      setState(() => _now = DateTime.now());
      return true;
    });
  }

  String getGreeting() {
    final hour = _now.hour;
    if (hour < 12) return "Good Morning 🌤️";
    if (hour < 17) return "Good Afternoon ☀️";
    if (hour < 20) return "Good Evening 🌇";
    return "Good Night 🌙";
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PlantViewModel>(context);

    return Scaffold(
      body: Stack(
        children: [
          // 🌿 Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/final_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 🍃 Glassmorphic content at bottom
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: RefreshIndicator(
                onRefresh: () async {
                  await vm.fetchPlantData();
                  await vm.fetchWateringLogs();
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 🌞 Greeting and Time
                      _glassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getGreeting(),
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${_now.hour.toString().padLeft(2, '0')}:${_now.minute.toString().padLeft(2, '0')}:${_now.second.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),

                      // 🌿 Plant Info
                      if (vm.currentData != null)
                        _glassCard(child: PlantInfoCard(data: vm.currentData!)),
                      SizedBox(height: 16),

                      // 💧 Watering Logs
                      _glassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "WATERING LOGS",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              height: 300,
                              child:
                                  vm.logs.isEmpty
                                      ? Center(
                                        child: Text(
                                          "No logs found",
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      )
                                      : ListView.builder(
                                        reverse: true,
                                        itemCount: vm.logs.length,
                                        itemBuilder:
                                            (context, index) => WateringLogTile(
                                              log: vm.logs[index],
                                            ),
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassCard({required Widget child}) {
    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
