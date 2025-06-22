import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/plant_viewmodel.dart';

class PlantProvider extends ChangeNotifierProvider<PlantViewModel> {
  PlantProvider() : super(create: (_) => PlantViewModel());
}
