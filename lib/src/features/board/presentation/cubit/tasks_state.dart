part of 'tasks_cubit.dart';

sealed class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

final class TasksInitial extends TasksState {}

final class TasksLoading extends TasksState {}

final class TasksLoaded extends TasksState {
  final List<TaskEntity> data;
  const TasksLoaded({required this.data});
  @override
  List<Object> get props => [data];
}

final class TasksError extends TasksState {}
