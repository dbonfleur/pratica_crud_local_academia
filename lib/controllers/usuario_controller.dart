// lib/controllers/usuario_controller.dart
import '../models/usuario.dart';
import '../services/usuario_service.dart';

class UsuarioController {
  final UsuarioService usuarioService;

  UsuarioController(this.usuarioService);

  Future<void> addUsuario(Usuario usuario) async {
    await usuarioService.inserirUsuario(usuario);
  }

  Future<List<Usuario>> getAllUsuarios() async {
    return await usuarioService.buscarUsuarios();
  }

  Future<void> updateUsuario(Usuario usuario) async {
    await usuarioService.atualizarUsuario(usuario);
  }

  Future<void> deleteUsuario(int id) async {
    await usuarioService.deletarUsuario(id);
  }
}