
import 'package:flutter/material.dart';
import '../../model/language_model.dart';

@immutable
abstract class LanguageEvent {}

class ToggleLanguageEvent extends LanguageEvent {
  final LanguageEntity language;

  ToggleLanguageEvent(this.language);
}
