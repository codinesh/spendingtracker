import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/core/keys.dart';
import 'package:spending_tracker/core/localization.dart';
import 'package:spending_tracker/todo_list_model.dart';

class EditTodoScreen extends StatefulWidget {
  final void Function(String task, String note) onEdit;
  final String id;

  const EditTodoScreen({
    @required this.id,
    @required this.onEdit,
  }) : super(key: ArchSampleKeys.editTodoScreen);

  @override
  _EditTodoScreenState createState() => _EditTodoScreenState();
}

class _EditTodoScreenState extends State<EditTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _noteController;

  @override
  void initState() {
    final todo = Provider.of<SpendingListModel>(context, listen: false)
        .todoById(widget.id);
    _titleController = TextEditingController(text: todo?.title);
    _noteController = TextEditingController(text: todo?.note);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(ArchSampleLocalizations.of(context).editTodo)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                key: ArchSampleKeys.taskField,
                style: Theme.of(context).textTheme.headline,
                decoration: InputDecoration(
                  hintText: ArchSampleLocalizations.of(context).newTodoHint,
                ),
                validator: (val) {
                  return val.trim().isEmpty
                      ? ArchSampleLocalizations.of(context).emptyTodoError
                      : null;
                },
              ),
              TextFormField(
                controller: _noteController,
                key: ArchSampleKeys.noteField,
                decoration: InputDecoration(
                  hintText: ArchSampleLocalizations.of(context).notesHint,
                ),
                maxLines: 10,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.saveTodoFab,
        tooltip: ArchSampleLocalizations.of(context).saveChanges,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            widget.onEdit(_titleController.text, _noteController.text);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
