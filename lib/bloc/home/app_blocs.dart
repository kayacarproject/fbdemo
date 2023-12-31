import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repo/repositories.dart';
import 'app_events.dart';
import 'app_states.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      // print("loading=-==--=--=1");
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUsers();
        if(users.isEmpty) {
          emit(UserErrorState("No Data Found"));
        } else {
          emit(UserLoadedState(users));
        }

      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });


  }
}



class TblBloc extends Bloc<TblEvent, TblState> {
  final UserRepository _userRepository;

  TblBloc(this._userRepository) : super(TblLoadingState()) {

    on<LoadTblEvent>((event, emit) async {
      // print("loading=-==--=--=1");
      try {
      emit(TblLoadingState());
        // final tblData = await _userRepository.getTableData(event.limit!,event.list!);
        final tblData = await _userRepository.getTableData();
        if(tblData.isEmpty) {
          emit(TblErrorState("No Data Found"));
        }else {
          emit(TblLoadedState(tblData));
        }
      } catch (e) {
        print("eeeeee>>>"+e.toString());
        emit(TblErrorState(e.toString()));
      }
    });

  }
}



