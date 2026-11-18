import 'package:dolores_hoy/datos/config_claves.dart';
import 'package:dolores_hoy/datos/servicios.dart';
import 'package:dolores_hoy/presentacion/tablero_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'ayudas.dart';

TableroViewModel crear(Future<http.Response> Function(http.Request) h) {
  final c = seguro(h);
  return TableroViewModel(
    clima: ServicioClima(c),
    cambio: ServicioCambio(c),
    festivos: ServicioFestivos(c),
    wikipedia: ServicioWikipedia(c),
    nasa: ServicioNasa(c, const ConfigClaves(nasa: 'DEMO_KEY')),
  );
}

void main() {
  test('las 5 tarjetas cargan correctamente', () async {
    final vm = crear(servidorFalso);
    await vm.cargarTodo();

    expect(vm.clima.estado, Estado.listo);
    expect(vm.cambio.estado, Estado.listo);
    expect(vm.festivos.estado, Estado.listo);
    expect(vm.wiki.estado, Estado.listo);
    expect(vm.nasa.estado, Estado.listo);
    expect(vm.clima.dato!.temperatura, 24.3);
  });

  test('si UNA api falla, las otras cuatro siguen funcionando', () async {
    final vm = crear((r) async {
      if (r.url.host == 'api.nasa.gov') {
        return http.Response('{}', 500);
      }

      return await servidorFalso(r);
    });

    await vm.cargarTodo();

    expect(vm.nasa.estado, Estado.error);
    expect(vm.nasa.error, contains('500'));
    expect(vm.clima.estado, Estado.listo);
    expect(vm.cambio.estado, Estado.listo);
    expect(vm.wiki.estado, Estado.listo);
  });
}
