import 'package:flutter/material.dart';

import 'models/post_model.dart';
import 'utils/regex_img_func.dart';

class DetailPage extends StatelessWidget {
  final PostModel page;

  const DetailPage({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(page.postTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thumbnail Photo
              if (page.postThumbnail.isNotEmpty)
                Image.network(
                  extractImageUrl(page.postThumbnail),
                  fit: BoxFit.cover,
                ),
              const SizedBox(height: 16.0),

              // Aciklama Satirları
              if (page.aciklama_1_ust_baslik.isNotEmpty)
                Text(
                  page.aciklama_1_ust_baslik,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              if (page.aciklama_1.isNotEmpty)
                Text(
                  page.aciklama_1,
                  style: const TextStyle(fontSize: 16),
                ),
              if (page.aciklama_2_ust_baslik.isNotEmpty)
                Text(
                  page.aciklama_2_ust_baslik,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              if (page.aciklama_2.isNotEmpty)
                Text(
                  page.aciklama_2,
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 16.0),

              // Metin içerisindeki resimler
              if (page.imageUrls.isNotEmpty) ...[
                const Text(
                  'İlgili Resimler:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8.0),
                Column(
                  children: page.imageUrls.map((url) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Image.network(page.imageUrls[0]!),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
