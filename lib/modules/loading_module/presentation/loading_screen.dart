import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/config/auth_token_handler.dart';
import 'package:planner/modules/loading_module/bloc/loading_bloc.dart';
import 'package:planner/theme/size_settings.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    context.read<LoadingBloc>().add(LoadUserDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: BlocConsumer<LoadingBloc, LoadingState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizeSettings.smalPaddingHeightWidgetMulti(3),
                const Text(
                  "Loading...",
                  style: TextStyle(color: Colors.amber),
                )
              ],
            );
          },
          listener: (BuildContext context, LoadingState state) async {
            if (state is LoadingUserIncompleteProfile) {
              Navigator.of(context).pushNamed('complete_profile');
            }
            if (state is LoadingUserLoggedInState) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('dash', (route) => false);
            }
            if (state is LoadingUserIsNotLoggedInLoadingState) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('login', (route) => false);
            }

            if (state is LoadingUserInvalidToken) {
              await AuthTokenSaveAndGet.removeAuthToken().then((value) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('register', (route) => false);
              });
            }
          },
        ),
      ),
    );
  }
}
