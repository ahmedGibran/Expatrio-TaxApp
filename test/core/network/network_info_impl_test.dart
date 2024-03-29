import 'package:expatrio_tax_task/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'network_info_impl_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
//flutter test test/core/network/network_info_impl_test.dart
void main() {
  late MockInternetConnectionChecker mockInternetConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(internetConnectionChecker: mockInternetConnectionChecker);
  });

  test("should check Internet connection when has connection or not", () async {
    when(mockInternetConnectionChecker.hasConnection).thenAnswer((_) async => true);
    final result = await networkInfoImpl.isConnected;
    verify(mockInternetConnectionChecker.hasConnection);
    expect(result, true);
  });
}
