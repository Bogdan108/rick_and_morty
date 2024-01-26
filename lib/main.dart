import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/presentation/bloc/search_bloc.dart';
import 'package:rick_and_morty/feature/presentation/cubit/person_list_cubit.dart';
import 'package:rick_and_morty/locator_service/locator_service.dart' as di;
import 'package:rick_and_morty/locator_service/locator_service.dart';
import 'package:rick_and_morty/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<PersonListCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<PersonSearchBloc>(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: Colors.black,
          scaffoldBackgroundColor: Colors.grey,
        ),
        home: const HomePage(),
      ),
    );
  }
}
