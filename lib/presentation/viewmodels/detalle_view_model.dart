import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/lugar_turistico.dart';

class DetalleViewModel extends ChangeNotifier {
  final LugarTuristico lugar;
  final AudioPlayer _reproductor = AudioPlayer();

  bool reproduciendo = false;
  String? error;

  DetalleViewModel(this.lugar);

  Future<void> alternarAudio() async {
    error = null;
    try {
      if (reproduciendo) {
        await _reproductor.pause();
      } else {
        await _reproductor.play(AssetSource(lugar.audioAsset));
      }
      reproduciendo = !reproduciendo;
    } catch (e) {
      // Pasa si todavía no copiaste el .mp3 en assets/audio/.
      error = 'Audioguía no disponible (assets/${lugar.audioAsset}).';
      reproduciendo = false;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _reproductor.dispose();
    super.dispose();
  }
}
