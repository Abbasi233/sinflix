abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  @override
  String toString() {
    return 'ServerFailure: $message';
  }
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);

  @override
  String toString() {
    return 'CacheFailure: $message';
  }
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);

  @override
  String toString() {
    return 'NetworkFailure: $message';
  }
}

class BadRequestFailure extends Failure {
  const BadRequestFailure(super.message);

  @override
  String toString() {
    return 'BadRequestFailure: $message';
  }
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message);

  @override
  String toString() {
    return 'UnauthorizedFailure: $message';
  }
}

class ForbiddenFailure extends Failure {
  const ForbiddenFailure(super.message);

  @override
  String toString() {
    return 'ForbiddenFailure: $message';
  }
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);

  @override
  String toString() {
    return 'NotFoundFailure: $message';
  }
}
