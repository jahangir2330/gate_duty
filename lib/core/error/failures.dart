abstract class Failure {
  final String? message;
  const Failure({this.message});
}

class ServerFailure extends Failure {
  const ServerFailure([String? message]) : super(message: message);
}

class NetworkFailure extends Failure {
  const NetworkFailure([String? message]) : super(message: message);
}

class InvalidTokenFailure extends Failure {
  const InvalidTokenFailure([String? message]) : super(message: message);
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure([String? message]) : super(message: message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(String message) : super(message: message);
}

class RequestCancelledFailure extends Failure {
  const RequestCancelledFailure(String message) : super(message: message);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(String message) : super(message: message);
}
