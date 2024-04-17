// lib/views/usuarios/visualizacao_usuarios_screen.dart
import 'package:flutter/material.dart';
import '../../controllers/usuario_controller.dart';
import '../../models/usuario.dart';

class VisualizacaoUsuariosScreen extends StatelessWidget {
  final UsuarioController controller;

  const VisualizacaoUsuariosScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visualização de Usuários'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Usuario>>(
        future: controller.getAllUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum usuário cadastrado.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Usuario usuario = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('${usuario.nome} ${usuario.sobrenome}'),
                    subtitle: Text('Email: ${usuario.email}\nTelefone: ${usuario.telefone}'),
                    trailing: const Icon(Icons.visibility),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Detalhes do Usuário'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('Nome: ${usuario.nome} ${usuario.sobrenome}'),
                                Text('Email: ${usuario.email}'),
                                Text('Data Nascimento: ${usuario.dataNascimento.day.toString().padLeft(2, '0')}/${usuario.dataNascimento.month.toString().padLeft(2, '0')}/${usuario.dataNascimento.year}'),
                                Text('Telefone: ${usuario.telefone}'),
                                Text('Telefone de Emergência: ${usuario.telefoneEmergencia}'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('Fechar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
