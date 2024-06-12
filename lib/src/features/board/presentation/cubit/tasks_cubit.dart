import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../api.dart';
import '../../domain/domain.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  static const _params = FetchKanbanParams(
    periodStart: '2024-05-01',
    periodEnd: '2024-05-31',
    periodKey: 'month',
    requestedMoId: 478,
    behaviourKey: 'task',
    withResult: false,
    responseFields: 'name,indicator_to_mo_id,parent_id,order',
    authUserId: 2,
  );

  final KanbanRepository repository;

  TasksCubit({required this.repository}) : super(TasksInitial());

  Future<void> fetchTasks() async {
    emit(TasksLoading());
    final response = await repository.fetchTasks(_params);

    response.fold(
      (left) => emit(TasksError()),
      (right) => emit(TasksLoaded(data: right)),
    );
  }
}
