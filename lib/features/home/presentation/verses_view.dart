import 'package:flutter/material.dart';
import 'package:words_app/core/widgets/main_scaffold.dart';
import 'package:words_app/core/widgets/sizer.dart';
import 'package:words_app/features/home/presentation/widgets/roots_index_widget.dart';

class VersesView extends StatefulWidget {
  const VersesView({super.key, required this.wordTashkeel});
  final String wordTashkeel;
  @override
  State<VersesView> createState() => _VersesViewState();
}

class _VersesViewState extends State<VersesView> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: "نتائج البحث في الآيات",
      resizeToAvoidBottomInset: false,
      child: Column(
        children: [
          Expanded(child: ListView(children: [])),
          Sizer(),
          Divider(),
          Sizer(),
          RootsIndexWidget(navigate: true),
        ],
      ),
    );
  }
}
