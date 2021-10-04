import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar contato'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {},
          )
        ],
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              TextFormField(
                initialValue: '',
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Digite um nome';
                  } else if (value.trim().length < 3) {
                    return 'Nome deve conter mais de 3 caracteres';
                  }
                },
                onSaved: (value) {},
              ),
              TextFormField(
                initialValue: '',
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
                onSaved: (value) {},
              ),
              TextFormField(
                initialValue: '',
                decoration: const InputDecoration(labelText: 'Avatar url'),
                onSaved: (value) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
