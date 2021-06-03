import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_pattern/core/error/exceptions.dart';
import 'package:tdd_pattern/core/util/input_converter.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/datasoursces/number_trivia_local_data_source.dart';
import 'package:tdd_pattern/features/nuber_triviva/data/models/number_trivia_model.dart';

void main() {
  InputConverter? inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group("stringToUnsignrdInteger----", () {
    test("should return integer when the string represents an unsigned integer",
        () async {
      String? str = '123';
      final result = inputConverter?.stringToUnsignedInteger(str);
      expect(result, Right(123));
    });

    test('should return a Failure when the string is not an integer', () async {
      final str = 'ans';
      final result = inputConverter?.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });

    test('should return a Failure when the string is  a negative integer', () async {
      final str = '-123';
      final result = inputConverter?.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
