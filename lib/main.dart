import 'package:ballastlane_app/domain/repositories/api_repository.dart';
import 'package:ballastlane_app/implementation/repositories/tvmaze_repository.dart';
import 'package:ballastlane_app/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiRepository>(create: (_) => TvmazeRepository(http.Client())),
      ],
      child: MaterialApp(
        title: 'Ballastlane App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
