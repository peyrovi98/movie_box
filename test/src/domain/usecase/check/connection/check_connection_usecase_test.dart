import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_box/src/domain/repository/check/connection/check_connection_repository.dart';
import 'package:movie_box/src/domain/usecase/check/connection/check_connection_usecase.dart';

import 'check_connection_usecase_test.mocks.dart';

@GenerateMocks([CheckConnectionRepository])
void main() {
  late CheckConnectionRepository repository;
  late CheckConnectionUseCase useCase;

  setUpAll(() {
    repository = MockCheckConnectionRepository();
    useCase = CheckConnectionUseCase(repository);
  });

  test(
      "Call check connection use-case, call checkConnection from repository then return true",
      () async {
    when(repository.checkConnection())
        .thenAnswer((realInvocation) => Future(() => true));
    var result = await useCase.invoke();
    expect(result, true);
    verify(repository.checkConnection()).called(1);
  });
}
