import 'dart:async';

import 'package:isar/isar.dart';
import 'package:isar_database_example/model/user_model.dart';
import 'package:path_provider/path_provider.dart';

class UserDb {
  late Isar _isar;
  final Completer<void> _initCompleter = Completer<void>();

  UserDb() {
    init();
  }

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [UserModelSchema],
      directory: dir.path,
    );
    _initCompleter.complete();
  }

  Future<void> writeToDb(List<UserModel> userModel) async {
    await _initCompleter.future;
    await _isar.writeTxn(() async {
      await _isar.userModels.putAll(userModel);
    });
  }

  Future<List<UserModel>> getUsers() async {
    await _initCompleter.future;
    return await _isar.userModels.where().findAll();
  }
}
