import 'package:flutter/material.dart';
import '../../../common/widgets/custom_text_widget.dart';
import '../../../constants/global_variables.dart';
import '../widgets/profile_details_row.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: SubtitleText(text: 'Profile'),
        // const Text(
        //   'Profile',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(AssetImages.userDP),
                radius: 60,
              ),
              const SizedBox(height: 20.0),
              const Text(
                "Ayesha_zaka13",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 5.0),
              const Text(
                "Freelancer",
                style: TextStyle(
                  color: AppColors.colorGrey,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10.0),
              const Divider(),
              const SizedBox(height: 10.0),
              profileDetailsRows(name: 'First Name:', value: 'Ayesha'),
              profileDetailsRows(name: 'Last Name:', value: 'Zaka'),
              profileDetailsRows(name: 'Full Name:', value: 'Ayesha Zaka'),
              profileDetailsRows(name: 'Email:', value: 'ayeshazaka@gmail.com'),
              const Spacer(),
              Container(
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.colorBlue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Logout',
                    style: TextStyle(
                      color: AppColors.backgroundColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
