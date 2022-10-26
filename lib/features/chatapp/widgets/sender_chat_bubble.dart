import 'package:flutter/material.dart';
import '../../../constants/global_variables.dart';

class SenderChatBubble extends StatelessWidget {
  String message;
  SenderChatBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding:
                const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.35,
            ),
            decoration: const BoxDecoration(
              color: AppColors.colorBlue,
              borderRadius: BorderRadius.only(
                topRight: Radius.zero,
                topLeft: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              const Text(
                '9:45AM',
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          ),
        ),
      ],
    );
  }
}
