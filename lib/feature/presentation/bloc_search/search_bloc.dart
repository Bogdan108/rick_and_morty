import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/use_cases/search_person.dart';
import 'package:rick_and_morty/feature/presentation/bloc_search/search_event.dart';
import 'package:rick_and_morty/feature/presentation/bloc_search/search_state.dart';

// ignore: constant_identifier_names
const SERVER_FAILURE_MESSAGE = 'Server Failure';
// ignore: constant_identifier_names
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

// BLoC 8.0.0
class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPersons searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonSearchEmpty()) {
    on<FindPerson>(_onEvent);
  }

  FutureOr<void> _onEvent(
    FindPerson event,
    Emitter<PersonSearchState> emit,
  ) async {
    emit(PersonSearchLoading());
    final failureOrPerson = await searchPerson(
      SearchPersonParams(query: event.personQuery),
    );
    emit(
      failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
