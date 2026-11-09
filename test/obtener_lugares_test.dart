import 'package:flutter_test/flutter_test.dart';
import 'package:descubre_dolores/domain/entities/lugar_turistico.dart';
import 'package:descubre_dolores/domain/repositories/lugares_repository.dart';
import 'package:descubre_dolores/domain/usecases/obtener_lugar_por_id.dart';
import 'package:descubre_dolores/domain/usecases/obtener_lugares.dart';

class FakeLugaresRepository implements LugaresRepository {
  static const _lugares = [
    LugarTuristico(
      id: '1',
      nombre: 'Lugar de prueba',
      descripcion: 'Descripcion de prueba',
      categoria: 'Museo',
      imagenAsset: 'x.jpg',
      audioAsset: 'x.mp3',
    ),
  ];

  @override
  Future<List<LugarTuristico>> obtenerTodos() async => _lugares;

  @override
  Future<LugarTuristico?> obtenerPorId(String id) async {
    for (final lugar in _lugares) {
      if (lugar.id == id) return lugar;
    }
    return null;
  }
}

void main() {
  test('ObtenerLugares regresa la lista que entrega el repositorio', () async {
    final usecase = ObtenerLugares(FakeLugaresRepository());
    final resultado = await usecase();
    expect(resultado.length, 1);
    expect(resultado.first.nombre, 'Lugar de prueba');
  });

  test('ObtenerLugarPorId regresa el lugar si existe y null si no', () async {
    final usecase = ObtenerLugarPorId(FakeLugaresRepository());
    expect((await usecase('1'))?.nombre, 'Lugar de prueba');
    expect(await usecase('99'), isNull);
  });
}
