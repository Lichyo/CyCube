import 'package:flutter/material.dart';
import 'package:cube/service/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required AuthService auth,
  }) : _auth = auth;

  final AuthService _auth;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            color: Colors.teal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/images/lichyo.jpg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                  child: Text(
                    'lichyo',
                    style: GoogleFonts.getFont(
                      'Ubuntu',
                      color: Colors.white,
                      fontSize: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/cube.png',
            ),
            title: const Text(
              'WCA ID : 2019LICH01',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              size: 55.0,
              color: Colors.teal.shade600,
            ),
            title: const Text(
              'lichyo003@gmail.com',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          GestureDetector(
            onTap: () async {
              await _auth.logout();
            },
            child: ListTile(
              leading: Icon(
                Icons.logout,
                size: 55.0,
                color: Colors.blue.shade500,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
