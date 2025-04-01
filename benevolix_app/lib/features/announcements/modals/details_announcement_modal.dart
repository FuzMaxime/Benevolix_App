import 'package:benevolix_app/features/announcements/models/announcement_model.dart';
import 'package:intl/intl.dart';
import 'package:benevolix_app/core/widgets/submit_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:benevolix_app/features/auth/services/auth_service.dart';

import '../../../core/constants/color.dart';
import '../../auth/widgets/profile_picture_widget.dart';
import '../../candidacies/services/candidacy_service.dart';

class DetailsAnnouncement extends StatefulWidget {
  final Announcement announcement;

  const DetailsAnnouncement({Key? key, required this.announcement}) : super(key: key);

  @override
  _DetailsAnnouncementState createState() => _DetailsAnnouncementState();
}

class _DetailsAnnouncementState extends State<DetailsAnnouncement> {
  bool isLoading = false;
  late Announcement announcement;
  Future<String?> currentUserId = getUserId();

  @override
  void initState() {
    super.initState();
    announcement = widget.announcement;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      width: double.infinity,
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfilePicture(
                    firstName: announcement.ownerFirstname,
                    lastName: announcement.ownerLastname,
                    size: AvatarSize.small,
                  ),
                  IconButton(
                    icon: Image.asset("assets/images/close.png"),
                    onPressed: () {
                      Navigator.pop(context); // Ferme la modal
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Text(
              announcement.title,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ColorConstant.white,
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.location_on, color: ColorConstant.grey),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      announcement.adress,
                      style: TextStyle(color: ColorConstant.grey),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: ColorConstant.grey),
                  SizedBox(width: 4),
                  Text(
                    DateFormat('dd/MM/yyyy').format(DateTime.parse(announcement.date)),
                    style: TextStyle(color: ColorConstant.grey),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.access_time, color: ColorConstant.grey),
                  SizedBox(width: 4),
                  Text(
                    "${announcement.duration} heures",
                    style: TextStyle(color: ColorConstant.grey),
                  ),
                  SizedBox(width: 16),
                  Icon(
                    announcement.isRemote ? Icons.computer : Icons.business,
                    color: ColorConstant.grey,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Wrap(
              spacing: 8,
              children: announcement.tags.map((tag) => Chip(
                label: Text(
                  tag.name,
                  style: TextStyle(color: ColorConstant.red),
                ),
                backgroundColor: ColorConstant.darkRed,
              )).toList(),
            ),
            SizedBox(height: 15),
            Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorConstant.red,
              ),
            ),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorConstant.darkGrey,
                border: Border.all(color: ColorConstant.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                announcement.description,
                style: TextStyle(color: ColorConstant.white),
              ),
            ),
            SizedBox(height: 15),
            Wrap(
              spacing: 8,
              children:  announcement.application.map((application) => Chip(
                label: ProfilePicture(
                  firstName: "U",
                  lastName: application.annonceId.toString(),
                  size: AvatarSize.small,
                ),
                backgroundColor: ColorConstant.darkRed,
              )).toList(),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: SubmitButton(
                text: 'Je souhaite participer',
                onPressed: () async {
                  try {
                    String? userId = await currentUserId;
                    if (userId != null) {
                      int parsedId = int.parse(userId.trim());
                      await createApplication(
                        announcement.id,
                        DateTime.now(),
                        "Waiting",
                        parsedId,
                      );
                    } else {
                      print("Erreur : l'ID utilisateur est nul.");
                    }
                  } catch (e) {
                    print("Erreur lors de la création de la candidature : $e");
                  }
                },
                isLoading: isLoading,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
