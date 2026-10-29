import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:nieves_2048/logica/grid.dart';

void main() {
  test('moverIzquierda aplica a 4 filas', () {
    final g = Grid([
      [null, 2, 2, null],
      [4, null, null, 4],
      [null, null, null, null],
      [2, 2, 2, 2],
    ]);
    final p = g.moverIzquierda();
    expect(g.celdas[0], [4, null, null, null]);
    expect(g.celdas[1], [8, null, null, null]);
    expect(g.celdas[2], [null, null, null, null]);
    expect(g.celdas[3], [4, 4, null, null]);
    expect(p, 20);
  });
  test('moverDerecha', () {
    final g = Grid.vacio();
    g.celdas[0] = [2, 2, null, null];
    g.moverDerecha();
    expect(g.celdas[0], [null, null, null, 4]);
  });
  test('moverArriba', () {
    final g = Grid.vacio();
    g.celdas[1][0] = 2;
    g.celdas[3][0] = 2;
    g.moverArriba();
    expect(g.celdas[0][0], 4);
  });
  test('moverAbajo', () {
    final g = Grid.vacio();
    g.celdas[0][0] = 2;
    g.moverAbajo();
    expect(g.celdas[3][0], 2);
  });
  test('agregarFichaAleatoria coloca una', () {
    final g = Grid.vacio();
    g.agregarFichaAleatoria(aleatorio: Random(1));
    expect(g.celdas.expand((f) => f).where((v) => v != null).length, 1);
  });
  test('agregarFichaAleatoria con grid lleno no hace nada', () {
    final g = Grid(List.generate(4, (_) => List<int?>.filled(4, 2)));
    g.agregarFichaAleatoria(aleatorio: Random(1));
    expect(g.celdas.expand((f) => f).every((v) => v == 2), true);
  });
  test('hayMovimientos: celda vacia', () {
    expect(Grid.vacio().hayMovimientosPosibles(), true);
  });
  test('hayMovimientos: fusion posible', () {
    final g = Grid([
      [2, 2, 4, 8],
      [4, 8, 16, 32],
      [2, 4, 8, 16],
      [4, 2, 4, 2],
    ]);
    expect(g.hayMovimientosPosibles(), true);
  });
  test('hayMovimientos: lleno sin fusiones', () {
    final g = Grid([
      [2, 4, 2, 4],
      [4, 2, 4, 2],
      [2, 4, 2, 4],
      [4, 2, 4, 2],
    ]);
    expect(g.hayMovimientosPosibles(), false);
  });
  test('haGanado verdadero', () {
    final g = Grid.vacio();
    g.celdas[0][0] = 2048;
    expect(g.haGanado(2048), true);
  });
  test('haGanado falso', () {
    final g = Grid.vacio();
    g.celdas[0][0] = 1024;
    expect(g.haGanado(2048), false);
  });
}
