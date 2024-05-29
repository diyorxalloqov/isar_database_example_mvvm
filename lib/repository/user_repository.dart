import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';
import 'package:isar_database_example/db/user_db.dart';
import 'package:isar_database_example/model/user_model.dart';
import 'package:isar_database_example/service/user_service.dart';

class UserRepository {
  final UserService _userService = UserService();
  final UserDb _userDb = UserDb();

  Future<Either<String, List<UserModel>>> getUsers() async {
    try {
      List<UserModel> data = await _userDb.getUsers();
      if (data.isEmpty) {
        Either<String, List<UserModel>> apiResult =
            await _userService.getUsers();
        return apiResult.fold((l) => left(l), (r) async {
          await _userDb.writeToDb(r);
          return right(r);
        });
      } else {
        return right(data);
      }
    } on IsarError catch (e) {
      return left(e.message);
    }
  }
}
