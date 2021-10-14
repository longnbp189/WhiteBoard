import 'package:flutter/material.dart';
import 'package:whiteboard_swd/components/slider_image.dart';
import 'package:whiteboard_swd/models/campaign.dart';
import 'package:whiteboard_swd/models/criteria.dart';
import 'package:whiteboard_swd/models/post.dart';
import 'package:whiteboard_swd/presenters/post_request.dart';
import 'package:whiteboard_swd/utils/color.dart';
import 'package:whiteboard_swd/views/post_details.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Bài viết',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 18),
        ),
      ),
      body: SafeArea(
          child: Container(
        child: FutureBuilder<List<Post>?>(
            future: PostRequest.getPostList(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Container(
                  color: white_blue_white,
                  child: Center(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 12),
                            child: PostItem(post: snapshot.data![index]),
                          );
                        }),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      )),
    );
  }
}

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      // splashColor: dart_blue,
      highlightColor: white_blue_white,
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => PostDetail()));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: size.width - 2 * 10,
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.7), //color of shadow
          //     spreadRadius: 3, //spread radius
          //     blurRadius: 7, // blur radius
          //     offset: Offset(0, 2), // changes position of shadow
          //     //first paramerter of offset is left-right
          //     //second parameter is top to down
          //   ),
          //   //you can set more BoxShadow() here
          // ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: Column(children: [
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
                    post.reviewerName.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    post.universityName.toString() +
                        " - " +
                        post.campusName.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
              Text(
                post.title.toString(),
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                post.content.toString(),
                style: TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 2,
                runSpacing: 2,
                direction: Axis.horizontal,
                children: criteriaList(post.postCriteria!),
              ),
              SizedBox(
                height: 10,
              ),
              if (post.imagePost!.length > 1)
                Center(child: SlideImage(imageUrl: post.imagePost)),
              if (post.imagePost!.length == 1)
                Center(
                  child: Image(
                      height: size.height * 0.3,
                      image:
                          NetworkImage(post.imagePost![0].picture.toString()),
                      fit: BoxFit.cover),
                ),
              if (post.imagePost == null || post.imagePost!.length == 0)
                SizedBox(),
              SizedBox(
                height: 15,
              ),
            ],
          )
        ]),
      ),
    );
  }

  List<Widget> criteriaList(List<Criteria>? campaignCriteria) {
    List<Widget> criList = [];
    for (var i = 0; i < campaignCriteria!.length; i++) {
      criList.add(
        Padding(
          padding: const EdgeInsets.only(right: 5, bottom: 5),
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              border: Border.all(width: 1),
            ),
            child: Text(
              campaignCriteria[i].namePost.toString(),
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      );
    }
    return criList;
  }
}
