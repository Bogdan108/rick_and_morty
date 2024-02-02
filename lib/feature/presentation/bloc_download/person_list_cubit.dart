import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/domain/use_cases/get_all_persons.dart';
import 'package:rick_and_morty/feature/presentation/bloc_download/person_list_sate.dart';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons;

  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());
  int page = 1;
  void loadPerson() async {
    if (state is PersonLoading) return;
    final currentState = state;
    var oldPerson = <PersonEntity>[];
    if (currentState is PersonLoaded) {
      oldPerson = currentState.personsList;
    }
    emit(PersonLoading(oldPersonsList: oldPerson, isFirstFetch: page == 1));
    final failreOrPerson = await getAllPersons(PagePersonParams(page: page));
    failreOrPerson.fold((l) => const PersonError(message: ''), (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonsList;
      persons.addAll(character);
      emit(PersonLoaded(personsList: persons));
    });
  }
}
