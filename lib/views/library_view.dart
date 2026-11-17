import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/library_controller.dart';
import 'detail_view.dart';
import '../theme/app_colors.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoriteController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Library'),
        backgroundColor: AppColors.background,
      ),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return const Center(
            child: Text(
              'Library masih kosong.\nTambahkan game yang ingin kamu mainkan!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: controller.favorites.length,
          itemBuilder: (_, index) {
            final item = controller.favorites[index];
            final id = (item['id'] as num).toInt();
            return Card(
              color: AppColors.surface,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                contentPadding: const EdgeInsets.all(8),
                onTap: () => Get.to(() => DetailView(showId: id)),
                leading: _thumbnail(item['image'] as String? ?? ''),
                title: Text(
                  item['name'] as String? ?? 'Untitled game',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      '${item['genre'] as String? ?? 'Game'} • ${item['platform'] as String? ?? 'PC'}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () => controller.removeFavorite(id),
                  icon: const Icon(Icons.delete, color: AppColors.accent),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _thumbnail(String url) {
    if (url.isEmpty) return _placeholder();
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url,
        width: 58,
        height: 72,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _placeholder(),
      ),
    );
  }

  Widget _placeholder() => Container(
    width: 58,
    height: 72,
    color: Colors.white10,
    child: const Icon(Icons.sports_esports_outlined, color: Colors.white38),
  );
}
