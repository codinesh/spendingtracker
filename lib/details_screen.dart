import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/core/keys.dart';
import 'package:spending_tracker/core/localization.dart';
import 'package:spending_tracker/models.dart';

import 'edit_todo_screen.dart';
import 'todo_list_model.dart';

class DetailsScreen extends StatelessWidget {
  final String id;
  final VoidCallback onRemove;

  const DetailsScreen({@required this.id, @required this.onRemove})
      : super(key: ArchSampleKeys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ArchSampleLocalizations.of(context).todoDetails),
        actions: <Widget>[
          IconButton(
            key: ArchSampleKeys.deleteTodoButton,
            tooltip: ArchSampleLocalizations.of(context).deleteTodo,
            icon: const Icon(Icons.delete),
            onPressed: onRemove,
          )
        ],
      ),
      body: Selector<SpendingListModel, Spending>(
        selector: (context, model) => model.todoById(id),
        shouldRebuild: (prev, next) => next != null,
        builder: (context, spending, _) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              bottom: 16.0,
                            ),
                            child: Text(
                              spending.title,
                              key: ArchSampleKeys.detailsTodoItemTask,
                              style: Theme.of(context).textTheme.headline,
                            ),
                          ),
                          Text(
                            spending.note,
                            key: ArchSampleKeys.detailsTodoItemNote,
                            style: Theme.of(context).textTheme.subhead,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.editTodoFab,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditTodoScreen(
                id: id,
                onEdit: (title, note) {
                  final model =
                      Provider.of<SpendingListModel>(context, listen: false);
                  final spending = model.todoById(id);

                  model.updateSpending(spending.copy(title: title, note: note));

                  return Navigator.pop(context);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
