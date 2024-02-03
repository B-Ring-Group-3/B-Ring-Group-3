import 'package:envied/envied.dart';
import 'package:built_value/built_value.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'TMDB_KEY')
  static const String tmdbApiKey = _Env.tmdbApiKey;
}
