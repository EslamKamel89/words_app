import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/core/widgets/main_scaffold.dart';
import 'package:words_app/core/widgets/sizer.dart';
import 'package:words_app/features/home/cubits/verses_index_cubit.dart';
import 'package:words_app/features/home/entities/verse_entity.dart';
import 'package:words_app/features/home/models/root_model/verse.dart';
import 'package:words_app/features/home/presentation/widgets/roots_index_widget.dart';
import 'package:words_app/features/home/presentation/widgets/verse_card.dart';

class VersesView extends StatefulWidget {
  const VersesView({super.key, required this.wordTashkeel});
  final String wordTashkeel;
  @override
  State<VersesView> createState() => _VersesViewState();
}

class _VersesViewState extends State<VersesView> {
  late final VersesIndexCubit controller;
  @override
  void initState() {
    controller = context.read<VersesIndexCubit>();
    controller.search(widget.wordTashkeel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: "نتائج البحث في الآيات",
      resizeToAvoidBottomInset: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<VersesIndexCubit, ApiResponseModel<List<VerseModel>>>(
              builder: (context, state) {
                if (state.response == ResponseEnum.loading) {
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: 100),
                    child: CircularProgressIndicator(),
                  );
                }
                if (state.data == null || state.data?.isEmpty == true) {
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 50),
                    child: Text("لا توجد بيانات"),
                  );
                }
                return Column(
                  children: List.generate(state.data?.length ?? 0, (index) {
                    final verse = state.data![index];
                    return VerseCard(
                      verse: VerseEntity(
                        surahName: verse.surah?.name,
                        verseNumber: verse.verseNumber,
                        verseText: verse.text,
                      ),
                    );
                  }),
                );
              },
            ),
            Sizer(),
            Divider(),
            Sizer(),
            RootsIndexWidget(navigate: true),
          ],
        ),
      ),
    );
  }
}
