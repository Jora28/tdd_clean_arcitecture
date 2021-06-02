import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
//import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_pattern/core/network/noetwork_info.dart';

class MockDataConnectionChecker extends Mock
    implements InternetConnectionChecker {}

void main() {
  late NetWorkInfoImpl? networkInfoImpl;
  late MockDataConnectionChecker? mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetWorkInfoImpl(mockDataConnectionChecker!);
  });

  group("isConnected", () {
    test("should forward the call to DataConection = connected", () async {
      when(()=>mockDataConnectionChecker?.hasConnection)
          .thenAnswer((_) async => true);
      final result = await networkInfoImpl?.isConnected;
      verify(()=>mockDataConnectionChecker?.hasConnection);
      expect(result, true);
    });
  });
}
