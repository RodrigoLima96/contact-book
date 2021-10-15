import 'package:contatos/components/user_tile.dart';
import 'package:contatos/provider/user.dart';
import 'package:contatos/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 50.0),
          child: Center(
            child: Text(
              'Lista de contatos',
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(user: users.byIndex(i)),
      ),
    );
  }
}
