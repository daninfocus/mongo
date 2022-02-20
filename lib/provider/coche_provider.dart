import 'package:flutter/cupertino.dart';

import '../model/coche.dart';
import '../services/db_connection_service.dart';

class CocheProvider extends ChangeNotifier {
  List<Coche> _allCoches = [];
  late DBConnectionService _dbConnectionService;
  CocheProvider() {
    _dbConnectionService = DBConnectionService();
  }

  List<Coche> get allCoches {
    return _allCoches;
  }

  Future<List<Coche>> setAllCoches() async {
    _allCoches = await _dbConnectionService.getAllCoches();
    notifyListeners();
    return _allCoches;
  }

  Future<bool> updateCoche(Coche coche) async {
    bool finished = await _dbConnectionService.updateCar(coche.id!, coche);
    setAllCoches();
    return finished;
  }

  Future<bool> addCoche(Coche coche) async {
    bool finished = await _dbConnectionService.addCar(coche);
    setAllCoches();
    return finished;
  }
}
