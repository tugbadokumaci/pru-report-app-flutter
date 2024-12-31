import 'package:flutter/material.dart';
import '../models/eu_project_model.dart';

class EUProjectsCard extends StatelessWidget {
  final EUProjectModel project;
  final VoidCallback onTap;

  const EUProjectsCard({Key? key, required this.project, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 390, // Kartın genişliği
      child: GestureDetector(
        onTap: onTap, // onTap callback fonksiyonunu kullanıyoruz
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10)],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: <Widget>[
                // Resim alanı (Dikdörtgen boyutunda)
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    project.featuredImage,
                    fit: BoxFit.cover, // Resmi tam olarak kaplaması için
                  ),
                ),
                // Başlık ve açıklama alt alanda
                Container(
                  height: 200, // Resimle aynı yükseklikte olmalı
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.7),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end, // Yazıyı alta hizalı yapıyoruz
                    children: [
                      Text(
                        project.getGeneralInfoValue('Genel-Bilgiler-Baslik') ?? 'Bilgi yok',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
