import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/core/keys.dart';
import 'package:spending_tracker/core/localization.dart';
import 'package:spending_tracker/todo_list_model.dart';

class StatsView extends StatelessWidget {
  const StatsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              ArchSampleLocalizations.of(context).completedTodos,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Selector<SpendingListModel, int>(
              selector: (_, model) => model.numCompleted,
              builder: (context, numCompleted, _) => Text(
                '$numCompleted',
                key: ArchSampleKeys.statsNumCompleted,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              ArchSampleLocalizations.of(context).activeTodos,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Selector<SpendingListModel, int>(
              selector: (_, model) => model.numActive,
              builder: (context, numActive, _) => Text(
                '$numActive',
                key: ArchSampleKeys.statsNumActive,
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
          )
        ],
      ),
    );
  }
}
