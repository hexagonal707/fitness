import 'package:fitness/data/program_data.dart';
import 'package:fitness/routes.dart';
import 'package:fitness/screens/program/program_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  runApp(const MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProgramData>(create: (context) => ProgramData())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              fontFamily: 'Inter',
              brightness: Brightness.light,
              colorSchemeSeed: Colors.blue,
              useMaterial3: true),
          darkTheme: ThemeData(
              fontFamily: 'Inter',
              brightness: Brightness.dark,
              colorSchemeSeed: Colors.blue,
              useMaterial3: true),
          routes: appRoutes,
          home: const ProgramPage()),
    );
  }
}
