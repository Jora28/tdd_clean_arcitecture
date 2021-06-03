import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_pattern/core/error/exceptions.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/datasoursces/number_trivia_local_data_source.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

const CACHED_NUMBER_TRIVIA = "CACHED_NUMBER_TRIVIA";
void main() {
  late NumberTriviaLocalDataSourseImpl dataSourseImpl;
  late MockSharedPreferences mockSharedPreferences;

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
      when(() => mockSharedPreferences.getString(any()))
          .thenReturn(fixture("trivia_cached.json"));
      final result = await dataSourseImpl.getLastNumberTrivia();
      verify(() => mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, equals(tNumberTriviaModel));
    });

    test("should trow a CatchExeption when there is not a cached value",
        () async {
      when(() => mockSharedPreferences.getString(any())).thenReturn(null);
      final call = dataSourseImpl.getLastNumberTrivia();
      expect(() async => await call, throwsA(TypeMatcher<CacheExceptions>()));
    });
  });

  
    //this test is not workikng 
    /// [setString] in sherdPref not support nullSefty


  group("cacheNumberTrivia", () {
    final tNumberTriviaModel =
        NumberTriviaModel(text: "Test Trivia", number: 1);
    test("should call SharedPreferences to cache the data", () async {
      dataSourseImpl.cachenumbertrivia(tNumberTriviaModel);
      final expactedJsonString = json.encode(tNumberTriviaModel.toJson());
      verify(() => mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA, expactedJsonString));
    });
  });
}
