import 'package:flutter/material.dart';
import "dart:convert";

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../api.dart';
import '../../data/data.dart';
import '../cubit/tasks_cubit.dart';

class CubitWrapper extends StatelessWidget {
  const CubitWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(
        repository: KanbanRepositoryImpl(
          dataSource: KanbanDataSourceRemoteImpl(api: KanbanBoardAPIImpl()),
        ),
      )..fetchTasks(),
      child: const Scaffold(
        body: Center(child: _DisplayStatusData()),
      ),
    );
  }
}

class _DisplayStatusData extends StatelessWidget {
  const _DisplayStatusData();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) => switch (state) {
        TasksInitial() => const Text('Initial'),
        TasksLoading() => const CircularProgressIndicator(),
        TasksLoaded() => const _TasksDisplayWidget(),
        TasksError() => const Text('Error'),
      },
    );
  }
}

class _TasksDisplayWidget extends StatelessWidget {
  const _TasksDisplayWidget();

  @override
  Widget build(BuildContext context) {
    final state = context.read<TasksCubit>().state as TasksLoaded;
    return SingleChildScrollView(
      child: Column(
        children: state.data.map((e) {
          final encodedLatin1 = const Latin1Codec().encode(e.name);
          return Text(utf8.decode(encodedLatin1));
        }).toList(),
      ),
    );
  }
}
