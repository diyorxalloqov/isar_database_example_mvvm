import 'package:isar/isar.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;
  int? userId;
  int? id1;
  String? title;
  String? body;

  UserModel({this.userId, this.id1, this.title, this.body});

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id1 = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id1;
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}

// @embedded
  // class asdasda{}
