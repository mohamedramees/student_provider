import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; 
import 'package:provider/provider.dart';
import 'package:student_management_provider/controller/student_provider.dart';
import 'package:student_management_provider/model/student_model.dart';
import 'package:student_management_provider/screens/student_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await Hive.initFlutter(); 
  Hive.registerAdapter(StudentAdapter());
  await Hive.openBox<Student>('Student');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.lightGreen,
  primaryColor: Colors.lightGreenAccent[400], 
  scaffoldBackgroundColor: const Color(0xFF000000), 
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1A1A1A), 
    foregroundColor: Colors.white, 
  ),
  buttonTheme:  ButtonThemeData(
    buttonColor: Colors.lightGreenAccent[400], 
    textTheme: ButtonTextTheme.primary,
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF333333), 
    hintStyle: const TextStyle(color: Colors.grey),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white), 
    bodyMedium: TextStyle(color: Color(0xFFB0B0B0)), 
  ),
  cardTheme: const CardTheme(
    color: Color(0xFF212121), 
  ),
  iconTheme: const IconThemeData(color: Colors.white), 
  
),

        home: StudentList(),
      ),
    );
  }
}
