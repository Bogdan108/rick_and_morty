import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/use_case/use_case.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/domain/repository/person_repository.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  final PersonRepository personRepo;

  GetAllPersons({required this.personRepo});

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return await personRepo.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;

  const PagePersonParams({required this.page});

  @override
  List<Object?> get props => [page];
}
