import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../services/storage_service.dart';
import '../theme/app_colors.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final authController = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Profil'),
        backgroundColor: AppColors.background,
      ),
      body: FutureBuilder<String?>(
        future: StorageService().getUsername(),
        builder: (context, snapshot) {
          final email = snapshot.data ?? '-';
          final gameCount = StorageService().getAllFavorites().length;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 54,
                  backgroundColor: AppColors.surface,
                  child: Icon(Icons.person, size: 62, color: AppColors.accent),
                ),
                const SizedBox(height: 16),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  '$gameCount game tersimpan di library',
                  style: const TextStyle(color: AppColors.mutedText),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: authController.logout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
