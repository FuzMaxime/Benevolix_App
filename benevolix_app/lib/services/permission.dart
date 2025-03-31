
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermission() async {
  final permission = Permission.location;

  if (await permission.isDenied) {
    await permission.request();
  }
}

Future<bool> checkPermissionStatus() async {
  final permission = Permission.location;
  return await permission.status.isGranted;
}