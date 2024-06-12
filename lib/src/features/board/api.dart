abstract class KanbanBoardAPI {
  String get bearToken;
  String get baseURI;
  String get taskPath;
}

class KanbanBoardAPIImpl implements KanbanBoardAPI {
  static const _bearToken = '48ab34464a5573519725deb5865cc74c';
  static const _baseURI = 'development.kpi-drive.ru';
  static const _taskPath = '_api/indicators/get_mo_indicators';

  @override
  String get bearToken => _bearToken;

  @override
  String get baseURI => _baseURI;

  @override
  String get taskPath => _taskPath;
}

class FetchKanbanParams {
  final String periodStart;
  final String periodEnd;
  final String periodKey;
  final int requestedMoId;
  final String behaviourKey;
  final bool withResult;
  final String responseFields;
  final int authUserId;

  const FetchKanbanParams({
    required this.periodStart,
    required this.periodEnd,
    required this.periodKey,
    required this.requestedMoId,
    required this.behaviourKey,
    required this.withResult,
    required this.responseFields,
    required this.authUserId,
  });
}

class PostKanbanParams {
  final String periodStart;
  final String periodEnd;
  final String periodKey;
  final int indicatorToMoId;
  final String fieldName;
  final int fieldValue;
  final int authUserId;

  const PostKanbanParams({
    required this.periodStart,
    required this.periodEnd,
    required this.periodKey,
    required this.indicatorToMoId,
    required this.fieldName,
    required this.fieldValue,
    required this.authUserId,
  });
}
