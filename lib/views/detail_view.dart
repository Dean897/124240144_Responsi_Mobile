import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_controller.dart';
import '../theme/app_colors.dart';

class DetailView extends StatelessWidget {
  const DetailView({required this.showId, super.key});
  final int showId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DetailController(showId: showId));
    return Scaffold(
      appBar: AppBar(title: const Text('Detail')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          );
        }
        final show = controller.show.value;
        if (show == null) {
          return Center(
            child: Text(controller.errorMessage.value ?? 'Tidak ada data.'),
          );
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: _image(show.thumbnail),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      show.title,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _tag(Icons.category_outlined, show.genre),
                        _tag(Icons.devices_outlined, show.platform),
                        _tag(Icons.calendar_today_outlined, show.releaseDate),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (show.screenshots.isNotEmpty) ...[
                      const Text(
                        'Screenshots',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 110,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: show.screenshots.length,
                          separatorBuilder: (_, _) => const SizedBox(width: 10),
                          itemBuilder: (_, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              show.screenshots[index],
                              width: 180,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => Container(
                                width: 180,
                                color: AppColors.surface,
                                child: const Icon(Icons.broken_image_outlined),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 22),
                    ],
                    const Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      show.description.isEmpty
                          ? 'Deskripsi belum tersedia.'
                          : show.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => Get.snackbar(
                              'Hayper Games',
                              'Fitur mulai game tersedia dari halaman resmi game.',
                            ),
                            icon: const Icon(Icons.play_arrow_rounded),
                            label: const Text('Start Game'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Obx(
                          () => IconButton(
                            tooltip: controller.isFavorite.value
                                ? 'Hapus game dari library'
                                : 'Tambahkan game ke library',
                            onPressed: controller.toggleFavorite,
                            icon: Icon(
                              controller.isFavorite.value
                                  ? Icons.library_add_check
                                  : Icons.library_add_outlined,
                              color: controller.isFavorite.value
                                  ? AppColors.accent
                                  : Colors.white,
                            ),
                            style: IconButton.styleFrom(
                              side: const BorderSide(color: Colors.white38),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _tag(IconData icon, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Chip(
      avatar: Icon(icon, size: 15, color: AppColors.accent),
      label: Text(value),
      backgroundColor: AppColors.surface,
      side: BorderSide.none,
      labelStyle: const TextStyle(color: Colors.white70, fontSize: 12),
    );
  }

  Widget _image(String url) {
    if (url.isEmpty) {
      return Container(
        color: Colors.white10,
        child: const Icon(Icons.sports_esports, size: 70),
      );
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      errorBuilder: (_, _, _) => Container(
        color: Colors.white10,
        child: const Icon(Icons.sports_esports, size: 70),
      ),
    );
  }
}
