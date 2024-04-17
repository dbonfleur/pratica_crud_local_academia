import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'controllers/usuario_controller.dart';
import 'services/usuario_service.dart';
import 'views/home_screen.dart';

Future<void> main() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    UsuarioService usuarioService = UsuarioService(); 
    UsuarioController usuarioController = UsuarioController(usuarioService);

    return MaterialApp(
      title: 'Gerenciamento de Usuários',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(controller: usuarioController)
    );
  }
}
