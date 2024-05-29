import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:isar_database_example/model/user_model.dart';
import 'package:isar_database_example/repository/user_repository.dart';
import 'package:isar_database_example/utils/enums/status.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<GetUsersEvent>(_getUsers);
  }
  final UserRepository _userRepository = UserRepository();

  Future<FutureOr<void>> _getUsers(
      GetUsersEvent event, Emitter<UserState> emit) async {
    emit(state.copyWith(userStatus: ActionStatus.isLoading));
    Either<String, List<UserModel>> data = await _userRepository.getUsers();
    data.fold(
        (l) => emit(
            state.copyWith(userStatus: ActionStatus.isError, userError: l)),
        (r) => emit(
            state.copyWith(userModel: r, userStatus: ActionStatus.isSuccess)));
  }
}
