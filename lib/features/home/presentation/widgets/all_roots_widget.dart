import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/core/enums/response_type.dart';
import 'package:words_app/core/models/api_response_model.dart';
import 'package:words_app/features/home/cubits/all_roots_cubit.dart';
import 'package:words_app/features/home/cubits/roots_index_cubit.dart';
import 'package:words_app/features/home/models/root_model/root_model.dart';
import 'package:words_app/features/home/presentation/widgets/loading_card.dart';
import 'package:words_app/features/home/presentation/widgets/root_card.dart';

class AllRootsWidget extends StatefulWidget {
  const AllRootsWidget({super.key});

  @override
  State<AllRootsWidget> createState() => _AllRootsWidgetState();
}

class _AllRootsWidgetState extends State<AllRootsWidget> {
  late AllRootsCubit controller;
  @override
  void initState() {
    // controller = context.read<AllRootsCubit>();
    // controller.fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootsIndexCubit, ApiResponseModel<List<RootModel>>>(
      builder: (context, state) {
        if (state.response == ResponseEnum.loading) {
          return LoadingCard();
        }
        if (state.data == null || state.data?.isEmpty == true) {
          return Center(child: Column(children: [Text("لا توجد بيانات")]));
        }
        return Column(
          children: List.generate(
            state.data?.length ?? 0,
            (index) => RootCard(rootModel: state.data![index]),
          ),
        );
      },
    );
  }
}
