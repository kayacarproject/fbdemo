import 'package:equatable/equatable.dart';
import 'package:fbdemo/model/banner_model.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

@immutable
abstract class UserState extends Equatable {}

//data loading state
class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final List<BannerModel> users;
  UserLoadedState(this.users);

  @override
  List<Object?> get props => [users];
}
class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);

  @override
  List<Object?> get props => [error];
}


//data loaded state


//data loading error state

/*
@immutable
abstract class UserState extends Equatable {}

//data loading state
class UserLoadingState extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoadedState extends UserState {
  final List<BannerModel> users;
  final int currentIndex;

  UserLoadedState(this.users, this.currentIndex);

  @override
  List<Object?> get props => [users, currentIndex];
}
class UserErrorState extends UserState {
  final String error;
  UserErrorState(this.error);

  @override
  List<Object?> get props => [error];
}*/