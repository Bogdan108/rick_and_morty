import 'package:equatable/equatable.dart';

abstract class PersonSearchEvent extends Equatable {
  const PersonSearchEvent();

  @override
  List<Object> get props => [];
}

class FindPerson extends PersonSearchEvent {
  final String personQuery;

  const FindPerson(this.personQuery);
}
