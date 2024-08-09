import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Tea extends Equatable{
  String name;
  int quoting;
  String description;
  String personalOpinion;
  String picture;

  Tea({
    required this.name,
    required this.quoting,
    required this.description,
    required this.personalOpinion,
    required this.picture,
  });

  @override   // Use to compare the state of the bloc
  List<Object?> get props => [name, quoting, description, personalOpinion, picture];

}