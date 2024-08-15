import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Tea extends Equatable{
  String name;
  int quoting;
  String description;
  String personalOpinion;
  //int duration;
  //String picture;

  Tea({
    required this.name,
    required this.quoting,
    required this.description,
    required this.personalOpinion,
    //required this.duration,
    //required this.picture,
  });

  Tea copyWith({
    String? id,
    String? title,
    bool? completed,
  }) {
    return Tea(
      name: id ?? this.name,
      quoting: quoting ?? this.quoting,
      description: description ?? this.description,
      personalOpinion: personalOpinion ?? this.personalOpinion,
      //duration: duration ?? this.duration,
      //picture: picture ?? this.picture,
    );
  }

  factory Tea.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,) {
    final data = snapshot.data();

    return Tea(
      name: data?['name'],
      quoting: data?['quoting'],
      description: data?['description'],
      personalOpinion: data?['personalOpinion'],
      //duration: data?['duration'],
      //picture: data?['picture'],
    );
  }

  @override   // Use to compare the state of the bloc
  List<Object?> get props => [name, quoting, description, personalOpinion];

}