import 'package:flutter/material.dart';
import 'package:key_value_store_flutter/key_value_store_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spending_tracker/app.dart';
import 'package:spending_tracker/repositories/key_value_storage.dart';
import 'package:spending_tracker/repositories/local_storage_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderApp(
    repository: LocalStorageRepository(
      localStorage: KeyValueStorage(
        'change_notifier_provider_todos',
        FlutterKeyValueStore(await SharedPreferences.getInstance()),
      ),
    ),
  ));
}
