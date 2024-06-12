import 'package:either_dart/either.dart';

import '../entity/task.dart';
import '../../api.dart';

abstract class KanbanRepository {
  Future<Either<String, List<TaskEntity>>> fetchTasks(FetchKanbanParams params);
}
