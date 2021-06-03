import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/datasoursces/number_trivia_remote_data_sourse.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourseImpl? dataSourseImpl;
  MockHttpClient? mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourseImpl = NumberTriviaRemoteDataSourseImpl(client: mockHttpClient);
  });
   /// we will check this test
   /// this one is not working, becouse not nul- safety
  group("getConcretNuberTivia", () {
    final tNumber = 1;
    Uri url = Uri.parse('http://numbersapi.com/$tNumber');
    // test('''should a GET request on a URL with number 
    // begin the endpiont and with app/json hedr''', () async {
    //   // when(mockHttpClient?.get(url, headers: any))
    //   //     .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
    //   dataSourseImpl?.getConcretNuberTivia(tNumber);
    //   verify(() => mockHttpClient
    //       ?.get(url, headers: {'Content-Type': 'application/json'}));
    // });
  });
}
