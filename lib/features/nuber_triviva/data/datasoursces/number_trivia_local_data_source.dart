import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_pattern/core/error/exceptions.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSourse {
  Future<NumberTriviaModel?>? getLastNumberTrivia();
  Future<bool>? cachenumbertrivia(NumberTriviaModel? numberTriviaModel);
}

const CACHED_NUMBER_TRIVIA = "CACHED_NUMBER_TRIVIA";

class NumberTriviaLocalDataSourseImpl implements NumberTriviaLocalDataSourse {
  final SharedPreferences? sharedPreferences;
  NumberTriviaLocalDataSourseImpl({this.sharedPreferences});

  /// it is not working  
  /// look file in folder [test], file [number_trivia_local_data_sourse_test.dart]
  @override
  Future<bool>? cachenumbertrivia(NumberTriviaModel? numberTriviaModel) {
    return  sharedPreferences?.setString(
        CACHED_NUMBER_TRIVIA, json.encode(numberTriviaModel?.toJson()));
  }

  @override
  Future<NumberTriviaModel?>? getLastNumberTrivia() async {
    String? jsonSring = sharedPreferences?.getString(CACHED_NUMBER_TRIVIA);
    if (jsonSring != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonSring)));
    } else {
      throw CacheExceptions();
    }
  }
}
