import '../../domain/entities/lugar_turistico.dart';

class LugaresLocalDataSource {
  List<LugarTuristico> obtenerLugares() {
    return const [
      LugarTuristico(
        id: '1',
        nombre: 'Jardín Principal',
        descripcion: 'El corazón de Dolores Hidalgo, rodeado de portales, cafés y puestos de nieves.',
        categoria: 'Plaza',
        imagenAsset: 'assets/images/jardin_principal.jpg',
        audioAsset: 'audio/jardin_principal.mp3',
      ),
      LugarTuristico(
        id: '2',
        nombre: 'Parroquia de Nuestra Señora de los Dolores',
        descripcion: 'El lugar donde Miguel Hidalgo dio el Grito de Independencia en 1810.',
        categoria: 'Templo',
        imagenAsset: 'assets/images/parroquia.jpg',
        audioAsset: 'audio/parroquia.mp3',
        videoAsset: 'assets/video/parroquia_fuente.mp4',
      ),
      LugarTuristico(
        id: '3',
        nombre: 'Museo Casa de Hidalgo',
        descripcion: 'La casa donde vivió el cura Miguel Hidalgo antes de la Independencia.',
        categoria: 'Museo',
        imagenAsset: 'assets/images/museo_hidalgo.jpg',
        audioAsset: 'audio/museo_hidalgo.mp3',
      ),
    ];
  }
}
