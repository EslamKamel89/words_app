import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:words_app/core/heleprs/snackbar.dart';
import 'package:words_app/core/static_data/app_strings.dart';
import 'package:words_app/core/themes/toogle_theme_switch.dart';
import 'package:words_app/core/widgets/bottom_navigation_bar.dart';
import 'package:words_app/core/widgets/default_drawer.dart';
import 'package:words_app/core/widgets/default_screen_padding.dart';
import 'package:words_app/core/widgets/language_selector.dart';
import 'package:words_app/core/widgets/sizer.dart';

class ComponentScreen extends StatefulWidget {
  const ComponentScreen({super.key});

  @override
  State<ComponentScreen> createState() => _ComponentScreenState();
}

class _ComponentScreenState extends State<ComponentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Locum')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      drawer: const DefaultDrawer(),
      bottomNavigationBar: DefaultBottomNavigationBar(
        handleNavigation: (int index) {},
      ),
      body: DefaultScreenPadding(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: double.infinity),
              const Sizer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Change Theme'), Sizer(), ToggleThemeSwitch()],
              ),
              const LanguageSelector(),
              const Sizer(),
              Text(AppStrings.WELCOME.tr()),
              const Sizer(),
              ElevatedButton(
                onPressed: () {},
                child: const Text('ElevatedButton'),
              ),
              const Sizer(),
              OutlinedButton(
                onPressed: () {},
                child: const Text('OutlinedButton'),
              ),
              const Sizer(),
              TextButton(onPressed: () {}, child: const Text('TextButton')),
              const Sizer(),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Input Label',
                  hintText: 'Hint Text',
                  border: OutlineInputBorder(),
                ),
              ),
              const Sizer(),
              const Divider(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home),
                  Sizer(),
                  Icon(Icons.star),
                  Sizer(),
                  Icon(Icons.settings),
                ],
              ),
              const Sizer(),
              ElevatedButton(
                onPressed: () {
                  showSnackbar(
                    'Success',
                    'This is the default success snack bar',
                    false,
                  );
                },
                child: const Text('Success Snack Bar'),
              ),
              const Sizer(),
              ElevatedButton(
                onPressed: () {
                  showSnackbar(
                    'Error',
                    'This is the default error snack bar',
                    true,
                  );
                },
                child: const Text('Error Snack Bar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
