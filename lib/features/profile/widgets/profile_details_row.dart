import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';


class profileDetailsRows extends StatelessWidget {
  String name;
  String value;
  profileDetailsRows({
    Key? key,
    required this.name,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(
            "$name ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            "   $value",
            style: const TextStyle(
              color: AppColors.colorGrey,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}



