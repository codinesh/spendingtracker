import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/core/keys.dart';
import 'package:spending_tracker/todo_list_model.dart';

import '../details_screen.dart';
import '../models.dart';

class TodoListView extends StatelessWidget {
  final void Function(BuildContext context, Spending todo) onRemove;

  TodoListView({Key key, @required this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<SpendingListModel, List<Spending>>(
      selector: (_, model) => model.filteredTodos,
      builder: (context, todos, _) {
        return ListView.builder(
          key: ArchSampleKeys.todoList,
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];

            return Dismissible(
              key: ArchSampleKeys.todoItem(todo.id),
              onDismissed: (_) => onRemove(context, todo),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return DetailsScreen(
                          id: todo?.id,
                          onRemove: () {
                            Navigator.pop(context);
                            onRemove(context, todo);
                          },
                        );
                      },
                    ),
                  );
                },
                leading: Icon(Icons.tv),
                title: Text(
                  todo.title,
                  key: ArchSampleKeys.todoItemTask(todo.id),
                  style: Theme.of(context).textTheme.title,
                ),
                subtitle: Text(
                  todo.note,
                  key: ArchSampleKeys.todoItemNote(todo.id),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
