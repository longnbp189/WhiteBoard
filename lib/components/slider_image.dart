import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:whiteboard_swd/models/image_post.dart';

class SlideImage extends StatefulWidget {
  final List<ImagePost>? imageUrl;
  const SlideImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _SlideImageState createState() => _SlideImageState();
}

class _SlideImageState extends State<SlideImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider.builder(
        itemCount: widget.imageUrl!.length,
        itemBuilder: (context, index, realIndex) {
          final urlImage = widget.imageUrl![index];
          return buildImage(urlImage.picture!, index);
        },
        options: CarouselOptions(
            height: 250,
            viewportFraction: 1,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            autoPlay: true,
            // reverse: true,
            autoPlayInterval: Duration(seconds: 3)),
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
}

class SlideImage1 extends StatefulWidget {
  final List<String>? imageUrl;
  const SlideImage1({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _SlideImageState1 createState() => _SlideImageState1();
}

class _SlideImageState1 extends State<SlideImage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: CarouselSlider.builder(
      itemCount: widget.imageUrl!.length,
      itemBuilder: (context, index, realIndex) {
        final urlImage = widget.imageUrl![index];
        return buildImage(urlImage, index);
      },
      options: CarouselOptions(
        height: 250,
        viewportFraction: 1,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
        // autoPlay: true,
        // reverse: true,
        // autoPlayInterval: Duration(seconds: 3)),
      ),
    ));
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
}
