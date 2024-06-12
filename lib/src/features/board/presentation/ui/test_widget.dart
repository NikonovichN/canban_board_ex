import 'package:flutter/material.dart';

import '../../data/data.dart';
import '../../domain/domain.dart';
import '../../api.dart';

class TestWidget extends StatelessWidget {
  final KanbanRepository _testApi;

  TestWidget({super.key})
      : _testApi = KanbanRepositoryImpl(
          dataSource: KanbanDataSourceRemoteImpl(api: KanbanBoardAPIImpl()),
        );

  @override
  Widget build(BuildContext context) {
    _testApi.fetchTasks(const FetchKanbanParams(
      periodStart: '2024-05-01',
      periodEnd: '2024-05-31',
      periodKey: 'month',
      requestedMoId: 478,
      behaviourKey: 'task',
      withResult: false,
      responseFields: 'name,indicator_to_mo_id,parent_id,order',
      authUserId: 2,
    ));
    return Container();
  }
}
