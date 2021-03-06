import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class NumberTrivia extends Equatable {
  final String? text;
  final int? number;
  NumberTrivia({
    @required this.number,
    @required this.text,
  });

  @override
  List<Object?> get props => [number, text];
}
