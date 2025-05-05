import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_with_firebase/Core/Constances/all_colors.dart';
import '../MyProfile_Controller/myProfile_controller.dart';

class MyProfileScreen extends StatelessWidget {
  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildProfileHeader(),
            SizedBox(height: 30),
            _buildProfileInfoCard(),
            SizedBox(height: 20),
            _buildSettingsOptions(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Obx(() => CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
              backgroundImage: _profileController.imagePath.value.isNotEmpty
                  ? FileImage(File(_profileController.imagePath.value))
                  : null,
              child: _profileController.imagePath.value.isEmpty
                  ? Icon(Icons.person, size: 60, color: Colors.grey[600])
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
        SizedBox(height: 15),
        Obx(() => Text(
          _profileController.name.value,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        )),
        Obx(() => Text(
          _profileController.email.value,
          style: TextStyle(color: Colors.grey[600]),
        )),
      ],
    );
  }

  Widget _buildProfileInfoCard() {
    return Obx(() => Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInfoRow(Icons.person, 'Name', _profileController.name.value),
            Divider(),
            _buildInfoRow(Icons.email, 'Email', _profileController.email.value),
            Divider(),
            _buildInfoRow(Icons.date_range, 'Member since', 'January 2023'),
          ],
        ),
      ),
    ));
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.orangeAccent[100]),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.grey[600])),
              SizedBox(height: 5),
              Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsOptions() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildSettingsOption(Icons.settings, 'Settings'),
          Divider(),
          _buildSettingsOption(Icons.help, 'Help & Support'),
          Divider(),
          _buildSettingsOption(Icons.logout, 'Logout', isLogout: true),
        ],
      ),
    );
  }

  Widget _buildSettingsOption(IconData icon, String title, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.orangeAccent[100]),
      title: Text(title, style: TextStyle(
        color: isLogout ? Colors.red : Colors.black,
      )),
      trailing: Icon(Icons.arrow_forward_ios, size: 16,
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
              // يمكنك إضافة مسح بيانات الصورة هنا إذا أردت
              // _profileController.removeImage();
              Get.back();
            },
          );
        }
      },
    );
  }
}