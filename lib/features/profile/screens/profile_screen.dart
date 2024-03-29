import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/widgets/custom_text_widget.dart';
import '../../../constants/global_variables.dart';
import '../../../providers/user_provider.dart';
import '../../auth/auth_screen.dart';
import '../../auth/services/auth_services.dart';
import '../widgets/profile_details_row.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService authService = AuthService();
  List<String> profile = [
    // 'https://profiles.ucr.edu/app/images/default-profile.jpg',
    // 'name',
    // 'last name',
    // 'full name',
    // 'email',
  ];

  @override
  void initState() {
    super.initState();
    initProf();
  }

  initProf() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> prefProfile = prefs.getStringList('profile') ?? [];
    if (prefProfile != []) {
      profile = prefProfile;
      if (prefProfile[0].isEmpty) {
        profile.insert(
            0, 'https://profiles.ucr.edu/app/images/default-profile.jpg');
        // profile[0] = 'https://profiles.ucr.edu/app/images/default-profile.jpg';
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: SubtitleText(text: 'Profile'),
      ),
      body: profile.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                width: double.infinity,
                // height: MediaQuery.of(context).size.height * 0.80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   backgroundColor: const Color.fromRGBO(142, 142, 142, 0.5),
                    //   backgroundImage: CachedNetworkImageProvider(
                    //     profile[0].isNotEmpty
                    //         ? profile[0]
                    //         : 'https://profiles.ucr.edu/app/images/default-profile.jpg',
                    //   ),
                    //   radius: 60,
                    // ),
                    Consumer<UserProvider>(
                      builder: (context, userData, child) {
                        return ClipOval(
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromRGBO(142, 142, 142, 0.5),
                            radius: 60,
                            child: userData.user.image.isEmpty
                                ? Text(
                                    userData.user.alphabeticImage,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                    ),
                                  )
                                : CachedNetworkImage(
                                    imageUrl: '$uri${userData.user.image}',
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                            height: 20.0,
                                            width: 20.0,
                                            child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      // user.userName,
                      profile.isNotEmpty ? profile[1] : '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      profile.isNotEmpty
                          ? profile[2] == 'employer'
                              ? 'Freelancer'
                              : profile[2]
                          : '',
                      // user.profileviewas,
                      style: const TextStyle(
                        color: AppColors.colorGrey,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Divider(),
                    const SizedBox(height: 10.0),
                    profileDetailsRows(
                        name: 'First Name:',
                        value: profile.isNotEmpty ? profile[3] : ''),
                    profileDetailsRows(
                        name: 'Last Name:',
                        value: profile.isNotEmpty ? profile[4] : ''),
                    profileDetailsRows(
                        name: 'Full Name:',
                        value: profile.isNotEmpty
                            ? profile[1].isNotEmpty
                                ? profile[1]
                                : '${profile[3]} ${profile[4]}'
                            : ''),
                    profileDetailsRows(
                        name: 'Email:',
                        value: profile.isNotEmpty ? profile[5] : ''),
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
                        style: TextButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 55),
                        ),
                        onPressed: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setString('x-auth-token', '');
                          await prefs.setInt('userId', 0);
                          await prefs.setStringList('profile', []);
                          Navigator.pushNamedAndRemoveUntil(
                              context, AuthScreen.routeName, (route) => false);
                        },
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
