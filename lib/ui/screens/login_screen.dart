import 'package:ballastlane_app/ui/blocs/auth_bloc.dart';
import 'package:ballastlane_app/ui/blocs/login_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loginBloc = LoginFormBloc();
  final TextEditingController _userTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: SingleChildScrollView(
            child: BlocConsumer<LoginFormBloc, LoginFormState>(
              bloc: loginBloc,
              listenWhen: (previous, current) => current is LoginFormSuccess,
              listener: (context, state) {
                var authBloc = Provider.of<AuthBloc>(context, listen: false);
                authBloc.add(Signin());
              },
              buildWhen: (previous, current) => current is! LoginFormSuccess,
              builder: (context, state) {
                String? errorMessage =
                    state is LoginFormError ? state.message : null;
                return Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AspectRatio(
                        aspectRatio: 1.0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent[100],
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepOrangeAccent[100]!,
                                offset: const Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Image.asset('assets/logo.png'),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _userTextController,
                        decoration: InputDecoration(
                          labelText: 'User',
                          errorText: errorMessage,
                        ),
                      ),
                      TextFormField(
                        controller: _passwordTextController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: GestureDetector(
                            child: const Icon(Icons.remove_red_eye),
                            onTap: () =>
                                loginBloc.add(LoginFormPasswordVisibility()),
                          ),
                        ),
                        obscureText: !state.passwordVisible,
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        child: const Text('SignIn'),
                        onPressed: () {
                          var user = _userTextController.text;
                          var password = _passwordTextController.text;
                          loginBloc.add(
                              LoginFormIntent(user: user, password: password));
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
