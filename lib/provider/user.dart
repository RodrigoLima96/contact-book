import 'dart:convert';
import 'package:contatos/models/user.dart';
import 'package:contatos/user_data/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  static const _baseUrl =
      "https://contact-book-a39ab-default-rtdb.firebaseio.com/";
  final Map<String, User> _items = {...userData};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
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
          id,
          user.name,
          user.email,
          user.avatarUrl,
        ),
      );
    }
    notifyListeners();
  }

  Future<void> remove(User user) async {
    if (user != null && user.id != null) {
      _items.remove(user.id);
      await http.delete(
        Uri.parse("$_baseUrl/users/${user.id}.json"),
      );
      notifyListeners();
    }
  }
}
