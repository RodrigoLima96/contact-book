import 'dart:math';

import 'package:contatos/models/user.dart';
import 'package:contatos/user_data/user_data.dart';
import 'package:flutter/cupertino.dart';

class Users with ChangeNotifier {
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

  void put(User user) {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      _items.update(user.id, (value) => user);
    } else {
      final id = Random().nextDouble().toString();

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

  void remove(User user) {
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
  }
}
