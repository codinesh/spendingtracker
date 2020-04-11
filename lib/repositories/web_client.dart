import 'dart:async';

import 'package:spending_tracker/core/uuid.dart';
import 'package:spending_tracker/models/category.dart';
import 'package:spending_tracker/models/spending_entity.dart';
import 'package:spending_tracker/models/todos_repository.dart';

/// A class that is meant to represent a Client that would be used to call a Web
/// Service. It is responsible for fetching and persisting Todos to and from the
/// cloud.
///
/// Since we're trying to keep this example simple, it doesn't communicate with
/// a real server but simply emulates the functionality.
class WebClient implements SpendingRepository {
  final Duration delay;

  const WebClient([this.delay = const Duration(milliseconds: 3000)]);

  /// Mock that "fetches" some Todos from a "web service" after a short delay
  @override
  Future<List<SpendingEntity>> loadTodos() async {
    return Future.delayed(
        delay,
        () => [
              SpendingEntity(
                  Uuid().generateV4(),
                  'purchased for tirupati',
                  'Samsung LED TV',
                  SpendingCategory.Electronics,
                  PurchaseType.EMI),
              SpendingEntity(
                  Uuid().generateV4(),
                  'purchased online to learn IoT',
                  'Raspberry Pi 4',
                  SpendingCategory.Electronics,
                  PurchaseType.EMI),
              SpendingEntity(Uuid().generateV4(), '', 'Samsung LED TV',
                  SpendingCategory.Electronics, PurchaseType.EMI),
              SpendingEntity(
                  Uuid().generateV4(),
                  'purchased for tirupati',
                  'Samsung LED TV',
                  SpendingCategory.Electronics,
                  PurchaseType.EMI),
              SpendingEntity(
                  Uuid().generateV4(),
                  'purchased for tirupati',
                  'Samsung LED TV',
                  SpendingCategory.Electronics,
                  PurchaseType.EMI),
            ]);
  }

  /// Mock that returns true or false for success or failure. In this case,
  /// it will "Always Succeed"
  @override
  Future<bool> saveTodos(List<SpendingEntity> todos) async {
    return Future.value(true);
  }
}
