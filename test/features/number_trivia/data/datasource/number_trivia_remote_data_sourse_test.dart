import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/datasoursces/number_trivia_local_data_source.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourseImpl? dataSourseImpl;
  MockSharedPreferences? mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourseImpl = NumberTriviaLocalDataSourseImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group("getLastNumberTrivia", () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture("trivia_cached.json")));
    test(
        "should return NumberTrivia from Sharedpreferens when ther is onew the cached",
        () async {
      when(()=>mockSharedPreferences?.getString(any()))
          .thenReturn(fixture("trivia_cached.json"));
      final result = await dataSourseImpl?.getLastNumberTrivia();
      verify(()=>mockSharedPreferences?.getString("CACHED_NUMBER_TRIVIA"));
      expect(result, equals(tNumberTriviaModel));
    });
  });
}
