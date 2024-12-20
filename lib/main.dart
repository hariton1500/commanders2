import 'dart:io';

import 'package:commanders2/FLAME/game.dart';
import 'package:commanders2/globals.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //load map to app from csv file map1.csv
  String path = '.';
  try {
    if (!kIsWeb) {
      Directory appDocDir = Directory.current;
      appDocDir =  await getApplicationDocumentsDirectory();
      path = appDocDir.path;
    }
    print(path);
    mapList = loadMap('$path/map1.csv');
    print(mapList);
  } catch (e) {
    print(e);
  }
  runApp(const MainApp());
}

List<String> loadMap(String s) {
  //load csv file and return list of strings
  File textFile = File(s);
  List<String> lines = textFile.readAsLinesSync();
  return lines;
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GamePage()
    );
  }
}
