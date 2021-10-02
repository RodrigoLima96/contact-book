import 'package:contatos/views/user_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista de usuário',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const UserList(),
    );
  }
}
