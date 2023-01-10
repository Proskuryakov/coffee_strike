abstract class Result {}

class ResultSuccess extends Result {}

class ResultFailure extends Result {
  final String error;

  ResultFailure(this.error);
}

class ResultLoading extends Result {
  ResultLoading();
}

class AddSuccess extends Result {}

class AddFailure extends Result {}
