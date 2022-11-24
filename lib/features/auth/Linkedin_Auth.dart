import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';

const String redirectUrl =
    'https://www.linkedin.com/developers/tools/oauth/redirect';
const String clientId = '77ywlo36hrljlk';
const String clientSecret = 'qNeoNHZ0cvAWazKe';

class LinkedInProfileExamplePage extends StatefulWidget {
  // const LinkedInProfileExamplePage({required final Key key}) : super(key: key);

  @override
  State createState() => _LinkedInProfileExamplePageState();
}

class _LinkedInProfileExamplePageState
    extends State<LinkedInProfileExamplePage> {
  late UserObject? user = new UserObject();
  bool logoutUser = false;

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          LinkedInButtonStandardWidget(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (final BuildContext context) => LinkedInUserWidget(
                    appBar: AppBar(
                      title: const Text('OAuth User'),
                    ),
                    destroySession: logoutUser,
                    redirectUrl: redirectUrl,
                    clientId: clientId,
                    clientSecret: clientSecret,
                    projection: const [
                      ProjectionParameters.id,
                      ProjectionParameters.localizedFirstName,
                      ProjectionParameters.localizedLastName,
                      ProjectionParameters.firstName,
                      ProjectionParameters.lastName,
                      ProjectionParameters.profilePicture,
                    ],
                    onError: (final UserFailedAction e) {
                      print('Error: ${e.toString()}');
                      print('Error: ${e.stackTrace.toString()}');
                    },
                    onGetUserProfile: (final UserSucceededAction linkedInUser) {
                      print(
                        'Access token ${linkedInUser.user.token.accessToken}',
                      );

                      print('User id: ${linkedInUser.user.userId}');
                      print('USer DATA : ' + linkedInUser.user.toString());

                      user = UserObject(
                        firstName:
                            linkedInUser?.user?.firstName?.localized?.label,
                        lastName:
                            linkedInUser?.user?.lastName?.localized?.label,
                        email: linkedInUser?.user?.email?.elements![0]
                            ?.handleDeep?.emailAddress,
                        profileImageUrl: linkedInUser
                            ?.user
                            ?.profilePicture
                            ?.displayImageContent
                            ?.elements![0]
                            ?.identifiers![0]
                            ?.identifier,
                      );

                      setState(() {
                        logoutUser = false;
                      });

                      Navigator.pop(context);
                    },
                  ),
                  fullscreenDialog: true,
                ),
              );
            },
          ),
          LinkedInButtonStandardWidget(
            onTap: () {
              setState(() {
                user = null;
                logoutUser = true;
              });
            },
            buttonText: 'Logout',
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('First: ${user?.firstName} '),
              Text('Last: ${user?.lastName} '),
              Text('Email: ${user?.email}'),
              Text('Profile image: ${user?.profileImageUrl}'),
            ],
          ),
        ],
      ),
    );
  }
}

class AuthCodeObject {
  AuthCodeObject({this.code, this.state});

  final String? code;
  final String? state;
}

class UserObject {
  UserObject({
    this.firstName,
    this.lastName,
    this.email,
    this.profileImageUrl,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? profileImageUrl;
}
