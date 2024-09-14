import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final Object e;

  const Failure(this.e);

  @override
  List<Object?> get props => [e];
}

class ServerFailure extends Failure {
  const ServerFailure(super.e);
}

class CacheFailure extends Failure {
  const CacheFailure(super.e);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.e);
}
