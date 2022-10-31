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
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Text(
              "$name ",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.50,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                color: AppColors.colorGrey,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
