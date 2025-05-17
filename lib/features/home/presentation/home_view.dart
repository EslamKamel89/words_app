import 'package:flutter/material.dart';
import 'package:words_app/core/widgets/inputs.dart';
import 'package:words_app/core/widgets/main_scaffold.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarTitle: 'كلمات في القرآن',
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextFormField(labelText: "ابحث في القرآن", controller: searchController),
          ],
        ),
      ),
    );
  }
}
