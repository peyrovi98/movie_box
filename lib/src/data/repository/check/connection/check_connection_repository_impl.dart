import 'package:movie_box/src/data/source/ram/ram_storage.dart';
import 'package:movie_box/src/data/source/util/connection_checker.dart';
import 'package:movie_box/src/domain/repository/check/connection/check_connection_repository.dart';

class CheckConnectionRepositoryImpl implements CheckConnectionRepository {

  @override
  Future<bool> checkConnection() async {
    var isOnline = await ConnectionChecker().hasConnection();
    RamStorage().setHasNetwork(isOnline);
    return isOnline;
  }
}
