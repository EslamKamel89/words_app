import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/extensions/context-extensions.dart';
import 'package:words_app/features/home/cubits/roots_index_cubit.dart';
import 'package:words_app/features/home/entities/word_entity.dart';

class CustomBadge extends StatefulWidget {
  const CustomBadge({super.key, required this.word, required this.selected});
  final WordEntity word;
  final bool selected;
  @override
  State<CustomBadge> createState() => _CustomBadgeState();
}

class _CustomBadgeState extends State<CustomBadge> {
  late final RootsIndexCubit rootsController;
  @override
  void initState() {
    rootsController = context.read<RootsIndexCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.word.wordTashkeel != null && widget.word.wordTashkeel!.isNotEmpty
        ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: widget.selected ? context.primaryColor : context.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.primaryColor),
          ),
          child: Text(
            widget.word.wordTashkeel ?? '',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: widget.selected ? Colors.white : context.primaryColor,
            ),
          ),
        )
        : SizedBox();
  }
}
