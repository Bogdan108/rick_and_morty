import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, List<PersonEntity>>> call(Params params);
}
