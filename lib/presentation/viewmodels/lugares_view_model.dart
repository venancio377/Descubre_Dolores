import 'package:flutter/foundation.dart';

import '../../domain/entities/lugar_turistico.dart';
import '../../domain/usecases/obtener_lugares.dart';

class LugaresViewModel extends ChangeNotifier {
  final ObtenerLugares obtenerLugares;

  LugaresViewModel(this.obtenerLugares);

  static const categorias = ['Todos', 'Plaza', 'Templo', 'Museo'];

  List<LugarTuristico> _lugares = [];
  List<LugarTuristico> get lugares => _lugares;

  bool _cargando = false;
  bool get cargando => _cargando;

  String filtro = '';
  String categoriaFiltro = 'Todos';

  List<LugarTuristico> get filtrados {
    return _lugares.where((l) {
      final coincideNombre = l.nombre.toLowerCase().contains(filtro.toLowerCase());
      final coincideCategoria = categoriaFiltro == 'Todos' || l.categoria == categoriaFiltro;
      return coincideNombre && coincideCategoria;
    }).toList();
  }

  Future<void> cargar() async {
    _cargando = true;
    notifyListeners();
    _lugares = await obtenerLugares();
    _cargando = false;
    notifyListeners();
  }

  void buscar(String valor) {
    filtro = valor;
    notifyListeners();
  }

  void cambiarCategoria(String categoria) {
    categoriaFiltro = categoria;
    notifyListeners();
  }
}
