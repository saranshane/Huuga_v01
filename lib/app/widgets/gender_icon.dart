import 'package:flutter/material.dart';
import 'package:login/app/data/constants/constants.dart';

Widget _buildGenderIcon(String gender) {
  IconData icon;
  Color color;

  switch (gender) {
    case AppStrings.genderMale:
      icon = Icons.male_rounded;
      color = AppColors.maleColor;
      break;
    case AppStrings.genderFemale:
      icon = Icons.female_rounded;
      color = AppColors.femaleColor;
      break;
    default:
      icon = Icons.transgender;
      color = AppColors.otherColor;
      break;
  }

  return Icon(icon, size: AppDimensions.genderIconSize, color: color);
}
