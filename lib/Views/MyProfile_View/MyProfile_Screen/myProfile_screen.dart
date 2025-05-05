import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_with_firebase/Core/Constances/all_colors.dart';
import '../MyProfile_Controller/myProfile_controller.dart';

class MyProfileScreen extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(mediaQuery.size.width * 0.05),
        child: Column(
          children: [
            _buildProfileHeader(context),
            SizedBox(height: mediaQuery.size.height * 0.03),
            _buildProfileInfoCard(context),
            SizedBox(height: mediaQuery.size.height * 0.02),
            _buildSettingsOptions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Obx(() => CircleAvatar(
              radius: mediaQuery.size.width * 0.15,
              backgroundColor: Colors.grey[300],
              backgroundImage: _profileController.imagePath.value.isNotEmpty
                  ? FileImage(File(_profileController.imagePath.value))
                  : null,
              child: _profileController.imagePath.value.isEmpty
                  ? Icon(Icons.person,
                  size: mediaQuery.size.width * 0.15,
                  color: Colors.grey[600])
                  : null,
            )),
            Obx(() => FloatingActionButton(
              mini: true,
              backgroundColor: Colors.orangeAccent[100],
              child: _profileController.isLoading.value
                  ? CircularProgressIndicator(color: Colors.white)
                  : Icon(Icons.camera_alt, color: Colors.white),
              onPressed: _profileController.isLoading.value ? null : () {
                _profileController.pickAndSaveImage();
              },
            )),
          ],
        ),
        SizedBox(height: mediaQuery.size.height * 0.015),
        Obx(() => Text(
          _profileController.name.value,
          style: TextStyle(
              fontSize: mediaQuery.size.width * 0.055,
              fontWeight: FontWeight.bold
          ),
        )),
        Obx(() => Text(
          _profileController.email.value,
          style: TextStyle(color: Colors.grey[600]),
        )),
      ],
    );
  }

  Widget _buildProfileInfoCard(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Obx(() => Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(mediaQuery.size.width * 0.04),
      ),
      child: Padding(
        padding: EdgeInsets.all(mediaQuery.size.width * 0.05),
        child: Column(
          children: [
            _buildInfoRow(context, Icons.person, 'Name', _profileController.name.value),
            Divider(),
            _buildInfoRow(context, Icons.email, 'Email', _profileController.email.value),
            Divider(),
            _buildInfoRow(context, Icons.date_range, 'Member since', 'January 2023'),
          ],
        ),
      ),
    ));
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String title, String value) {
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: mediaQuery.size.height * 0.01),
      child: Row(
        children: [
          Icon(icon, color: Colors.orangeAccent[100]),
          SizedBox(width: mediaQuery.size.width * 0.04),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.grey[600])),
              SizedBox(height: mediaQuery.size.height * 0.005),
              Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOptions(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(mediaQuery.size.width * 0.04),
      ),
      child: Column(
        children: [
          _buildSettingsOption(context, Icons.settings, 'Settings'),
          Divider(),
          _buildSettingsOption(context, Icons.help, 'Help & Support'),
          Divider(),
          _buildSettingsOption(context, Icons.logout, 'Logout', isLogout: true),
        ],
      ),
    );
  }

  Widget _buildSettingsOption(BuildContext context, IconData icon, String title, {bool isLogout = false}) {
    final mediaQuery = MediaQuery.of(context);

    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.orangeAccent[100]),
      title: Text(title, style: TextStyle(
        color: isLogout ? Colors.red : Colors.black,
      )),
      trailing: Icon(Icons.arrow_forward_ios,
          size: mediaQuery.size.width * 0.04,
          color: isLogout ? Colors.red : Colors.grey),
      onTap: () {
        if (isLogout) {
          Get.defaultDialog(
            title: 'Logout',
            middleText: 'Are you sure you want to logout?',
            textConfirm: 'Yes',
            textCancel: 'No',
            confirmTextColor: Colors.white,
            onConfirm: () {
              // _profileController.removeImage();
              Get.back();
            },
          );
        }
      },
    );
  }
}