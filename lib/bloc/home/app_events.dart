import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}




@immutable
abstract class TblEvent extends Equatable {
  const TblEvent();
}

class LoadTblEvent extends TblEvent {
  @override
  List<Object?> get props => [];
}





/*
class UpdateCurrentIndexEvent extends UserEvent {
  final int newIndex;

  const UpdateCurrentIndexEvent(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}
*/
