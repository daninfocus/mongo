import 'package:flutter/cupertino.dart';

import '../model/coche.dart';
import '../services/db_connection_service.dart';

class CocheProvider extends ChangeNotifier {
  List<Coche> _allCoches = [];

  List<Coche> get allCoches {
    return _allCoches;
  }

  Future<List<Coche>> setAllCoches() async {
    DBConnectionService dbConnectionService = DBConnectionService();
    _allCoches = await dbConnectionService.getAllCoches();
    return _allCoches;
  }
}
