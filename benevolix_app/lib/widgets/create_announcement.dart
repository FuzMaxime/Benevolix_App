import 'package:flutter/material.dart';

class CreateAnnouncement extends StatefulWidget {
  const CreateAnnouncement({super.key});

  @override
  State<StatefulWidget> createState() => _CreateAnnoucement();
}

class _CreateAnnoucement extends State<CreateAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Slide Up View",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Contenu de votre slide-up modal ici."),
        ],
      ),
    );
  }
}
