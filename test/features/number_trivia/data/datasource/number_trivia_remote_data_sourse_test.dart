import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_pattern/core/error/exceptions.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/datasoursces/number_trivia_remote_data_sourse.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteDataSourseImpl dataSourseImpl;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourseImpl = NumberTriviaRemoteDataSourseImpl(client: mockHttpClient);
  });
  final tNumber = 1;

  void setUpMockHttpClientSuccess200() {
    when(() => mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber'),
            headers: {'Content-Type': 'application/json'}))
        .thenAnswer((invocation) async =>
            Future.value(http.Response(fixture("trivia.json"), 200)));
  }

  group("getConcretNuberTivia", () {
    // final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    Uri url = Uri.parse('http://numbersapi.com/$tNumber');
    test('''should a GET request on a URL with number 
    begin the endpiont and with app/json hedr''', () async {
      setUpMockHttpClientSuccess200();
      dataSourseImpl.getConcretNuberTivia(tNumber);
      verify(() => mockHttpClient
          .get(url, headers: {'Content-Type': 'application/json'}));
    });

    test("should return NumberTrivia when the response code is 200 (sucsses)",
        () async {
      setUpMockHttpClientSuccess200();
      final result = await dataSourseImpl.getConcretNuberTivia(tNumber);
      expect(result, equals(tNumberTriviaModel));
    });
    test(
        "should throw a ServerExaption when the response code is 404 or other ",
        () async {
      when(() => mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((invocation) async =>
              Future.value(http.Response("Something whent wrong", 404)));
      final call = dataSourseImpl.getConcretNuberTivia;
      expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
