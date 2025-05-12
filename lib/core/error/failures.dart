abstract class Failure {
  final String? message;

  const Failure({this.message});
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});
}

// You can add more specific failure types here (e.g., CacheFailure, NetworkFailure)
