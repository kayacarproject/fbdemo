import 'package:bloc/bloc.dart';

import '../../model/language_model.dart';
import 'language_event.dart';
import 'language_state.dart';



class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc()
      : super(LanguageLoaded(LanguageEntity(
            code: Languages.languages[0].code,
            value: Languages.languages[0].value))) {
    on<ToggleLanguageEvent>(_toggleLanguage);
  }

  _toggleLanguage(ToggleLanguageEvent event, Emitter<LanguageState> emit) {
    emit(LanguageLoaded(LanguageEntity(
        code: event.language.code, value: event.language.value)));
  }
}
