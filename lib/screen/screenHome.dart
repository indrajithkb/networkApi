import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sampleapi/model/user_model.dart';
import 'package:sampleapi/repo/repository.dart';
import 'package:sampleapi/screen/bloc/screen_home_bloc.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    // UserRepo().getApiData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api'),
        backgroundColor: Colors.blueGrey,
      ),
      body: BlocBuilder<ScreenHomeBloc, ScreenHomeState>(
        builder: (context, state) {
          if (state is ScreenHomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ScreenHomeLoadedState) {
            final UserModel userList = state.user as UserModel;
            // print(userList);
            return ListView.builder(
              itemCount: userList.data!.length,
              itemBuilder: (context, index) {
                final data = userList.data![index];
                return Card(
                    child: ListTile(
                  title: Text(data.name.toString()),
                  subtitle: Text(data.year.toString()),
                ));
              },
            );
          }
          if (state is ScreenHomeErrorState) {
            return Text(state.error);
          }
          return Container();
        },
      ),
    );
  }
}
