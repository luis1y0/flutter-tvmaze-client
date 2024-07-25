import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

sealed class AuthEvent {}

class Signin extends AuthEvent {}

class Signout extends AuthEvent {}

sealed class AuthState {}

class AuthWaiting extends AuthState {}

class Authenticated extends AuthState {}

class NoAuthenticated extends AuthState {}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthWaiting()) {
    on<Signin>((event, emit) {
      SharedPreferences.getInstance().then(
        (prefs) => prefs.setBool('authenticated', true),
      );
      emit(Authenticated());
    });
    on<Signout>((event, emit) {
      SharedPreferences.getInstance().then(
        (prefs) => prefs.setBool('authenticated', false),
      );
      emit(NoAuthenticated());
    });
    _initAuth();
  }

  void _initAuth() async {
    var preferences = await SharedPreferences.getInstance();
    var authenticated = preferences.getBool('authenticated') ?? false;
    if (authenticated) {
      add(Signin());
    } else {
      add(Signout());
    }
  }
}
