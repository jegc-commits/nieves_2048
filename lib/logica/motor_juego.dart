import 'direccion.dart';
import 'estado_juego.dart';
import 'grid.dart';

class MotorJuego {
  Grid grid = Grid.vacio();
  int puntaje = 0;
  EstadoJuego estado = EstadoJuego.jugando;
  static const int objetivoVictoria = 2048;

  MotorJuego() {
    grid.agregarFichaAleatoria();
    grid.agregarFichaAleatoria();
  }

  void mover(Direccion d) {
    if (estado != EstadoJuego.jugando) return;
    final antes = grid.celdas.map((f) => List<int?>.from(f)).toList();
    final int puntos;
    switch (d) {
      case Direccion.izquierda:
        puntos = grid.moverIzquierda();
      case Direccion.derecha:
        puntos = grid.moverDerecha();
      case Direccion.arriba:
        puntos = grid.moverArriba();
      case Direccion.abajo:
        puntos = grid.moverAbajo();
    }
    puntaje += puntos;
    if (grid.haGanado(objetivoVictoria)) {
      estado = EstadoJuego.ganado;
      return;
    }
    if (!_iguales(antes, grid.celdas)) grid.agregarFichaAleatoria();
    if (!grid.hayMovimientosPosibles()) estado = EstadoJuego.perdido;
  }

  bool _iguales(List<List<int?>> a, List<List<int?>> b) {
    for (var f = 0; f < a.length; f++) {
      for (var c = 0; c < a[f].length; c++) {
        if (a[f][c] != b[f][c]) return false;
      }
    }
    return true;
  }
}
