import '../dominio/excepciones.dart';

/// Las claves NUNCA se escriben en el código.
/// Entran al compilar mediante --dart-define.
class ConfigClaves {
  final String nasa;

  const ConfigClaves({required this.nasa});

  /// DEMO_KEY es la clave pública de práctica de la NASA.
  factory ConfigClaves.desdeEntorno() => const ConfigClaves(
        nasa: String.fromEnvironment(
          'NASA_API_KEY',
          defaultValue: 'DEMO_KEY',
        ),
      );

  bool get usaClaveDemo => nasa == 'DEMO_KEY';

  void validar() {
    if (nasa.trim().isEmpty) {
      throw const ClaveFaltanteException('NASA_API_KEY');
    }
  }

  /// Oculta la clave para evitar filtrarla accidentalmente.
  @override
  String toString() => 'ConfigClaves(nasa: ${_ocultar(nasa)})';

  static String _ocultar(String s) => s.length <= 4
      ? '****'
      : '${s.substring(0, 2)}***${s.substring(s.length - 2)}';
}
