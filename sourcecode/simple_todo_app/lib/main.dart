import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:simple_todo_app/core/di/app_dependency.dart';
import 'package:simple_todo_app/core/themes/colors.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_bloc.dart';
import 'package:simple_todo_app/features/todo/presentation/bloc/todo/todo_event.dart';
import 'package:simple_todo_app/features/todo/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then(
    (_) => runApp(
      const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (context) => getIt()..add(const GetAllTodosEvent()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        color: AppColors.colorWhite,
      ),
    );
  }
}
