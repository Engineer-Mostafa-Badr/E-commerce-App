import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

class MyObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log(change.toString());
  }

  @override
  void onClose(BlocBase bloc) {
    log('onClose: $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    log('onCreate: $bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {}

  @override
  void onEvent(Bloc bloc, Object? event) {}

  @override
  void onTransition(Bloc bloc, Transition transition) {}
}
