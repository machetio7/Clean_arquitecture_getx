import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:paisa_example/core/utils/routes/app_routes.dart';
import 'package:paisa_example/di.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokémon App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.routes,
    );
  }
}