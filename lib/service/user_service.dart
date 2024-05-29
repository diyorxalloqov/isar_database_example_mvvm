import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:isar_database_example/model/user_model.dart';

class UserService {
  Future<Either<String, List<UserModel>>> getUsers() async {
    try {
      Response res =
          await Dio().get('https://jsonplaceholder.typicode.com/posts');
      if (res.statusCode! >= 200 && res.statusCode! <= 299) {
        print(res.data);
        return right(
            (res.data as List).map((e) => UserModel.fromJson(e)).toList());
      }else{
        return left(res.statusMessage.toString());
      }
    }on DioException catch (e) {
      return left(e.message.toString());
    }
  }
}
