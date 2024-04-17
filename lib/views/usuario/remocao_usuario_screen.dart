// lib/views/usuarios/remocao_usuario_screen.dart
import 'package:flutter/material.dart';
import '../../controllers/usuario_controller.dart';
import '../../models/usuario.dart';

class RemocaoUsuarioScreen extends StatelessWidget {
  final UsuarioController controller;

  const RemocaoUsuarioScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Remoção de Usuário')),
      body: FutureBuilder<List<Usuario>>(
        future: controller.getAllUsuarios(),
        builder: (BuildContext context, AsyncSnapshot<List<Usuario>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erro ao carregar dados: ${snapshot.error}"));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text("Nenhum usuário encontrado."));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Usuario usuario = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('${usuario.nome} ${usuario.sobrenome}'),
                    subtitle: Text(usuario.email),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _showDeleteDialog(context, usuario.id),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int? userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmar"),
          content: const Text("Tem certeza que deseja remover este usuário?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha a caixa de diálogo
              },
            ),
            TextButton(
              child: const Text("Remover", style: TextStyle(color: Colors.red)),
              onPressed: () {
                if (userId != null) {
                  controller.deleteUsuario(userId).then((value) {
                    Navigator.of(context).pop(); // Fecha a caixa de diálogo
                    _showSnackBar(context, "Usuário removido com sucesso!");
                  }).catchError((error) {
                    Navigator.of(context).pop(); // Fecha a caixa de diálogo
                    _showSnackBar(context, "Erro ao remover usuário: $error");
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message))
    );
  }
}
