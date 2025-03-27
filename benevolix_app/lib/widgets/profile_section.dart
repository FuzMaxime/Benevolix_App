import 'package:flutter/material.dart';
import 'package:benevolix_app/constants/color.dart';

class ProfileSection extends StatelessWidget {
  final String title;
  final bool isEditing;
  final bool isReadOnly;
  final VoidCallback onEdit;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final Widget content;

  const ProfileSection({
    super.key,
    required this.title,
    required this.isEditing,
    required this.isReadOnly,
    required this.onEdit,
    required this.onCancel,
    required this.onSave,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstant.lightGrey, width: 2),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              isReadOnly
                  ? Container()
                  : isEditing
                      ? Row(
                          children: [
                            IconButton(
                              onPressed: onCancel,
                              icon: Icon(Icons.close,
                                  color: Colors.black, size: 25),
                            ),
                            IconButton(
                              onPressed: onSave,
                              icon: Icon(Icons.check_circle,
                                  color: ColorConstant.black, size: 25),
                            ),
                          ],
                        )
                      : IconButton(
                          onPressed: onEdit,
                          icon: Icon(Icons.edit,
                              color: ColorConstant.black, size: 25),
                        ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          content,
        ],
      ),
    );
  }
}
