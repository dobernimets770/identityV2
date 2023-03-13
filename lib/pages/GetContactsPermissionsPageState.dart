import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class GetContactsPermissionsPageState extends StatefulWidget {
  const GetContactsPermissionsPageState({Key? key}) : super(key: key);

  @override
  State<GetContactsPermissionsPageState> createState() =>
      _GetContactsPermissionsPageState();
}

class _GetContactsPermissionsPageState
    extends State<GetContactsPermissionsPageState> {
  @override
  Widget build(BuildContext context) {
    _askPermissions("/SwipePage");
    return Scaffold(
      backgroundColor: Colors.black,
    );
  }

  Future<void> _askPermissions(String routeName) async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if (routeName != null) {
        Navigator.of(context).pushNamed(routeName);
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
