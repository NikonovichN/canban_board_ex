import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String name;
  final int indicatorToMoId;
  final int parentId;
  final int order;

  const TaskEntity({
    required this.name,
    required this.indicatorToMoId,
    required this.parentId,
    required this.order,
  });

  @override
  List<Object?> get props => [name, indicatorToMoId, parentId, order];
}
