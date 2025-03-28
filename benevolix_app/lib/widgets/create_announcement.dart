import 'package:benevolix_app/constants/color.dart';
import 'package:benevolix_app/constants/decoration.dart';
import 'package:flutter/material.dart';

class CreateAnnouncement extends StatefulWidget {
  const CreateAnnouncement({super.key});

  @override
  State<StatefulWidget> createState() => _CreateAnnoucement();
}

class _CreateAnnoucement extends State<CreateAnnouncement> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.95,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Créer une nouvelle annonce",
                  style: TextStyle(fontSize: 18, color: ColorConstant.white)),
              IconButton(
                icon: Image.asset("assets/images/close.png"),
                onPressed: () {
                  Navigator.pop(context); // Ferme la modal
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  "Titre",
                  style: TextStyle(color: ColorConstant.red),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: titleController,
                  decoration: _getInputDecoration(""),
                )
              ])
            ],
          )
        ],
      ),
    );
  }
}

_getInputDecoration(String placeholder){
  return InputDecoration(
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      contentPadding: EdgeInsets.all(18.0),

      );
}