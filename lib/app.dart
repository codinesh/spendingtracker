// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/add_todo_screen.dart';
import 'package:spending_tracker/core/localization.dart';
import 'package:spending_tracker/core/routes.dart';
import 'package:spending_tracker/core/theme.dart';
import 'package:spending_tracker/localization.dart';
import 'package:spending_tracker/models/todos_repository.dart';
import 'package:spending_tracker/todo_list_model.dart';

import 'home/home_screen.dart';

class ProviderApp extends StatelessWidget {
  final SpendingRepository repository;

  ProviderApp({
    @required this.repository,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SpendingListModel(repository: repository)..loadTodos(),
      child: MaterialApp(
        theme: ArchSampleTheme.theme,
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          ProviderLocalizationsDelegate(),
        ],
        onGenerateTitle: (context) =>
            ProviderLocalizations.of(context).appTitle,
        routes: {
          ArchSampleRoutes.home: (context) => HomeScreen(),
          ArchSampleRoutes.addTodo: (context) => AddTodoScreen(),
        },
      ),
    );
  }
}
