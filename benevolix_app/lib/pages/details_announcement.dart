import 'package:benevolix_app/constants/color.dart';
import 'package:benevolix_app/models/announcement.dart';
import 'package:benevolix_app/widgets/details_announcement.dart';
import 'package:flutter/material.dart';

class AnnouncementDetails extends StatelessWidget {
  final Announcement announcement;

  const AnnouncementDetails({super.key, required this.announcement});

  void _showSlideUpView(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: ColorConstant.black,
      builder: (context) => DetailsAnnouncement(announcement: announcement),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSlideUpView(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      announcement.title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Divider(),

              // Info Row
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: [
                  _infoItem(Icons.location_on, announcement.adress),
                  _infoItem(Icons.calendar_today, announcement.date),
                  _infoItem(Icons.access_time, "${announcement.duration} jours"),
                  _infoItem(
                    announcement.isRemote ? Icons.laptop_mac : Icons.business,
                    announcement.isRemote ? "À distance" : "Présentiel",
                  ),
                ],
              ),
              const Divider(),

              // Description
              Text(
                announcement.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: ColorConstant.grey),
              ),
              const SizedBox(height: 12),

              // Tags
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: announcement.tags.map((tag) {
                  return Chip(
                    label: Text(
                      tag.name,
                      style: TextStyle(fontSize: 12, color: ColorConstant.red),
                    ),
                    backgroundColor: ColorConstant.lightRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: ColorConstant.black),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
