import 'package:flutter/material.dart';
import '../models/eu_project_model.dart';

class EUEventsCard extends StatelessWidget {
  final EUProjectModel project;
  final List<EUMetaData?>? event;

  const EUEventsCard({Key? key, required this.event, required this.project}) : super(key: key);

  // Helper function to get meta data value
  String? getEUMetaDataValue(List<EUMetaData?>? metaDataList, String key) {
    if (metaDataList == null) return null;
    for (var metaData in metaDataList) {
      if (metaData != null && metaData.metaKey == key) {
        return metaData.metaValue as String?;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Extract specific meta values using the helper function
    String title = getEUMetaDataValue(event, 'etkinlik-baslik') ?? 'Event Title';
    String description = getEUMetaDataValue(event, 'etkinlik-icerik') ?? 'Event Description';
    String featuredImage = getEUMetaDataValue(event, 'featured_image') ?? project.featuredImage;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: featuredImage.isNotEmpty
                ? Image.network(
                    featuredImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('Resim yüklenemedi.'));
                    },
                  )
                : const Center(child: Text('Resim bulunamadı.')),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // const SizedBox(height: 10),
                // Html(
                //   data: description,
                //   style: {
                //     "body": Style(
                //       color: Colors.black,
                //       fontSize: FontSize(14),
                //     ),
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
