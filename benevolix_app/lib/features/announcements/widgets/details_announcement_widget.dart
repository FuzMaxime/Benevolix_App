import 'package:benevolix_app/features/announcements/models/announcement_model.dart';
import 'package:benevolix_app/features/announcements/modals/details_announcement_modal.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/color.dart';
import '../../auth/widgets/profile_picture_widget.dart';

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
              // Header
            Row( spacing: 15,
              children: [
                ProfilePicture(
                  id: announcement.ownerId.toString(), 
                  firstName : announcement.ownerFirstname, 
                  lastName : announcement.ownerLastname, 
                  size : AvatarSize.small),
                Expanded(
                  child: Text(
                    announcement.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )],
              ),
              const Divider(),

            // Info Row
            Wrap(
              spacing: 8.0, // Horizontal spacing
              runSpacing: 4.0, // Vertical spacing
              children: [
                _infoItem(Icons.location_on, announcement.adress), // Location icon and address
                _infoItem(Icons.calendar_today, announcement.date), // Calendar icon and date
                _infoItem(Icons.access_time, "${announcement.duration} days"), // Duration icon and duration
                _infoItem(
                    announcement.isRemote ? Icons.laptop_mac : Icons.business,
                    announcement.isRemote ? "Remote" : "In-person"), // Remote or in-person icon and text
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

  // Helper method to create an info item with an icon and text
  Widget _infoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: ColorConstant.black),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            maxLines: 1, // Limit to one line
            overflow: TextOverflow.ellipsis, // Add ellipsis if necessary

            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
