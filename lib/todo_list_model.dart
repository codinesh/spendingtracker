import 'dart:async';
import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:spending_tracker/models.dart';
import 'package:spending_tracker/models/todos_repository.dart';

enum VisibilityFilter { all, active, completed }

class SpendingListModel extends ChangeNotifier {
  final SpendingRepository repository;

  VisibilityFilter _filter;

  VisibilityFilter get filter => _filter;

  set filter(VisibilityFilter filter) {
    _filter = filter;
    notifyListeners();
  }

  List<Spending> _spendings;

  UnmodifiableListView<Spending> get todos => UnmodifiableListView(_spendings);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  SpendingListModel({
    @required this.repository,
    VisibilityFilter filter,
    List<Spending> todos,
  })  : _spendings = todos ?? [],
        _filter = filter ?? VisibilityFilter.all;

  /// Loads remote data
  ///
  /// Call this initially and when the user manually refreshes
  Future loadTodos() {
    _isLoading = true;
    notifyListeners();

    return repository.loadTodos().then((loadedTodos) {
      _spendings.addAll(loadedTodos.map(Spending.fromEntity));
      _isLoading = false;
      notifyListeners();
    }).catchError((err) {
      _isLoading = false;
      notifyListeners();
    });
  }

  List<Spending> get filteredTodos {
    return _spendings.where((spending) {
      switch (filter) {
        case VisibilityFilter.active:
          return spending.title.length > 0;
        case VisibilityFilter.completed:
          return spending.title.length > 0;
        case VisibilityFilter.all:
        default:
          return true;
      }
    }).toList();
  }

  // void toggleAll() {
  //   var allComplete = todos.every((Spending) => Spending.complete);
  //   _spendings = _spendings
  //       .map((Spending) => Spending.copy(complete: !allComplete))
  //       .toList();
  //   notifyListeners();
  //   _uploadItems();
  // }

  /// updates a [Spending] by replacing the item with the same id by the parameter [Spending]
  void updateSpending(Spending spending) {
    assert(spending != null);
    assert(spending.id != null);
    var oldTodo = _spendings.firstWhere((it) => it.id == spending.id);
    var replaceIndex = _spendings.indexOf(oldTodo);
    _spendings.replaceRange(replaceIndex, replaceIndex + 1, [spending]);
    notifyListeners();
    _uploadItems();
  }

  void removeSpending(Spending spending) {
    _spendings.removeWhere((it) => it.id == spending.id);
    notifyListeners();
    _uploadItems();
  }

  void addTodo(Spending spending) {
    _spendings.add(spending);
    notifyListeners();
    _uploadItems();
  }

  void _uploadItems() {
    repository.saveTodos(_spendings.map((it) => it.toEntity()).toList());
  }

  Spending todoById(String id) {
    return _spendings.firstWhere((it) => it.id == id, orElse: () => null);
  }

  int get numCompleted => todos
      .where((Spending spending) => spending.title.length > 0)
      .toList()
      .length;

  bool get hasCompleted => numCompleted > 0;

  int get numActive => todos
      .where((Spending spending) => spending.title.length > 0)
      .toList()
      .length;

  bool get hasActiveTodos => numActive > 0;
}
