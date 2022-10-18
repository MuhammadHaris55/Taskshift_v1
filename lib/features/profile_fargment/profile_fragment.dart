
import 'package:flutter/material.dart';
import 'package:taskshift_v1/constants/global_variables.dart';


class ProfileMainPage extends StatelessWidget {
  const ProfileMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const  EdgeInsets.only(left: 10,bottom: 10,top: 10),
      child: Column(
        children: <Widget> [
          Expanded(child:Container(

             decoration: const BoxDecoration(
                color:AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children:const  <Widget>[
                  //var getchat=List<Getchat>();
                  
                  //FavoriteContacts(),
                //  ProfilePage(),
                // NotificationsPage(),
                  //RecentChats(widget.token!),
                ],
              ),
          ),
          
        )
          
          
        ],
      )
  
      
    );
  }
}