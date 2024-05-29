import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar_database_example/bloc/user_bloc.dart';
import 'package:isar_database_example/utils/enums/status.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserBloc _userBloc;

  @override
  void initState() {
    _userBloc = UserBloc()..add(GetUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _userBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('UserData with Isar'),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state.userStatus == ActionStatus.isLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state.userStatus == ActionStatus.isSuccess) {
              return ListView.builder(
                  itemCount: state.userModel.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.userModel[index].title ?? ''),
                      subtitle: Text(state.userModel[index].body ?? ''),
                    );
                  });
            } else if (state.userStatus == ActionStatus.isError) {
              return Center(child: Text(state.userError));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
