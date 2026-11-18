import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../dominio/excepciones.dart';

class ClienteSeguro {
  final http.Client _cliente;
  final Duration espera;
  final int maxBytes;

  ClienteSeguro(
    this._cliente, {
    this.espera = const Duration(seconds: 8),
    this.maxBytes = 1024 * 1024,
  });

  static const _cabeceras = {
    'Accept': 'application/json',
    'User-Agent': 'DoloresHoy/1.0 (curso Flutter UTNG)',
  };

  Future<dynamic> obtenerJson(Uri uri) async {
    // Verificar que la conexión sea segura.
    if (uri.scheme != 'https') {
      throw const ConexionInseguraException();
    }

    http.Response r;

    try {
      r = await _cliente.get(uri, headers: _cabeceras).timeout(espera);
    } on SocketException {
      throw const SinConexionException();
    } on TimeoutException {
      throw const SinConexionException();
    } on http.ClientException {
      throw const SinConexionException();
    }

    // Verificar el código de respuesta.
    if (r.statusCode < 200 || r.statusCode >= 300) {
      throw ErrorServidorException(r.statusCode);
    }

    // Verificar el tamaño de la respuesta.
    if (r.bodyBytes.length > maxBytes) {
      throw const RespuestaDemasiadoGrandeException();
    }

    // Convertir la respuesta JSON.
    try {
      return jsonDecode(utf8.decode(r.bodyBytes));
    } catch (_) {
      throw const RespuestaInvalidaException();
    }
  }

  // Ocultar claves y tokens en las URL de los registros.
  static String redactar(Uri uri) {
    final texto = uri.toString();

    return texto.replaceAllMapped(
      RegExp(
        r'([?&](?:api_key|apikey|key|token|access_token)=)[^&]*',
        caseSensitive: false,
      ),
      (coincidencia) => '${coincidencia.group(1)}***',
    );
  }
}

// Convertir datos controlando errores.
T convertir<T>(T Function() f) {
  try {
    return f();
  } catch (_) {
    throw const RespuestaInvalidaException();
  }
}
