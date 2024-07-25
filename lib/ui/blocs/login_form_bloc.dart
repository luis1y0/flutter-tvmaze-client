import 'package:flutter_bloc/flutter_bloc.dart';

sealed class LoginFormEvent {}

class LoginFormPasswordVisibility extends LoginFormEvent {}

class LoginFormIntent extends LoginFormEvent {
  final String user;
  final String password;

  LoginFormIntent({required this.user, required this.password});
}

sealed class LoginFormState {
  bool passwordVisible;
  LoginFormState({this.passwordVisible = false});
}

class LoginFormDefault extends LoginFormState {
  LoginFormDefault({super.passwordVisible});
}

class LoginFormError extends LoginFormState {
  final String message;

  LoginFormError(this.message);
}

class LoginFormSuccess extends LoginFormState {}

class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  LoginFormBloc() : super(LoginFormDefault()) {
    on<LoginFormIntent>(
      (event, emit) =>
          _signInWithUserAndPassword(emit, event.user, event.password),
    );
    on<LoginFormPasswordVisibility>(
      (event, emit) => _switchPasswordVisibility(emit),
    );
  }

  void _signInWithUserAndPassword(
      Emitter<LoginFormState> emit, String user, String password) {
    if (user == 'admin' && password == 'password') {
      emit(LoginFormSuccess());
    } else {
      emit(LoginFormError('Either your user or password is incorrect.'));
    }
  }

  void _switchPasswordVisibility(Emitter<LoginFormState> emit) {
    emit(LoginFormDefault(passwordVisible: !state.passwordVisible));
  }
}
