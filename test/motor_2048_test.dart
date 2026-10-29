import 'package:flutter_test/flutter_test.dart';
import 'package:nieves_2048/logica/motor_2048.dart';

void main() {
  test('compactarFila quita huecos', () {
    expect(Motor2048.compactarFila([2, null, 4, null]), [2, 4, null, null]);
  });
  test('compactarFila sin huecos no cambia', () {
    expect(Motor2048.compactarFila([2, 4, 8, 16]), [2, 4, 8, 16]);
  });
  test('fusionarFila combina par', () {
    final r = Motor2048.fusionarFila([2, 2, 4, null]);
    expect(r.fila, [4, null, 4, null]);
    expect(r.puntosGanados, 4);
  });
  test('fusionarFila tres iguales fusiona una vez', () {
    final r = Motor2048.fusionarFila([2, 2, 2, null]);
    expect(r.fila, [4, null, 2, null]);
    expect(r.puntosGanados, 4);
  });
  test('moverFilaIzquierda compacta y fusiona', () {
    final r = Motor2048.moverFilaIzquierda([null, 2, 2, 4]);
    expect(r.fila, [4, 4, null, null]);
    expect(r.puntosGanados, 4);
    expect(r.seMovio, true);
  });
  test('fila final reporta seMovio falso', () {
    expect(Motor2048.moverFilaIzquierda([2, 4, null, null]).seMovio, false);
  });
}
