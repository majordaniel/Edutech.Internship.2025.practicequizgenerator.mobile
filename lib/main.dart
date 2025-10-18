import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quiz_generator/models/user.dart';
import 'screens/start_up/splash_screen.dart';

import 'api/api.dart';

late final Api api;

final userController = UserController(User('', ''));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  final isStaging = dotenv.env['is_dev'] is String;
  print('Env: isStaging = $isStaging');

  api = isStaging
      ? await Api.init(
          baseUrl: dotenv.env['MOCK_BASEURL'] as String,
          apiKey: dotenv.env['MOCK_API_KEY'] as String,
        )
      : await Api.init(
          baseUrl: dotenv.env['EDUTECH_SWAGGER_URL'] as String,
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
