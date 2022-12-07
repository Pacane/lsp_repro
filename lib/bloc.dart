import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bloc.freezed.dart';

class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc() : super(MyState.unknown()) {
    on<MyEvent>((event, emit) {
      event.when(
        doSomething: (int value) => emit(
          MyState.withValue(value: value),
        ),
      );
    });
  }
}

@freezed
class MyState with _$MyState {
  factory MyState.unknown() = _MyStateUnknown;
  factory MyState.empty() = _MyStateEmpty;
  factory MyState.withValue({required int value}) = _MyStateWithValue;
}

@freezed
class MyEvent with _$MyEvent {
  const factory MyEvent.doSomething({
    required int value,
  }) = _DoSomethingEvent;
}
