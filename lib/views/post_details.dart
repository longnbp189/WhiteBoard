import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whiteboard_swd/models/campaign.dart';
import 'package:whiteboard_swd/models/criteria.dart';
import 'package:whiteboard_swd/models/image_post.dart';
import 'package:whiteboard_swd/models/post.dart';
import 'package:whiteboard_swd/presenters/campaign_request.dart';
import 'package:whiteboard_swd/presenters/post_request.dart';
import 'package:whiteboard_swd/utils/color.dart';
import 'package:whiteboard_swd/views/campaign_details.dart';

class PostDetail extends StatelessWidget {
  String? postId;
  late Post post;

  PostDetail({required this.postId});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double appbarSize = size.height * 0.3;
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder<Post?>(
                future: PostRequest.getPostById(postId!),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    post = snapshot.data!;
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          title: Text(
                            'Chi tiết bài viết',
                            style: TextStyle(fontSize: 16),
                          ),
                          centerTitle: true,
                          backgroundColor: Color(0xa02682F7),
                          expandedHeight: appbarSize,
                          floating: true,
                          pinned: true,
                          //leading: Icon(Icons.arrow_back),
                          flexibleSpace: FlexibleSpaceBar(
                              collapseMode: CollapseMode.pin,
                              background: Stack(
                                children: [
                                  //campaign image
                                  Image.network(
                                    post.imagePost![0].picture.toString(),
                                    width: size.width,
                                    fit: BoxFit.cover,
                                  ),

                                  ////campaign name

                                  Container(
                                    height: appbarSize - 5,
                                    decoration: BoxDecoration(
                                      // borderRadius:
                                      //     BorderRadius.only(bottomLeft: Radius.circular(60)),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black12,
                                          Colors.black26,
                                          Colors.black38,
                                          Colors.black54,
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: appbarSize * 0.85,
                                      left: 0,
                                      right: 0,
                                      height: appbarSize * 0.15,
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft:
                                                const Radius.circular(30.0),
                                            topRight:
                                                const Radius.circular(30.0),
                                          ),
                                          color: Colors.white,
                                        ),
                                      )),
                                  Positioned(
                                    width: size.width,
                                    top: appbarSize * 0.5,
                                    left: size.width * 0.1,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            convertHeader(
                                                post.campaignName.toString()),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: appbarSize * 0.1,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                        ]),
                                  ),
                                ],
                              )),
                          actions: [
                            IconButton(
                                onPressed: () async {
                                  var campaign =
                                      await NetworkRequest.getCampaignById(
                                          post.campaignId!);
                                  final prefs =
                                      await SharedPreferences.getInstance();

                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CampaignDetails(
                                            campaign: campaign!,
                                            reviewerId:
                                                prefs.getString("reviewerId")!,
                                            token: prefs.getString("token")!,
                                          )));
                                },
                                icon: Icon(Icons.info_outline))]
                            //Icon(icon),
                            //IconButton(onPressed: (){
                            // PopupMenuButton(
                            //     itemBuilder: (context) => [
                            //           // PopupMenuItem(
                            //           //   child: Text("Delete post"),
                            //           //   value: 1,
                            //           //   onTap: () {},
                            //           // ),
                            //           PopupMenuItem(
                            //             child: Text("View campaign"),
                            //             value: 1,
                            //             // onTap: () {}
                            //           )
                            //         ])
                            // }, icon: Icon(Icons.info_outlined))
                          ,
                        ),

                        //createPostContent(context),
                        buildContent(context)
                      ],
                    );
                  } else
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                })));
  }

  Widget buildContent(BuildContext context) {
    int NoImage = post.imagePost!.length;
    return SliverToBoxAdapter(
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              createPostContent(context),
              StaggeredGridView.countBuilder(
                staggeredTileBuilder: (index) => NoImage < 2
                    ? StaggeredTile.count(1, NoImage.toDouble())
                    : StaggeredTile.count(2, index.isEven ? 2 : 1),
                //: StaggeredTile.count(1, 1),
                crossAxisCount: (NoImage > 2) ? 4 : NoImage,
                itemCount: post.imagePost!.length,
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) => buildImageCard(context, index),
              ),
            ])));
  }

  Widget buildImageCard(BuildContext context, int index) => InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ImageReview(
                  image: post.imagePost![index],
                )));
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: Container(
          margin: EdgeInsets.all(8),
          child: ClipRRect(
            child: Image.network(
              post.imagePost![index].picture.toString(),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ));

  Widget createPostContent(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(children: [
      (post.whyNotPublic != null)
          ? Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red.shade600),
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(size.height * 0.02),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.error_outline,
                            size: 30, color: Colors.red.shade600),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: size.width - 125,
                        child: Text(
                          'Bài viết của bạn không được chấp nhận bởi vì ' +
                              post.whyNotPublic.toString(),
                          style: TextStyle(
                              fontSize: 13, color: Colors.red.withOpacity(0.9)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : SizedBox(),
      Row(
        children: [
          Container(
            width: size.height * 0.07,
            height: size.height * 0.07,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(post.reviewerAvatar.toString()),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(size.height * 0.1)),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.universityName.toString() +
                    " - " +
                    post.campusName.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black54),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                post.reviewerName.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                parseDate(post.onDateTime.toString()),
                style: TextStyle(fontSize: 12, color: grey_text),
              ),
            ],
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              post.title.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              post.content.toString(),
              style: TextStyle(fontSize: 14),
              //overflow: TextOverflow.ellipsis,
              // maxLines: 5,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 2,
              runSpacing: 2,
              direction: Axis.horizontal,
              children: createCriteriaList(post.postCriteria!, 16),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      )
    ]);
  }

  String convertHeader(String string) {
    String result = '';
    var array = string.split(' ');
    if (array.length < 5) return string;
    int gap = 3 + (array.length % 2 == 0 ? 1 : 0);
    for (var i = 0; i < array.length; i += gap) {
      if (array.length - i <= 6) gap = array.length - i;
      for (var j = i; j < i + gap; j++) {
        result += array[j] + ' ';
      }
      result += '\n';
    }
    return result;
  }

  List<Widget> createCriteriaList(
      List<Criteria>? campaignCriteria, double iFontSize) {
    List<Widget> criList = [];
    for (var i = 0; i < campaignCriteria!.length; i++) {
      criList.add(
        Padding(
          padding: const EdgeInsets.only(right: 5, bottom: 5),
          child: Container(
            padding: EdgeInsets.all(iFontSize * 0.6),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: white_blue),
              borderRadius: BorderRadius.circular(iFontSize * 2),
            ),
            child: Wrap(
              direction: Axis.horizontal,
              children: [
                Text(
                  campaignCriteria[i].namePost.toString(),
                  style: TextStyle(fontSize: iFontSize, color: white_blue),
                ),
                if (campaignCriteria[i].ratingPost != null &&
                    campaignCriteria[i].ratingPost != 0.0)
                  Wrap(
                    children: [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        campaignCriteria[i].ratingPost.toString(),
                        style:
                            TextStyle(fontSize: iFontSize, color: Colors.black),
                      ),
                      Icon(
                        Icons.star,
                        size: 20,
                        color: Colors.amber,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      );
    }
    return criList;
  }
}

class ImageReview extends StatelessWidget {
  ImagePost image;
  ImageReview({required this.image});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: PhotoView(
            imageProvider: NetworkImage(image.picture!.toString()),
            minScale: PhotoViewComputedScale.contained * 1,
            maxScale: 4.0,
          )),
    );
  }
}
