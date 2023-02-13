
import 'package:presentation_app/crudbloc/repos/auth_repository.dart';
import 'package:presentation_app/crudbloc/repos/products_repository.dart';
import 'package:presentation_app/flutter_config.dart';

import 'main_common.dart';

void main(){

  final coffeeConfig = FlavourConfig(
    appTitle: "CRUD Bloc Example",
    image: "assets/images/coffeeoffice.jpg",
    appType: true
  );

  final repository = ApiService();
  final authRepository = AuthRepo();

  mainCommon(coffeeConfig,repository,authRepository);
}