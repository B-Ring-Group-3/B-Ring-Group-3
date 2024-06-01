import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'APIKEYID', obfuscate: true)
  static final String apiKeyId = _Env.apiKeyId;
  @EnviedField(varName: 'APIKEY', obfuscate: true)
  static final String apiKey = _Env.apiKey;
}