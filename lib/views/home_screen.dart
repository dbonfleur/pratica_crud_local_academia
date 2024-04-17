// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../controllers/usuario_controller.dart';
import 'usuario/atualizacao_usuario_screen.dart';
import 'usuario/cadastro_usuario_screen.dart';
import 'usuario/remocao_usuario_screen.dart';
import 'usuario/visualizacao_usuarios_screen.dart';

class HomeScreen extends StatefulWidget {
  final UsuarioController controller;

  const HomeScreen({super.key, required this.controller});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      CadastroUsuarioScreen(controller: widget.controller),
      AtualizacaoUsuarioScreen(controller: widget.controller),
      VisualizacaoUsuariosScreen(controller: widget.controller),
      RemocaoUsuarioScreen(controller: widget.controller),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Cadastrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Atualizar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'Visualizar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Remover',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
      ),
    );
  }
}
