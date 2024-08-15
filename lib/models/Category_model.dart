import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:teatime/models/Tea_model.dart';

class Category extends Equatable {
  final String name;
  final List<Tea> teas;

  const Category({
    required this.name,
    this.teas = const <Tea>[],
  });

  Category copyWith({
    String? name,
    List<Tea>? teas,
  }) {
    return Category(
      name: name ?? this.name,
      teas: teas ?? this.teas,
    );
  }

  factory Category.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      List<Tea> teas,) {
    final data = snapshot.data();

    return Category(
      name: data?['name']??'',
      teas: teas,
    );
  }


  @override   // Use to compare the state of the bloc
  List<Object?> get props => [name, teas];
}