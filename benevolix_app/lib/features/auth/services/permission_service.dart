import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {
  final permission = Permission.location;

  if (await permission.isDenied) {
    final status = await permission.request();
    return status.isGranted;
  }

  return await permission.isGranted;
}

Future<bool> checkPermissionStatus() async {
  final permission = Permission.location;
  return await permission.status.isGranted;
}