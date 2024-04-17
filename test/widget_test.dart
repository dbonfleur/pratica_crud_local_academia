import 'package:flutter/material.dart';
import 'package:pratica_crud_local_academia/controllers/usuario_controller.dart';
import 'package:pratica_crud_local_academia/services/usuario_service.dart';
import 'package:pratica_crud_local_academia/views/home_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Este widget é a raiz do seu aplicativo.
  @override
  Widget build(BuildContext context) {
    // Inicializa o service e o controller
    UsuarioService usuarioService = UsuarioService(); // Supõe-se a criação de uma instância de UsuarioService
    UsuarioController usuarioController = UsuarioController(usuarioService);

    return MaterialApp(
      title: 'Gerenciamento de Usuários',
      theme: ThemeData(
        // Este é o tema do seu aplicativo.
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(controller: usuarioController), // Passe o controller para o HomeScreen
    );
  }
}
