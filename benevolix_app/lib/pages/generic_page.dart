import 'package:benevolix_app/constants/color.dart';
import 'package:benevolix_app/widgets/create_announcement.dart';
import 'package:benevolix_app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GenericPage extends ConsumerStatefulWidget {
  final Widget child;

  const GenericPage(this.child, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GenericPage();
}

class _GenericPage extends ConsumerState<GenericPage> {
  void _showSlideUpView() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        // Permet un affichage complet
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        backgroundColor: ColorConstant.black,
        builder: (context) => CreateAnnouncement());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: MainHeader(title: "title")),
      bottomNavigationBar: BottomAppBar(
        height: 84,
        color: ColorConstant.black,
        // shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              child: NavBarLink(text: "Home", icon: Icons.home, link: "/home"),
            ),
            SizedBox(width: 40),
            SizedBox(
              child: NavBarLink(
                  text: "Profile", icon: Icons.person, link: "/profile"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSlideUpView,
        backgroundColor: ColorConstant.red,
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class NavBarLink extends StatelessWidget {
  final String text;
  final String link;
  final IconData icon;

  const NavBarLink(
      {super.key, required this.text, required this.icon, required this.link});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, link);
      },
      style: TextButton.styleFrom(
        foregroundColor: ColorConstant.white,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: ColorConstant.white,),
          SizedBox(height: 4),
          Text(text, style: TextStyle(color: ColorConstant.white)),
        ],
      ),
    );
  }
}
