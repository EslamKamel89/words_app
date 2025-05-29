import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/heleprs/print_helper.dart';
import 'package:words_app/core/router/app_routes_names.dart';
import 'package:words_app/features/home/cubits/roots_index_cubit.dart';
import 'package:words_app/features/home/models/root_model/root_model.dart';

class RootCard extends StatefulWidget {
  final RootModel rootModel;

  const RootCard({super.key, required this.rootModel});

  @override
  State<RootCard> createState() => _RootCardState();
}

class _RootCardState extends State<RootCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pr(widget.rootModel, 'root model');
        context.read<RootsIndexCubit>().searchInput.text = widget.rootModel.name ?? '';
        Navigator.of(
          context,
        ).pushNamed(AppRoutesNames.versesView, arguments: {'rootId': widget.rootModel.id});
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              // "الكلمة بالتشكيل: ${wordModel.wordTashkeel ?? ''}",
              " ${widget.rootModel.name ?? ''}",
              textAlign: TextAlign.right,
              style: TextStyle(
                // fontFamily: 'NotoSansArabic',
                fontWeight: FontWeight.normal,
                fontSize: 18,
                // color: Colors.deepOrange.shade700,
              ),
            ).animate().fadeIn(duration: 600.ms).scaleXY(begin: 0.95).then().fade(),
          ],
        ),
      ),
    );
  }
}
