import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:teatime/models/Tea_model.dart';

class Category extends Equatable{
  final String name;
  final List<Tea> teas;

  const Category({
    required this.name,
    this.teas = const <Tea>[],
  });

  @override   // Use to compare the state of the bloc
  List<Object?> get props => [name, teas];

  static List<Category> categories = [
    Category(
      name: 'Thé vert',
      teas: [
        Tea(
          name: 'Amandine',
          quoting: 5,
          description: 'Le thé vert est une boisson très appréciée en Asie. Il est connu pour ses nombreuses vertus pour la santé.',
          personalOpinion: 'J\'aime beaucoup le thé vert, il est très bon pour la santé.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),
      ],
    ),
    Category(
      name: 'Thé noir',
      teas: [
        Tea(
          name: 'Thé des moines',
          quoting: 4,
          description: 'Le thé noir est un thé fermenté qui est très apprécié en Europe. Il est connu pour son goût corsé.',
          personalOpinion: 'Je n\'aime pas trop le thé noir, je le trouve trop fort.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),
      ],
    ),
    Category(
      name: 'Infusion',
      teas: [
        Tea(
          name: 'Infusion gourmande',
          quoting: 3,
          description: 'L\'infusion est une boisson sans théine qui est très appréciée en France. Elle est connue pour ses nombreuses saveurs.',
          personalOpinion: 'Je n\'aime pas trop l\'infusion, je la trouve fade.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),
        Tea(
          name: 'Jardin tropical',
          quoting: 2,
          description: 'L\'infusion est une boisson sans théine qui est très appréciée en France. Elle est connue pour ses nombreuses saveurs.',
          personalOpinion: 'Je n\'aime pas trop l\'infusion, je la trouve fade.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),
      ],
    ),
    Category(
      name: 'Thé blanc',
      teas: [
        Tea(
          name: 'Thé blanc de chine',
          quoting: 1,
          description: 'Le thé blanc est un thé fermenté qui est très apprécié en Europe. Il est connu pour son goût corsé.',
          personalOpinion: 'Je n\'aime pas trop le thé blanc, je le trouve trop fort.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),
      ],
    ),
    Category(
      name: 'Thé oolong',
      teas: [
        Tea(
          name: 'Thé oolong de chine',
          quoting: 5,
          description: 'Le thé oolong est une boisson très appréciée en Asie. Il est connu pour ses nombreuses vertus pour la santé.',
          personalOpinion: 'J\'aime beaucoup le thé oolong, il est très bon pour la santé.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),
      ],
    ),

    Category(
      name: 'Thé jaune',
      teas: [
        Tea(
          name: 'Thé jaune de chine',
          quoting: 4,
          description: 'Le thé jaune est un thé fermenté qui est très apprécié en Europe. Il est connu pour son goût corsé.',
          personalOpinion: 'Je n\'aime pas trop le thé jaune, je le trouve trop fort.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),
        Tea(
          name: 'Thé jaune de chine',
          quoting: 3,
          description: 'Le thé jaune est un thé fermenté qui est très apprécié en Europe. Il est connu pour son goût corsé.',
          personalOpinion: 'Je n\'aime pas trop le thé jaune, je le trouve trop fort.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),        Tea(
          name: 'Thé jaune de chine',
          quoting: 4,
          description: 'Le thé jaune est un thé fermenté qui est très apprécié en Europe. Il est connu pour son goût corsé.',
          personalOpinion: 'Je n\'aime pas trop le thé jaune, je le trouve trop fort.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),
        Tea(
          name: 'Thé jaune de chine',
          quoting: 3,
          description: 'Le thé jaune est un thé fermenté qui est très apprécié en Europe. Il est connu pour son goût corsé.',
          personalOpinion: 'Je n\'aime pas trop le thé jaune, je le trouve trop fort.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),        Tea(
          name: 'Thé jaune de chine',
          quoting: 4,
          description: 'Le thé jaune est un thé fermenté qui est très apprécié en Europe. Il est connu pour son goût corsé.',
          personalOpinion: 'Je n\'aime pas trop le thé jaune, je le trouve trop fort.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),
        Tea(
          name: 'Thé jaune de chine',
          quoting: 3,
          description: 'Le thé jaune est un thé fermenté qui est très apprécié en Europe. Il est connu pour son goût corsé.',
          personalOpinion: 'Je n\'aime pas trop le thé jaune, je le trouve trop fort.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),        Tea(
          name: 'Thé jaune de chine',
          quoting: 4,
          description: 'Le thé jaune est un thé fermenté qui est très apprécié en Europe. Il est connu pour son goût corsé.',
          personalOpinion: 'Je n\'aime pas trop le thé jaune, je le trouve trop fort.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),
        Tea(
          name: 'Thé jaune de chine',
          quoting: 3,
          description: 'Le thé jaune est un thé fermenté qui est très apprécié en Europe. Il est connu pour son goût corsé.',
          personalOpinion: 'Je n\'aime pas trop le thé jaune, je le trouve trop fort.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),        Tea(
          name: 'Thé jaune de chine',
          quoting: 4,
          description: 'Le thé jaune est un thé fermenté qui est très apprécié en Europe. Il est connu pour son goût corsé.',
          personalOpinion: 'Je n\'aime pas trop le thé jaune, je le trouve trop fort.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),
        Tea(
          name: 'Thé jaune de chine',
          quoting: 3,
          description: 'Le thé jaune est un thé fermenté qui est très apprécié en Europe. Il est connu pour son goût corsé.',
          personalOpinion: 'Je n\'aime pas trop le thé jaune, je le trouve trop fort.',
          picture: 'lib/pictures/teas/DefaultTeaPicture.png',
        ),

      ],
    ),
  ];
}