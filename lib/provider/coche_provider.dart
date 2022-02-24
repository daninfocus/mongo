import 'package:flutter/cupertino.dart';

import '../model/coche.dart';
import '../services/db_connection_service.dart';

class CocheProvider extends ChangeNotifier {
  List<Coche> _allCoches = [];
  List<Coche> _ogCoches = [];
  late DBConnectionService _dbConnectionService;
  CocheProvider() {
    _dbConnectionService = DBConnectionService();
  }

  List<Coche> get allCoches {
    return _allCoches;
  }

  set allCoches(List<Coche> coches) {
    _allCoches = coches;
    notifyListeners();
  }

  sortCoches(query) {
    List<Coche> cochesFiltrado = [];
    List<Coche> cochesAlreadyFiltered = [];
    allCoches.forEach((item) {
      if (item.make.toLowerCase().contains(query.toLowerCase()) ||
          item.model.toLowerCase().contains(query.toLowerCase())) {
        cochesFiltrado.add(item);
        cochesAlreadyFiltered.add(item);
      }
    });
    allCoches.forEach((item) {
      if (!cochesAlreadyFiltered.contains(item)) {
        cochesFiltrado.add(item);
      }
    });
    allCoches = cochesFiltrado;
  }

  sortAlphabetical() {
    allCoches.sort(((a, b) => a.make.compareTo(b.make)));
    notifyListeners();
  }

  sortPrice() {
    allCoches.sort(((a, b) => a.price.compareTo(b.price)));
    notifyListeners();
  }

  sortYear() {
    allCoches.sort(((a, b) => a.year.compareTo(b.year)));
    notifyListeners();
  }

  Future<List<Coche>> setAllCoches() async {
    _allCoches = await _dbConnectionService.getAllCoches();
    _ogCoches = _allCoches;
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

  Future<bool> deleteCoche(Coche coche) async {
    bool finished = await _dbConnectionService.deleteCar(coche);
    return finished;
  }
}
