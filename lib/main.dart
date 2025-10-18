import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quiz_generator/models/user.dart';
import 'screens/start_up/splash_screen.dart';

import 'api/api.dart';

late final Api postmanApi;

final api =
    true // env['is_dev'] is String
    ? postmanApi
    : throw "Live API is UnImplemented";

final userController = UserController(User('', ''));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  postmanApi = await Api.init(
    baseUrl: dotenv.env['MOCK_BASEURL'] as String,
    apiKey: dotenv.env['MOCK_API_KEY'] as String,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practice Quiz Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
