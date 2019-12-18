import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);
}

// General failures
class ServerFailure implements Failure {
  @override
  List<Object> get props => props;
}

class CacheFailure implements Failure {
  @override
  List<Object> get props => props;
}