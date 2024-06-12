import 'dart:convert';

import 'package:either_dart/src/either.dart';

import '../../api.dart';
import '../model/task_model.dart';
import '../../domain/entity/task.dart';
import '../datasource/remote_data_source.dart';
import '../../domain/data/kanban_repository.dart';

class KanbanRepositoryImpl implements KanbanRepository {
  static const _errorMessage = 'Something went wrong!';

  final KanbanDataSource _dataSource;

  const KanbanRepositoryImpl({required KanbanDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<Either<String, List<TaskEntity>>> fetchTasks(FetchKanbanParams params) async {
    try {
      final result = await _dataSource.fetchTasks(params);
      final decoded = jsonDecode(result.body);

      return Right(ListTasks.fromJson(decoded['DATA']).toListEntity);
    } catch (error) {
      return const Left(_errorMessage);
    }
  }

  @override
  Future<Either<String, List<TaskEntity>>> updateTasks(PostKanbanParams params) async {
    try {
      final result = await _dataSource.updateTasks(params);
      final decoded = jsonDecode(result.body);

      return Right(ListTasks.fromJson(decoded['DATA']).toListEntity);
    } catch (error) {
      return const Left(_errorMessage);
    }
  }
}

extension on ListTasks {
  List<TaskEntity> get toListEntity => tasks.map((e) => e.toEntity).toList();
}

extension on TaskModelV1 {
  TaskEntity get toEntity => TaskEntity(
        indicatorToMoId: indicatorToMoId,
        name: name,
        parentId: parentId,
        order: order,
      );
}
