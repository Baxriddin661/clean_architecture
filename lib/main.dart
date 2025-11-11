import 'package:clean_architecture/features/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'package:clean_architecture/features/presentation/bloc/search/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:clean_architecture/loactor_service.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/app_colors.dart';
import 'features/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PersonListCubit>(create: (context)=> di.ls<PersonListCubit>()..loadPerson()),
      BlocProvider(create: (context)=> di.ls<PersonSearchBloc>())

    ], child: MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.mainBackground
      ),
      home: HomePage(),
    ));
  }
}

