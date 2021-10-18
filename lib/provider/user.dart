import 'dart:convert';
import 'package:contatos/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  static const _baseUrl =
      "https://contact-book-a39ab-default-rtdb.firebaseio.com/";

  final Map<String, User> _items = {};
  bool startApp = true;

  Future<void> getDataBase() async {
    return await http.get(Uri.parse("$_baseUrl/users/.json")).then((response) {
      if (response.body.toString() != 'null') {
        final Map<String, dynamic> jsonString = jsonDecode(response.body);
        jsonString.forEach((key, value) {
          User user = User.fromJson(value, key);
          var userData = {
            key: User(
              id: user.id,
              name: user.name,
              email: user.email,
              avatarUrl: user.avatarUrl,
            ),
          };
          _items.addAll(userData);
        });
        if (startApp) {
          notifyListeners();
        }
      }
      startApp = false;
      print('uma vez');
    });
  }

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    getDataBase();
    return _items.length;
  }

  User byIndex(int i) {
    getDataBase();
    return _items.values.elementAt(i);
  }

  Future<void> put(User user) async {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      await http.patch(
        Uri.parse("$_baseUrl/users/${user.id}.json"),
        body: jsonEncode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl
        }),
      );

      _items.update(user.id, (value) => user);
    } else {
      final response = await http.post(
        Uri.parse("$_baseUrl/users.json"),
        body: jsonEncode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl
        }),
      );

      final id = jsonDecode(response.body)['name'];

      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> remove(User user) async {
    if (user != null && user.id != null) {
      await http.delete(
        Uri.parse("$_baseUrl/users/${user.id}.json"),
      );
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
