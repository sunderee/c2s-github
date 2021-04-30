import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class Pair<A, B> {
  final A first;
  final B second;

  @literal
  const Pair(this.first, this.second);
}

@immutable
class Triple<A, B, C> {
  final A first;
  final B second;
  final C third;

  @literal
  const Triple(this.first, this.second, this.third);
}
