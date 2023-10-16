import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_recording_app/screens/home_screen/cubit/record_cubit.dart';
import 'package:voice_recording_app/screens/home_screen/home_screen.dart';
import 'package:voice_recording_app/screens/recordings_list/cubit/files_cubit.dart';
import 'package:voice_recording_app/screens/recordings_list/view/recordings_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
     return MultiBlocProvider(
      providers: [
        BlocProvider<RecordCubit>(
          create: (context) => RecordCubit(),
        ),

        /// [FilesCubit] is provided before material app because it should start loading all files when app is opens
        /// asynschronous method [getFiles] is called in constructor of [Files Cubit].
        BlocProvider<FilesCubit>(
          create: (context) => FilesCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Voice Record app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          RecordingsListScreen.routeName: (context) => RecordingsListScreen(),
        },
      ),
    );
  }
}

