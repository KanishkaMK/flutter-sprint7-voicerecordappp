import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_recording_app/screens/home_screen/cubit/record_cubit.dart';
import 'package:voice_recording_app/screens/recordings_list/cubit/files_cubit.dart';
import 'package:voice_recording_app/screens/recordings_list/view/recordings_list_screen.dart';
import '../../constants/app_colors.dart';
import '../../constants/recorder_constants.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/homescreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RecordCubit, RecordState>(
        builder: (context, state) {
          if (state is RecordStopped || state is RecordInitial) {
            return SafeArea(
                child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                const Text(
                  'Voice Recorder',
                  style: TextStyle(
                    color: Colors.redAccent,
                    letterSpacing: 2,
                    fontSize: 25,
                  ),
                ),
                Spacer(),
                Center(
                  child: TextButton(
                    onPressed: () {
                      context.read<RecordCubit>().startRecording();
                    },
                    child: Icon(
                      Icons.mic_rounded,
                      size: MediaQuery.of(context).size.height / 6,
                      color: Colors.red,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, _customRoute());
                  },
                  child: myNotes(),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ));
          } else if (state is RecordOn) {
            return SafeArea(
                child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                const Text(
                  'Recording...',
                  style: TextStyle(
                    color: Colors.redAccent,
                    letterSpacing: 2,
                    fontSize: 25,
                  ),
                ),
                Spacer(),
                Center(
                  child: TextButton(
                    onPressed: () {
                      context.read<RecordCubit>().stopRecording();

                      ///We need to refresh [FilesState] after recording is stopped
                      context.read<FilesCubit>().getFiles();
                    },
                    child: Icon(
                      Icons.stop_rounded,
                      size: MediaQuery.of(context).size.height / 6,
                      color: Colors.red,
                    ),
                  ),
                ),
                Spacer(),
              ],
            ));
          } else {
            return Center(
                child: Text(
              'An Error occured',
              style: TextStyle(color: AppColors.accentColor),
            ));
          }
        },
      ),
    );
  }

  Text myNotes() {
    return Text(
      'My Recordings',
      style: TextStyle(
        color: AppColors.accentColor,
        fontSize: 20,
      ),
    );
  }

  Route _customRoute() {
    return PageRouteBuilder(
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) =>
          RecordingsListScreen(),
    );
  }
}