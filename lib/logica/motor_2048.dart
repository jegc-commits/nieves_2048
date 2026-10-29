class ResultadoFusion {
  final List<int?> fila;
  final int puntosGanados;
  ResultadoFusion(this.fila, this.puntosGanados);
}

class ResultadoMovimiento {
  final List<int?> fila;
  final int puntosGanados;
  final bool seMovio;
  ResultadoMovimiento(this.fila, this.puntosGanados, this.seMovio);
}

class Motor2048 {
  static List<int?> compactarFila(List<int?> fila) {
    final valores = fila.where((v) => v != null).toList();
    while (valores.length < fila.length) {
      valores.add(null);
    }
    return valores;
  }

  static ResultadoFusion fusionarFila(List<int?> filaCompactada) {
    final r = List<int?>.from(filaCompactada);
    var puntos = 0;
    for (var i = 0; i < r.length - 1; i++) {
      if (r[i] != null && r[i] == r[i + 1]) {
        r[i] = r[i]! * 2;
        puntos += r[i]!;
        r[i + 1] = null;
      }
    }
    return ResultadoFusion(r, puntos);
  }

  static ResultadoMovimiento moverFilaIzquierda(List<int?> original) {
    final fusion = fusionarFila(compactarFila(original));
    final fin = compactarFila(fusion.fila);
    var seMovio = false;
    for (var i = 0; i < original.length; i++) {
      if (original[i] != fin[i]) seMovio = true;
    }
    return ResultadoMovimiento(fin, fusion.puntosGanados, seMovio);
  }
}
