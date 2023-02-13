import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../crud_bloc_Home.dart';
import '../cubits/auth_cubit.dart';
import '../cubits/auth_state.dart';
import '../cubits/product_cubit.dart';
import '../repos/auth_repository.dart';
import '../repos/products_repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.repo, required this.authRepo}) : super(key: key);
  final ApiService repo;
  final AuthRepo authRepo;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool loginPassword = true;
  void _toggle() {
    setState(() {
      loginPassword = !loginPassword;
    });
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Login Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => MultiBlocProvider(
                        providers: [
                          BlocProvider<ProductCubit>(
                              create: (context) =>
                                  ProductCubit(repo: widget.repo)),
                          BlocProvider<AuthCubit>(
                              create: (context) =>
                                  AuthCubit(repo: widget.authRepo)),
                        ],
                        child: ShoppingListApp(
                          repo: widget.repo,
                        )))).then((value){
              emailController.clear();
              passwordController.clear();
            });
          }
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "There was an error logging you in. Please try again later.")));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ))),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: loginPassword,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          loginPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          _toggle();
                        },
                      ),
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ))),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    onPressed: () async {
                      BlocProvider.of<AuthCubit>(context).LoginUser(
                          emailController.text.trim(),
                          passwordController.text);
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.black, width: 3),
                      // Background color
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
