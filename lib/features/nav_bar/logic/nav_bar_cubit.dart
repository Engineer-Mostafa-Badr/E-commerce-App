import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());

  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(IndexChanged());
  }
}
