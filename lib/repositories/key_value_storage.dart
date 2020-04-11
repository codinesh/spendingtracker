// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:convert';

import 'package:key_value_store/key_value_store.dart';
import 'package:spending_tracker/models/spending_entity.dart';
import 'package:spending_tracker/models/todos_repository.dart';

/// Loads and saves a List of Todos using a provided KeyValueStore, which works
/// on mobile and web. On mobile, it uses the SharedPreferences package, on web
/// it uses window.localStorage.
///
/// Can be used as it's own repository, or mixed together with other storage
/// solutions, such as the the WebClient, which can be seen in the
/// LocalStorageRepository.
class KeyValueStorage implements SpendingRepository {
  final String key;
  final KeyValueStore store;
  final JsonCodec codec;

  const KeyValueStorage(this.key, this.store, [this.codec = json]);

  @override
  Future<List<SpendingEntity>> loadTodos() async {
    return codec
        .decode(store.getString(key))['todos']
        .cast<Map<String, Object>>()
        .map<SpendingEntity>(SpendingEntity.fromJson)
        .toList(growable: false);
  }

  @override
  Future<bool> saveTodos(List<SpendingEntity> todos) {
    return store.setString(
      key,
      codec.encode({
        'todos': todos.map((todo) => todo.toJson()).toList(),
      }),
    );
  }
}
