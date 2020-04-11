import 'package:flutter/material.dart' hide Action;
import 'package:provider/provider.dart';
import 'package:spending_tracker/core/keys.dart';
import 'package:spending_tracker/core/localization.dart';
import 'package:spending_tracker/core/routes.dart';
import 'package:spending_tracker/home/stats_view.dart';
import 'package:spending_tracker/home/todo_list_view.dart';
import 'package:spending_tracker/localization.dart';
import 'package:spending_tracker/models.dart';
import 'package:spending_tracker/todo_list_model.dart';

import 'extra_actions_button.dart';
import 'filter_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Because the state of the tabs is only a concern to the HomeScreen Widget,
  // it is stored as local state rather than in the SpendingListModel.
  final _tab = ValueNotifier(_HomeScreenTab.todos);

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ProviderLocalizations.of(context).appTitle),
        actions: <Widget>[
          ValueListenableBuilder<_HomeScreenTab>(
            valueListenable: _tab,
            builder: (_, tab, __) => FilterButton(
              isActive: tab == _HomeScreenTab.todos,
            ),
          ),
          const ExtraActionsButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.addTodoFab,
        onPressed: () => Navigator.pushNamed(context, ArchSampleRoutes.addTodo),
        tooltip: ArchSampleLocalizations.of(context).addTodo,
        child: const Icon(Icons.add),
      ),
      body: Selector<SpendingListModel, bool>(
        selector: (context, model) => model.isLoading,
        builder: (context, isLoading, _) {
          if (isLoading) {
            return Center(
              child: CircularProgressIndicator(
                key: ArchSampleKeys.todosLoading,
              ),
            );
          }

          return ValueListenableBuilder<_HomeScreenTab>(
            valueListenable: _tab,
            builder: (context, tab, _) {
              switch (tab) {
                case _HomeScreenTab.stats:
                  return const StatsView();
                case _HomeScreenTab.todos:
                default:
                  return TodoListView(
                    onRemove: (context, todo) {
                      Provider.of<SpendingListModel>(context, listen: false)
                          .removeSpending(todo);
                      _showUndoSnackbar(context, todo);
                    },
                  );
              }
            },
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder<_HomeScreenTab>(
        valueListenable: _tab,
        builder: (context, tab, _) {
          return BottomNavigationBar(
            key: ArchSampleKeys.tabs,
            currentIndex: _HomeScreenTab.values.indexOf(tab),
            onTap: (int index) => _tab.value = _HomeScreenTab.values[index],
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list, key: ArchSampleKeys.todoTab),
                title: Text(ArchSampleLocalizations.of(context).todos),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart, key: ArchSampleKeys.statsTab),
                title: Text(ArchSampleLocalizations.of(context).stats),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showUndoSnackbar(BuildContext context, Spending spending) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        key: ArchSampleKeys.snackbar,
        duration: const Duration(seconds: 2),
        content: Text(
          ArchSampleLocalizations.of(context).todoDeleted(spending.title),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        action: SnackBarAction(
          key: ArchSampleKeys.snackbarAction(spending.id),
          label: ArchSampleLocalizations.of(context).undo,
          onPressed: () =>
              Provider.of<SpendingListModel>(context, listen: false)
                  .addTodo(spending),
        ),
      ),
    );
  }
}

enum _HomeScreenTab { todos, stats }
