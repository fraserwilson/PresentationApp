import 'package:presentation_app/crudbloc/repos/products_repository.dart';
import 'package:presentation_app/main_common.dart';
import 'crudbloc/repos/auth_repository.dart';
import 'flutter_config.dart';

void main(){
  final lunchConfig = FlavourConfig(
      appTitle: "WebView Tester",
      image: "assets/images/coffeeoffice.jpg",
      appType: false
  );

  final repository = ApiService();
  final authRepository = AuthRepo();

  mainCommon(lunchConfig, repository,authRepository);
}