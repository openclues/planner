import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'planner_event.dart';
part 'planner_state.dart';

class PlannerBloc extends Bloc<PlannerEvent, PlannerState> {
  PlannerBloc() : super(PlannerInitial()) {
    on<PlannerEvent>((event, emit) {
    });
  }
}
