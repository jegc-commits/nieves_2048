import 'package:flutter_test/flutter_test.dart';
import 'package:nieves_2048/logica/direccion.dart';
import 'package:nieves_2048/logica/estado_juego.dart';
import 'package:nieves_2048/logica/grid.dart';
import 'package:nieves_2048/logica/motor_juego.dart';

int vacias(MotorJuego m) =>
    m.grid.celdas.expand((f) => f).where((v) => v == null).length;

void main() {
  test('mover sin desplazamiento no agrega ficha', () {
    final m = MotorJuego();
    m.grid = Grid([
      [2, 4, 8, 16],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ]);
    final antes = vacias(m);
    m.mover(Direccion.izquierda);
    expect(vacias(m), antes);
  });
  test('alcanzar objetivo gana', () {
    final m = MotorJuego();
    m.grid = Grid([
      [1024, 1024, null, null],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ]);
    m.mover(Direccion.izquierda);
    expect(m.estado, EstadoJuego.ganado);
    expect(m.puntaje, 2048);
  });
  test('serie de movimientos acumula puntaje', () {
    final m = MotorJuego();
    m.grid = Grid([
      [2, 2, null, null],
      [null, null, null, null],
      [null, null, null, null],
      [null, null, null, null],
    ]);
    m.mover(Direccion.izquierda);
    expect(m.grid.celdas[0][0], 4);
    expect(m.puntaje, 4);
    expect(m.estado, EstadoJuego.jugando);
  });
}
