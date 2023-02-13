import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation_app/crudbloc/screens/crud_bloc_Home.dart';
import 'package:presentation_app/crudbloc/cubits/auth_cubit.dart';
import 'package:presentation_app/crudbloc/cubits/product_cubit.dart';
import 'package:presentation_app/crudbloc/repos/auth_repository.dart';
import 'package:presentation_app/crudbloc/repos/products_repository.dart';
import 'package:presentation_app/crudbloc/screens/login_screen.dart';
import 'package:presentation_app/crudbloc/screens/register_page.dart';
import 'package:presentation_app/crudbloc/screens/update_item_screen.dart';
import 'package:presentation_app/flutter_config.dart';
import 'package:presentation_app/webview/webviewHome.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'crudbloc/screens/landing_screen.dart';

void mainCommon(
    FlavourConfig config, ApiService repo, AuthRepo authRepo) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    config: config,
    repo: repo,
    authRepo: authRepo,
  ));
}

class MyApp extends StatelessWidget {
  final FlavourConfig config;
  final ApiService repo;
  final AuthRepo authRepo;
  const MyApp(
      {super.key,
      required this.config,
      required this.repo,
      required this.authRepo});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        apptype: this.config.appType,
        repo: repo,
        authRepo: authRepo,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key,
      required this.apptype,
      required this.repo,
      required this.authRepo});

  final bool apptype;
  final ApiService repo;
  final AuthRepo authRepo;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..loadRequest(
        Uri.parse('https://flutter.dev'),
      );
  }

  @override
  Widget build(BuildContext context) {
    final AuthCubit _authCubit = AuthCubit(repo: widget.authRepo);
    final ProductCubit _productCubit = ProductCubit(repo: widget.repo);
    return MaterialApp(
      routes: {
        '/': (context) => widget.apptype
            ? MultiBlocProvider(
                providers: [
                    BlocProvider.value(value: _productCubit),
                    BlocProvider.value(value: _authCubit),
                  ],
                child: LandingPage(
                  repo: widget.repo,
                  authRepo: widget.authRepo,
                ))
            : WebViewTester(
                controller: controller,
              ),
        'shoppinglist': (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _productCubit),
                BlocProvider.value(value: _authCubit),
              ],
              child: ShoppingListApp(repo: widget.repo),
            ),
        'login': (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _productCubit),
                BlocProvider.value(value: _authCubit),
              ],
              child: LoginPage(
                repo: widget.repo,
                authRepo: widget.authRepo,
              ),
            ),
        'register': (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _productCubit),
                BlocProvider.value(value: _authCubit),
              ],
              child: RegisterPage(
                repo: widget.repo,
                authRepo: widget.authRepo,
              ),
            ),
      },
    );
  }
}
