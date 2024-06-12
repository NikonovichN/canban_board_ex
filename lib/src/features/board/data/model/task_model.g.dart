// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListTasks _$ListTasksFromJson(Map<String, dynamic> json) => ListTasks(
      tasks: (json['tasks'] as List<dynamic>)
          .map((e) => TaskModelV1.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListTasksToJson(ListTasks instance) => <String, dynamic>{
      'tasks': instance.tasks,
    };

TaskModelV1 _$TaskModelV1FromJson(Map<String, dynamic> json) => TaskModelV1(
      name: json['name'] as String,
      indicatorToMoId: (json['indicator_to_mo_id'] as num).toInt(),
      parentId: (json['parent_id'] as num).toInt(),
      order: (json['order'] as num).toInt(),
    );

Map<String, dynamic> _$TaskModelV1ToJson(TaskModelV1 instance) =>
    <String, dynamic>{
      'name': instance.name,
      'indicator_to_mo_id': instance.indicatorToMoId,
      'parent_id': instance.parentId,
      'order': instance.order,
    };
