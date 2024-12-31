
part 'post_model.g.dart';

class PostModel {
  int postId;
  String postTitle;
  String aciklama_1;
  String aciklama_1_ust_baslik;
  String aciklama_2;
  String aciklama_2_ust_baslik;
  String postThumbnail;
  List<int?> termTaxonomyIds;
  List<String?> imageUrls;

  PostModel({
    required this.postId,
    required this.postTitle,
    required this.aciklama_1,
    required this.aciklama_1_ust_baslik,
    required this.aciklama_2,
    required this.aciklama_2_ust_baslik,
    required this.postThumbnail,
    required this.termTaxonomyIds,
    required this.imageUrls,
  });
  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
