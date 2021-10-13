import 'package:whiteboard_swd/models/criteria.dart';
import 'package:whiteboard_swd/models/image_post.dart';

class Post {
  String? id;
  String? status;
  String? title;
  String? content;
  String? campaignId;
  String? campaignName;
  String? reviewerId;
  String? reviewerName;
  String? reviewerAvatar;
  String? onDateTime;
  String? campusId;
  String? campusName;
  String? universityId;
  String? universityName;
  String? reviewerEmail;

  List<ImagePost>? imagePost;
  List<Criteria>? postCriteria;

  Post({
    this.id,
    this.status,
    this.title,
    this.content,
    this.campaignId,
    this.campaignName,
    this.reviewerId,
    this.reviewerName,
    this.reviewerAvatar,
    this.onDateTime,
    this.campusId,
    this.campusName,
    this.reviewerEmail,
    this.imagePost,
    this.postCriteria,
    this.universityId,
    this.universityName,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    campusName = json['campusName'];
    title = json['title'];
    content = json['content'];
    campaignId = json['campaignId'];
    reviewerId = json['reviewerId'];
    reviewerName = json['reviewerName'];
    reviewerAvatar = json['reviewerAvatar'];
    onDateTime = json['onDateTime'];
    campusId = json['campusId'];
    campusName = json['campusName'];
    reviewerEmail = json['reviewerEmail'];
    universityId = json['universityId'];
    universityName = json['universityName'];

    var imageList = json['pictures'] as List;
    List<ImagePost> imagePostList =
        imageList.map((e) => ImagePost.fromJson(e)).toList();
    imagePost = imagePostList;

    var list = json['criterions'] as List;
    List<Criteria> criteriaList =
        list.map((e) => Criteria.fromJson(e)).toList();
    postCriteria = criteriaList;
  }
}

class Posts {
  List<Post>? listPost;
  Posts.fromJson(Map<String, dynamic> json) {
    var list = json['reviews'] as List;
    List<Post> posts = list.map((e) => Post.fromJson(e)).toList();
    listPost = posts;
  }
}
