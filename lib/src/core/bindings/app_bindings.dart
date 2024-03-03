import 'package:demarco_flutter_test/src/shared/utils/validation/validation_helper.dart';
import 'package:get_it/get_it.dart';

class AppBindings {
  ///[setupAppBindings] inicializa as dependências globais da aplicação
  static void setupAppBindings() {
    final getIt = GetIt.instance;
    getIt.registerFactory(() => ValidationHelper());
  }
}
