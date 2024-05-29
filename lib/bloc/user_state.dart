part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  final ActionStatus userStatus;
  final String userError;
  final List<UserModel> userModel;

  const UserState(
      {this.userStatus = ActionStatus.isInitial,
      this.userError = '',
      this.userModel = const []});
  UserState copyWith(
      {ActionStatus? userStatus,
      String? userError,
      List<UserModel>? userModel}) {
    return UserState(
        userStatus: userStatus ?? this.userStatus,
        userError: userError ?? this.userError,
        userModel: userModel ?? this.userModel);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userStatus, userError, userModel];
}
