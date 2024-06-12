

import 'package:http/http.dart' as http;

import '../../api.dart';

abstract class KanbanDataSource {
  Future<http.Response> fetchTasks(FetchKanbanParams params);
}

class KanbanDataSourceRemoteImpl implements KanbanDataSource {
  final KanbanBoardAPI _api;

  const KanbanDataSourceRemoteImpl({
    required KanbanBoardAPI api,
  }) : _api = api;

  @override
  Future<http.Response> fetchTasks(FetchKanbanParams params) async {
    return await http.post(
      Uri.https(_api.baseURI, _api.taskPath),
      headers: {
        'Authorization': 'Bearer ${_api.bearToken}',
      },
      body: {
        'period_start': params.periodStart,
        'period_end': params.periodEnd,
        'period_key': params.periodKey,
        'requested_mo_id': '${params.requestedMoId}',
        'behaviour_key': params.behaviourKey,
        'with_result': '${params.withResult}',
        'response_fields': params.responseFields,
        'auth_user_id': '${params.authUserId}',
      },
    );
  }
}
