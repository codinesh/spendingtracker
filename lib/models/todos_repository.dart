import 'dart:async';
import 'dart:core';

import 'package:spending_tracker/models/spending_entity.dart';

/// A class that Loads and Persists todos. The data layer of the app.
///
/// How and where it stores the entities should defined in a concrete
/// implementation, such as todos_repository_simple or todos_repository_web.
///
/// The domain layer should depend on this abstract class, and each app can
/// inject the correct implementation depending on the environment, such as
/// web or Flutter.
abstract class SpendingRepository {
  /// Loads todos first from File storage. If they don't exist or encounter an
  /// error, it attempts to load the Todos from a Web Client.
  Future<List<SpendingEntity>> loadTodos();

  // Persists todos to local disk and the web
  Future saveTodos(List<SpendingEntity> spendings);
}
