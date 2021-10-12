import 'package:contatos/models/user.dart';
import 'package:contatos/provider/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  bool isLoading = false;
  final Map<String, String> _formData = {};
  String title = 'Cadastrar contato';

  void _loadFormData(User? user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
      title = 'Editar contato';
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    //recebendo os dados pela rota
    final user = ModalRoute.of(context)!.settings.arguments as User?;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title)),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();
                setState(() {
                  isLoading = true;
                });
                await Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'].toString(),
                    name: _formData['name'].toString(),
                    email: _formData['email'].toString(),
                    avatarUrl: _formData['avatarUrl'].toString(),
                  ),
                );
                setState(() {
                  isLoading = false;
                });
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _formData['name'],
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Digite um nome';
                        } else if (value.trim().length < 3) {
                          return 'Nome deve conter mais de 3 caracteres';
                        }
                        return null;
                      },
                      onSaved: (value) => _formData['name'] = value!,
                    ),
                    TextFormField(
                      initialValue: _formData['email'],
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Digite um email';
                        } else if (!value.contains('@')) {
                          return 'Email inválido';
                        }
                      },
                      onSaved: (value) => _formData['email'] = value!,
                    ),
                    TextFormField(
                        initialValue: _formData['avatarUrl'],
                        decoration:
                            const InputDecoration(labelText: 'Url do avatar'),
                        onSaved: (value) => _formData['avatarUrl'] = value!),
                  ],
                ),
              ),
            ),
    );
  }
}
