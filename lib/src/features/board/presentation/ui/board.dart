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
  AppFlowyBoardController boardController = AppFlowyBoardController();
  AppFlowyBoardScrollController boardScrollController = AppFlowyBoardScrollController();

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
                    return TextItem(utf8.decode(encodedLatin1));
                  },
                ).toList(),
              ));

          boardController.addGroup(group);
        });

        final config = AppFlowyBoardConfig(
          groupBackgroundColor: HexColor.fromHex('#F7F8FC'),
          stretchGroupHeight: false,
        );

        return AppFlowyBoard(
            controller: boardController,
            cardBuilder: (context, group, groupItem) {
              return AppFlowyGroupCard(
                key: ValueKey(groupItem.id),
                child: _buildCard(groupItem),
              );
            },
            boardScrollController: boardScrollController,
            footerBuilder: (context, columnData) {
              return AppFlowyGroupFooter(
                icon: const Icon(Icons.add, size: 20),
                title: const Text('New'),
                height: 50,
                margin: config.groupBodyPadding,
                onAddButtonClick: () {
                  boardScrollController.scrollToBottom(columnData.id);
                },
              );
            },
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
                addIcon: const Icon(Icons.add, size: 20),
                moreIcon: const Icon(Icons.more_horiz, size: 20),
                height: 50,
                margin: config.groupBodyPadding,
              );
            },
            groupConstraints: const BoxConstraints.tightFor(width: 240),
            config: config);
      },
    );
  }

  Widget _buildCard(AppFlowyGroupItem item) {
    if (item is TextItem) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Text(item.s),
        ),
      );
    }

    throw UnimplementedError();
  }
}

class TextItem extends AppFlowyGroupItem {
  final String s;

  TextItem(this.s);

  @override
  String get id => s;
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
