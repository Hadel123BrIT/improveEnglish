import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../Core/Constances/all_colors.dart';
import '../../../Widgets/buildFoot/buildFoot_Controller.dart';
import '../../../Widgets/buildFoot/buildFooter.dart';
import '../Setting_Controller/settimg_controller.dart';

class SettingScreen extends StatelessWidget {
  final SettingsController _settingsController = Get.put(SettingsController());
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[300],
        child: Container(
          width: mediaQuery.size.width * 0.06,
          height: mediaQuery.size.width * 0.06,
          child: Icon(Icons.add_box_outlined, color: Colors.black),
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: background,
      bottomNavigationBar: const CustomBottomNavigationBar(),
      appBar: AppBar(
        backgroundColor: background,

        title: Text(
          'الإعدادات',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader('المظهر العام'),
              _buildDarkModeSwitch(),
              SizedBox(height: 20),
              _buildHeader('الإشعارات'),
              _buildNotificationSwitch(),
              SizedBox(height: 20),
              _buildHeader('اللغة'),
              _buildLanguageSelector(),
              SizedBox(height: 20),
              _buildHeader('حجم الخط'),
              _buildFontSizeSlider(),
              SizedBox(height: 30),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildDarkModeSwitch() {
    return Obx(() => ListTile(
      leading: SvgPicture.asset(
        'assets/icons/moon.svg',
        width: 24,
        color: Colors.orangeAccent[100],
      ),
      title: Text('الوضع الليلي'),
      trailing: Switch(
        value: _settingsController.isDarkMode.value,
        onChanged: _settingsController.toggleDarkMode,
        activeColor:Colors.orangeAccent[100],
      ),
    ));
  }

  Widget _buildNotificationSwitch() {
    return Obx(() => ListTile(
      leading: Icon(Icons.notifications_active,
          color: Colors.orangeAccent[100]),
      title: Text('تفعيل الإشعارات'),
      trailing: Switch(
        value: _settingsController.notificationsEnabled.value,
        onChanged: _settingsController.toggleNotifications,
        activeColor: Colors.orangeAccent[100],
      ),
    ));
  }

  Widget _buildLanguageSelector() {
    return Obx(() => ListTile(
      leading: Icon(Icons.language, color: Colors.orangeAccent[100]),
      title: Text('اللغة'),
      trailing: DropdownButton<String>(
        value: _settingsController.language.value,
        items: <String>['العربية', 'English', 'Français']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            _settingsController.changeLanguage(newValue);
          }
        },
      ),
    ));
  }

  Widget _buildFontSizeSlider() {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Slider(
            value: _settingsController.fontSize.value,
            min: 12,
            max: 24,
            divisions: 6,
            label: _settingsController.fontSize.value.round().toString(),
            onChanged: _settingsController.changeFontSize,
            activeColor: Colors.orangeAccent[100],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('صغير', style: TextStyle(fontSize: 12)),
              Text('متوسط', style: TextStyle(fontSize: 18)),
              Text('كبير', style: TextStyle(fontSize: 24)),
            ],
          ),
        ],
      ),
    ));
  }

  Widget _buildSaveButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Get.snackbar(
            'تم الحفظ',
            'تم حفظ الإعدادات بنجاح',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orangeAccent[100],
            colorText: Colors.white,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12),
          child: Text('حفظ الإعدادات'),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
