import 'dart:math';
import 'motor_2048.dart';

class Grid {
  List<List<int?>> celdas;
  Grid(this.celdas);

  static Grid vacio() =>
      Grid(List.generate(4, (_) => List<int?>.filled(4, null)));

  int moverIzquierda() {
    var puntos = 0;
    for (var f = 0; f < celdas.length; f++) {
      final r = Motor2048.moverFilaIzquierda(celdas[f]);
      celdas[f] = r.fila;
      puntos += r.puntosGanados;
    }
    return puntos;
  }

  int moverDerecha() {
    var puntos = 0;
    for (var f = 0; f < celdas.length; f++) {
      final r = Motor2048.moverFilaIzquierda(celdas[f].reversed.toList());
      celdas[f] = r.fila.reversed.toList();
      puntos += r.puntosGanados;
    }
    return puntos;
  }

  List<List<int?>> _transponer(List<List<int?>> g) {
    final n = g.length;
    return List.generate(n, (i) => List<int?>.generate(n, (j) => g[j][i]));
  }

  int moverArriba() {
    celdas = _transponer(celdas);
    final p = moverIzquierda();
    celdas = _transponer(celdas);
    return p;
  }

  int moverAbajo() {
    celdas = _transponer(celdas);
    final p = moverDerecha();
    celdas = _transponer(celdas);
    return p;
  }

  void agregarFichaAleatoria({Random? aleatorio}) {
    final rnd = aleatorio ?? Random();
    final vacias = <List<int>>[];
    for (var f = 0; f < celdas.length; f++) {
      for (var c = 0; c < celdas[f].length; c++) {
        if (celdas[f][c] == null) vacias.add([f, c]);
      }
    }
    if (vacias.isEmpty) return;
    final e = vacias[rnd.nextInt(vacias.length)];
    celdas[e[0]][e[1]] = rnd.nextDouble() < 0.9 ? 2 : 4;
  }

  bool hayCeldasVacias() => celdas.expand((f) => f).any((v) => v == null);

  bool hayMovimientosPosibles() {
    if (hayCeldasVacias()) return true;
    for (var f = 0; f < celdas.length; f++) {
      for (var c = 0; c < celdas[f].length - 1; c++) {
        if (celdas[f][c] == celdas[f][c + 1]) return true;
      }
    }
    for (var c = 0; c < celdas.length; c++) {
      for (var f = 0; f < celdas.length - 1; f++) {
        if (celdas[f][c] == celdas[f + 1][c]) return true;
      }
    }
    return false;
  }

  bool haGanado(int objetivo) =>
      celdas.expand((f) => f).any((v) => v != null && v >= objetivo);
}
