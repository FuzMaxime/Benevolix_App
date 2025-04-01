import 'dart:collection';

import 'package:benevolix_app/constants/color.dart';
import 'package:benevolix_app/services/createAnnouncementService.dart';
import 'package:benevolix_app/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateAnnouncement extends StatefulWidget {
  const CreateAnnouncement({super.key});

  @override
  State<StatefulWidget> createState() => _CreateAnnouncement();
}

class _CreateAnnouncement extends State<CreateAnnouncement> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController tagController = TextEditingController();
  bool isTagLoading = false;
  bool isLoading = false;

  Map<int, String> addedTags = HashMap();

  bool isRemote = false;
  DateTime? selectedDate = DateTime(2025, 7, 25);
  final double labelInputGap = 10;

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(2025, 4, 1),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5));
    setState(() {
      selectedDate = pickedDate ?? selectedDate;
    });
  }

  void _handleAddTag() async {
    if (tagController.text.isEmpty) {
      return;
    }

    setState(() {
      isTagLoading = true;
    });

    final response = await addTag(tagController.text);
    if(response != null){
      addedTags.putIfAbsent(response.id!, () => tagController.text);
    }else{
      // TODO : manage error here
      print("Erreur : Le tag n'a pas pu être ajouté.");
    }
    tagController.clear();

    setState(() {
      isTagLoading = false;
    });
  }
  void _handleCreateAnnouncement() async{
    setState(() {
      isTagLoading = true;
    });

    final response = await createAnnouncement(titleController.text, descriptionController.text, selectedDate!, int.parse(durationController.text), placeController.text, isRemote, addedTags);

    setState(() {
      isTagLoading = false;
    });

    if(response != null) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Créer une nouvelle annonce",
                      style: _getTextInputStyle()),
                  IconButton(
                    icon: Image.asset("assets/images/close.png"),
                    onPressed: () {
                      Navigator.pop(context); // Ferme la modal
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              Column(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Titre",
                          style: TextStyle(color: ColorConstant.red),
                        ),
                        SizedBox(
                          height: labelInputGap,
                        ),
                        TextField(
                            controller: titleController,
                            decoration:
                                _getInputDecoration("Randonnée Mont ventoux"),
                            style: _getTextInputStyle())
                      ]),
                  SizedBox(height: 15),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(color: ColorConstant.red),
                        ),
                        SizedBox(
                          height: labelInputGap,
                        ),
                        TextField(
                          controller: descriptionController,
                          maxLines: 7,
                          decoration: _getInputDecoration(
                              "Rendez-vous le 18 juin pour une randonnée au mont ventou !"),
                          style: _getTextInputStyle(),
                        )
                      ]),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 200,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(color: ColorConstant.red),
                                ),
                                SizedBox(
                                  height: labelInputGap,
                                ),
                                OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      side:
                                          BorderSide(color: ColorConstant.grey),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      padding: EdgeInsets.all(22.0),
                                    ),
                                    onPressed: _selectDate,
                                    child: SizedBox(
                                      height: 20,
                                      child:  Row(
                                          spacing: 20,
                                          children: [
                                          Image.asset(
                                          "assets/images/date_icon.png"),
                                      Text(
                                        '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                                        style: _getTextInputStyle(),
                                      )
                                      ,
                                    ]),
                                    ))
                              ])),
                      SizedBox(
                          width: 120,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Durée (en min)",
                                  style: TextStyle(color: ColorConstant.red),
                                ),
                                SizedBox(
                                  height: labelInputGap,
                                ),
                                TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: durationController,
                                    decoration: _getInputWithIconDecoration(
                                        "", "assets/images/sablier_icon.png"),
                                    style: _getTextInputStyle())
                              ])),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    spacing: 15,
                    children: [
                      Text(
                        "Distanciel",
                        style: TextStyle(color: ColorConstant.red),
                      ),
                      Switch(
                        value: isRemote,
                        onChanged: (bool value) {
                          setState(() {
                            isRemote = value;
                          });
                        },
                        activeColor: ColorConstant.red,
                        inactiveTrackColor: ColorConstant.grey,
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  !isRemote
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                                "Lieu",
                                style: TextStyle(color: ColorConstant.red),
                              ),
                              SizedBox(
                                height: labelInputGap,
                              ),
                              TextField(
                                  controller: placeController,
                                  decoration: _getInputWithIconDecoration(
                                      "8 rue du général Hube...",
                                      "assets/images/place_icon.png"),
                                  style: _getTextInputStyle())
                            ])
                      : SizedBox(
                          height: 0,
                        ),
                  SizedBox(height: 15),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tags",
                          style: TextStyle(color: ColorConstant.red),
                        ),
                        SizedBox(
                          height: labelInputGap,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 250,
                              child: TextField(
                                  controller: tagController,
                                  decoration: _getInputWithIconDecoration(
                                      "Nature",
                                      "assets/images/hashtag_icon.png"),
                                  style: _getTextInputStyle()),
                            ),
                            FloatingActionButton(
                                onPressed: _handleAddTag,
                                backgroundColor: ColorConstant.red,
                                child: Icon(Icons.add,
                                    size: 35, color: Colors.white))
                          ],
                        ),
                        SizedBox(height: 15),
                        Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: addedTags.entries.map((entry) {
                              return Chip(
                                  label: Text(
                                    entry.value,
                                    style: TextStyle(
                                        fontSize: 12, color: ColorConstant.red),
                                  ),
                                  backgroundColor: ColorConstant.darkRed,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: ColorConstant.darkRed, width: 1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  deleteIcon: Icon(Icons.close,
                                      size: 16, color: ColorConstant.red),
                                  onDeleted: () {
                                    setState(() {
                                      addedTags.remove(entry.key);
                                    });
                                  });
                            }).toList()),
                      ]),
                  SizedBox(
                    height: 25,
                  ),
                  SubmitButton(
                      text: 'Créer',
                      onPressed:_handleCreateAnnouncement,
                      isLoading: isLoading),
                ],
              )
            ],
          ),
        ));
  }
}

_getInputDecoration(String placeholder) {
  return InputDecoration(
      border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstant.white)),
      contentPadding: EdgeInsets.all(18.0),
      hintText: placeholder);
}

_getInputWithIconDecoration(String placeholder, String iconPath) {
  return InputDecoration(
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0))),
    focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: ColorConstant.white)),
    contentPadding: EdgeInsets.all(18.0),
    hintText: placeholder,
    prefixIcon: Padding(
      padding: EdgeInsets.all(12.0),
      child: SizedBox(
        width: 24,
        height: 24,
        child: Image.asset(iconPath),
      ),
    ),
  );
}

_getTextInputStyle() {
  return TextStyle(color: ColorConstant.white, fontSize: 18);
}
