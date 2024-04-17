// lib/views/usuarios/atualizacao_usuario_screen.dart
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../controllers/usuario_controller.dart';
import '../../models/usuario.dart';

class AtualizacaoUsuarioScreen extends StatefulWidget {
  final UsuarioController controller;
  final Usuario? usuario;

  const AtualizacaoUsuarioScreen({super.key, required this.controller, this.usuario});

  @override
  _AtualizacaoUsuarioScreenState createState() => _AtualizacaoUsuarioScreenState();
}

class _AtualizacaoUsuarioScreenState extends State<AtualizacaoUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  // bool _isObscured = true;
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _dataNascimentoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _saltController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _telefoneEmergenciaController = TextEditingController();
  final _telefoneFormater = MaskTextInputFormatter(mask: '(##) #####-####', filter: { "#": RegExp(r'[0-9]') });
  final _dataNascimentoFormatter = MaskTextInputFormatter(mask: '!#/@#/####', filter: { "!": RegExp(r'[0-3]'), 
                                                                                        "#": RegExp(r'[0-9]'),
                                                                                        "@": RegExp(r'[0-1]')});
  
  Usuario? selectedUsuario;
  List<Usuario> usuarios = [];
  bool isUsuarioSelected = false;

  @override
  void initState() {
    super.initState();
    widget.controller.getAllUsuarios().then((value) {
      setState(() {
        usuarios = value;
        if (usuarios.isNotEmpty) {
          selectedUsuario = usuarios.first;
          _initializeControllers();
        }
      });
    });
  }

  void _initializeControllers() {
    if (selectedUsuario != null) {
      _idController.text = selectedUsuario!.id.toString();
      _nomeController.text = selectedUsuario!.nome;
      _sobrenomeController.text = selectedUsuario!.sobrenome;
      _dataNascimentoController.text = '${selectedUsuario!.dataNascimento.day.toString().padLeft(2, '0')}/${selectedUsuario!.dataNascimento.month.toString().padLeft(2, '0')}/${selectedUsuario!.dataNascimento.year}';
      _emailController.text = selectedUsuario!.email;
      _senhaController.text = selectedUsuario!.senha;
      _saltController.text = selectedUsuario!.salt;
      _telefoneController.text = selectedUsuario!.telefone;
      _telefoneEmergenciaController.text = selectedUsuario!.telefoneEmergencia;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atualização de Usuário')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              if (usuarios.isEmpty) 
                const Center(child: Text("Nenhum usuário encontrado")),
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<Usuario>(
                      value: selectedUsuario,
                      onChanged: (Usuario? newValue) {
                        setState(() {
                          selectedUsuario = newValue;
                        });
                      },
                      items: usuarios.map<DropdownMenuItem<Usuario>>((Usuario user) {
                        return DropdownMenuItem<Usuario>(
                          value: user,
                          child: Text("${user.nome} ${user.sobrenome}"),
                        );
                      }).toList(),
                      isExpanded: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5), // Cantos arredondados
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2), // Cor da sombra com transparência
                          spreadRadius: 1,
                          blurRadius: 2, // Suavização da sombra
                          offset: const Offset(0, 2), // Deslocamento vertical da sombra
                        ),
                      ],
                    ),
                    child: IconButton(
                      iconSize: 20, // Tamanho do ícone, ajuste conforme necessário
                      icon: const Icon(Icons.download, color: Colors.white), // Ícone com cor contrastante
                      onPressed: () {
                        if (selectedUsuario != null) {
                          _initializeControllers();
                          setState(() {
                            isUsuarioSelected = true;
                          });
                        }
                      },
                    ),
                  ),

                ],
              ),
              if (isUsuarioSelected) ...[
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _sobrenomeController,
                  decoration: const InputDecoration(labelText: 'Sobrenome'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o sobrenome';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dataNascimentoController,
                  inputFormatters: [_dataNascimentoFormatter],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Data de Nascimento (dd/mm/aaaa)',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua data de nascimento';
                    }
                    if (RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value)) {
                      List<String> partes = value.split('/');
                      if (partes.length != 3) {
                        return 'Data inválida!';
                      }
                    } else {
                      return 'Data inválida!';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o email';
                    }
                    if (!value.contains('@')) {
                      return 'Por favor, insira um email válido';
                    }
                    return null;
                  },
                ),
                // TextFormField(
                //   controller: _senhaController,
                //   obscureText: _isObscured,
                //   decoration: InputDecoration(
                //     labelText: 'Senha',
                //     suffixIcon: IconButton(
                //       icon: Icon(_isObscured ? Icons.visibility : Icons.visibility_off),
                //       onPressed: () {
                //         setState(() {
                //           _isObscured = !_isObscured;
                //         });
                //       },
                //     ),
                //   ),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Por favor, insira a senha';
                //     }
                //     return null;
                //   },
                // ),
                TextFormField(
                  controller: _telefoneController,
                  inputFormatters: [_telefoneFormater],
                  decoration: const InputDecoration(labelText: 'Telefone'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o telefone';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _telefoneEmergenciaController,
                  inputFormatters: [_telefoneFormater],
                  decoration: const InputDecoration(labelText: 'Telefone de Emergência'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o telefone de emergência';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Atualizar'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      DateTime parseDataDeNascimento(String dataStr) {
        List<String> partes = dataStr.split('/');
        if (partes.length != 3) {
          throw const FormatException('Formato de data inválida');
        }
        int dia = int.parse(partes[0]);
        int mes = int.parse(partes[1]);
        int ano = int.parse(partes[2]);
        return DateTime(ano, mes, dia);
      }
      final updatedUser = Usuario(
        id: int.parse(_idController.text),
        nome: _nomeController.text,
        sobrenome: _sobrenomeController.text,
        dataNascimento: parseDataDeNascimento(_dataNascimentoController.text),
        email: _emailController.text,
        senha: _senhaController.text,
        salt: _saltController.text,
        telefone: _telefoneController.text,
        telefoneEmergencia: _telefoneEmergenciaController.text,
      );

      widget.controller.updateUsuario(updatedUser).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário atualizado com sucesso!')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Falha ao atualizar usuário: $error')),
        );
      });

    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _dataNascimentoController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _saltController.dispose();
    _telefoneController.dispose();
    _telefoneEmergenciaController.dispose();
    super.dispose();
  }
}