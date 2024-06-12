import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class ListTasks {
  @JsonKey(name: 'rows')
  final List<TaskModelV1> tasks;
  const ListTasks({required this.tasks});

  factory ListTasks.fromJson(Map<String, dynamic> json) => _$ListTasksFromJson(json);

  Map<String, dynamic> toJson() => _$ListTasksToJson(this);
}

@JsonSerializable()
class TaskModelV1 {
  final String name;
  @JsonKey(name: 'indicator_to_mo_id')
  final int indicatorToMoId;
  @JsonKey(name: 'parent_id')
  final int parentId;
  final int order;

  const TaskModelV1({
    required this.name,
    required this.indicatorToMoId,
    required this.parentId,
    required this.order,
  });

  factory TaskModelV1.fromJson(Map<String, dynamic> json) => _$TaskModelV1FromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelV1ToJson(this);
}
