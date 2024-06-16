import 'package:flutter/material.dart';
import 'package:login/app/data/constants/constants.dart';

class AppBarContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppStrings.appBarImage),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
