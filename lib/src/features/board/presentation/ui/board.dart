import "dart:convert";

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appflowy_board/appflowy_board.dart';

import '../cubit/tasks_cubit.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  static const _boardMargin = EdgeInsets.symmetric(horizontal: 12);

  late AppFlowyBoardController boardController;
  AppFlowyBoardScrollController boardScrollController = AppFlowyBoardScrollController();

  @override
  void initState() {
    super.initState();
    boardController = AppFlowyBoardController(
        onMoveGroupItem: _onMoveGroupItem, onMoveGroupItemToGroup: _onMoveGroupItemToGroup);
  }

  void _onMoveGroupItem(String groupId, int fromIndex, int toIndex) {
    context.read<TasksCubit>().updateTasks(groupId, fromIndex);
  }

  void _onMoveGroupItemToGroup(String fromGroupId, int fromIndex, String toGroupId, int toIndex) {
    context.read<TasksCubit>().updateTasks(fromGroupId, toIndex);
  }

  @override
  void dispose() {
    boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      buildWhen: (previous, current) => current is TasksLoaded,
      builder: (context, state) {
        state as TasksLoaded;
        state.groupedTasks.forEach((key, value) {
          var group = AppFlowyGroupData(
              id: key.toString(),
              name: key.toString(),
              items: List<AppFlowyGroupItem>.from(
                value.map(
                  (e) {
                    final encodedLatin1 = const Latin1Codec().encode(e.name);
                    return _TextItem(utf8.decode(encodedLatin1));
                  },
                ).toList(),
              ));

          boardController.addGroup(group);
        });

        return AppFlowyBoard(
          controller: boardController,
          groupConstraints: const BoxConstraints.tightFor(width: 240),
          cardBuilder: (context, group, groupItem) {
            return AppFlowyGroupCard(
              key: ValueKey(groupItem.id),
              child: groupItem is _TextItem ? _CardItem(item: groupItem) : null,
            );
          },
          boardScrollController: boardScrollController,
          headerBuilder: (context, columnData) {
            return AppFlowyGroupHeader(
              icon: const Icon(Icons.lightbulb_circle),
              title: SizedBox(
                width: 60,
                child: TextField(
                  controller: TextEditingController()..text = columnData.headerData.groupName,
                  onSubmitted: (val) {
                    boardController
                        .getGroupController(columnData.headerData.groupId)!
                        .updateGroupName(val);
                  },
                ),
              ),
              margin: _boardMargin,
            );
          },
          footerBuilder: (_, __) => const SizedBox(height: 20),
          config: const AppFlowyBoardConfig(
            groupBackgroundColor: Colors.black12,
            stretchGroupHeight: false,
          ),
        );
      },
    );
  }
}

class _TextItem extends AppFlowyGroupItem {
  final String s;

  _TextItem(this.s);

  @override
  String get id => s;
}

class _CardItem extends StatelessWidget {
  static const _padding = EdgeInsets.symmetric(horizontal: 20, vertical: 30);

  final _TextItem item;

  const _CardItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: _padding,
        child: Text(item.s),
      ),
    );
  }
}
