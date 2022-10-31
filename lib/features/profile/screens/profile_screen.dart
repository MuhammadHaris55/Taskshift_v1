import 'package:flutter/material.dart';
import 'package:taskshift_v1/features/auth/auth_screen.dart';
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
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          width: double.infinity,
          // height: MediaQuery.of(context).size.height * 0.80,
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
              const SizedBox(height: 12.0),
              // const Spacer(),
              Container(
                alignment: Alignment.bottomCenter,
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.colorBlue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(
                      context, AuthScreen.routeName, (route) => false),
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
