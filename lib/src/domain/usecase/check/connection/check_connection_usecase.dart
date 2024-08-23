import 'package:movie_box/src/domain/repository/check/connection/check_connection_repository.dart';

class CheckConnectionUseCase {
  final CheckConnectionRepository _repository;

  CheckConnectionUseCase(this._repository);

  Future<bool> invoke() {
    return _repository.checkConnection();
  }
}
