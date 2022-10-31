import 'package:flutter/material.dart';
import 'common/widgets/bottom_bar.dart';
import 'features/auth/auth_screen.dart';
import 'features/chatapp/screens/chatroom_screen.dart';
import 'features/chatapp/screens/inbox_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      );

    case InboxScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const InboxScreen(),
      );

    case BottomBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomBar(),
      );

    case ChatroomScreen.routeName:
      var receiver = routeSettings.arguments as Map<String, String>;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ChatroomScreen(
          receiver: receiver,
        ),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Page not found!'),
          ),
        ),
      );
  }
}
