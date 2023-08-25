import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planner/modules/loading_module/bloc/loading_bloc.dart';
import 'package:planner/theme/size_settings.dart';

import 'widgets/bubbles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("data"),
      ),
      body: BlocBuilder<LoadingBloc, LoadingState>(
        builder: (context, state) {
          return BlocBuilder<LoadingBloc, LoadingState>(
            builder: (context, state) {
              if (state is LoadingUserLoggedInState) {
                return ListView(
                  children: [
                    // SizedBox(
                    //   height: SizeSettings.screenHeight! * 0.3,
                    //   child: BubblePage(),
                    // ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.user.categories!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Text(
                            state.user.categories![index].title!.toString());
                      },
                    ),
                    // Text((state).user.)
                  ],
                );
              } else {
                return Center(
                  child: Text("Something Went Wrong"),
                );
              }
            },
          );
        },
      ),
    );
  }
}