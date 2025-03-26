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
        isScrollControlled: true, // Permet un affichage complet
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
            NavBarLink(
                text: "Home",
                imageLink: 'assets/images/home_icon.png',
                link: "/home"),
            SizedBox(width: 40),
            NavBarLink(
                text: "Profile",
                imageLink: 'assets/images/user_icon.png',
                link: "/profile"),
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
  final String imageLink;

  const NavBarLink(
      {super.key,
      required this.text,
      required this.imageLink,
      required this.link});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, text);
            },
            icon: Image.asset(imageLink)),
        Text(
          text,
          style: TextStyle(color: ColorConstant.white),
        )
      ],
    );
  }
}
