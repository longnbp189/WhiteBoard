import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whiteboard_swd/components/bottom_tab.dart';
import 'package:whiteboard_swd/components/button_upload_file.dart';
import 'package:whiteboard_swd/components/chip_custom_create_post.dart';
import 'package:whiteboard_swd/components/image_picker.dart';
import 'package:whiteboard_swd/components/rating_bar.dart';
import 'package:whiteboard_swd/presenters/firebaseApi.dart';
import 'package:whiteboard_swd/views/success_create_post.dart';
import 'package:whiteboard_swd/models/campaign.dart';
import 'package:whiteboard_swd/models/criteria.dart';
import 'package:whiteboard_swd/presenters/post_request.dart';
import 'package:whiteboard_swd/utils/color.dart';

class CreatePost extends StatefulWidget {
  final Campaign campaign;
  final String reviewerId;
  final String token;
  const CreatePost(
      {Key? key,
      required this.campaign,
      required this.reviewerId,
      required this.token})
      : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  File? file;
  UploadTask? task;

  int currentStep = 0;
  bool isCompleted = false;
  int check1 = 0;
  int check21 = 1;
  int check22 = 1;
  int check23 = 0;
  int check3 = 1;
  List<Map<String, dynamic>> criteria = [];
  TextEditingController titleController = TextEditingController()..text = '';
  TextEditingController contentController = TextEditingController()..text = '';
  List<XFile>? listImage;
  List<Map<String, dynamic>> listImages = [];

  void callback(double num, String id) {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map['criterionId'] = id;
    map['rating'] = num.toInt();
    setState(() {
      // if (num > 0) {
      //   criteria.add(map);
      // } else {
      //   criteria.removeWhere((element) => element.values.contains(id));
      // }
      check1 = 1;
      if (criteria.any((element) => element.values.contains(id))) {
        criteria.removeWhere((element) => element.values.contains(id));
        criteria.add(map);
      } else {
        criteria.add(map);
      }
    });
  }

  void callbackImage(List<XFile> list) {
    setState(() {
      check3 = 1;
      listImage = list;
    });
  }

  Future uploadFile() async {
    if (listImage == null) return;
    for (int i = 0; i < listImage!.length; i++) {
      String date = DateTime.now().toString();
      final destination = 'files/post-image/$date';

      var task =
          await FirebaseApi.uploadFile(destination, File(listImage![i].path));
      String url = await task!.ref.getDownloadURL();
      Map<String, dynamic> image = new Map<String, dynamic>();
      image['image'] = url;
      setState(() {
        listImages.add(image);
      });
    }
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Tạo bài viết'),
          leading: Container(),
          actions: [
            if (!isCompleted)
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop(MaterialPageRoute(
                        builder: (context) =>
                            // CampainDetailPage(campaign: widget.campaign)

                            BottomTab()));
                  },
                  icon: Icon(Icons.close))
          ],
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: white_blue),
            ),
            child: Stepper(
                type: StepperType.horizontal,
                steps: getSteps(context),
                currentStep: currentStep,
                onStepContinue: () async {
                  if (check1 > 0 &&
                      // currentStep >= 2 ||
                      (check21 + check22) > 1 &&
                      check3 > 0) {
                    final isLastStep =
                        currentStep == getSteps(context).length - 1;
                    if (currentStep == 0) {
                      if (check23 == 0) {
                        check21 = 0;
                        check22 = 0;
                      }
                    }
                    if (currentStep == 1) {
                      check3 = 0;
                    }
                    // check1 = 0;

                    if (isLastStep) {
                      await uploadFile();
                      setState(() => isCompleted = true);
                      Map<String, dynamic> post = new Map<String, dynamic>();
                      post['title'] = titleController.text.toString();
                      post['content'] = contentController.text.toString();
                      post['criterions'] = criteria;
                      post['campaignId'] = widget.campaign.id;
                      post['reviewerId'] = widget.reviewerId;
                      post['images'] = listImages;

                      await PostRequest.createPost(post, widget.token);
                      showAlertDialog(context, 'Tạo');
                    } else {
                      setState(() => currentStep += 1);
                    }
                  }
                },
                onStepCancel: currentStep == 0
                    ? null
                    : () => setState(() {
                          // check1 = 0;
                          if (currentStep == 1) {
                            check21 = 1;
                            check22 = 1;
                          }
                          if (currentStep == 2) {
                            check3 = 1;
                          }
                          currentStep -= 1;
                        }),
                controlsBuilder: (context, details) {
                  // setState(() { //   check1 = 0;
                  // });
                  final isLastStep =
                      currentStep == getSteps(context).length - 1;
                  return Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text(
                            "Trở về",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          onPressed: details.onStepCancel,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: (check1 > 0 &&
                                // currentStep >= 2 ||
                                (check21 + check22) > 1)
                            ? (check3 > 0 || !isLastStep)
                                ? ElevatedButton(
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.5),
                                      child: Text(
                                        isLastStep ? "Hoàn tất" : "Tiếp tục",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    onPressed: details.onStepContinue,
                                  )
                                : Container(
                                    height: 37,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        'Hoàn tất',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.35),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                            : Container(
                                height: 37,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    'Tiếp tục',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.35),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                      ),
                      // if (currentStep != 0)
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  List<Step> getSteps(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return [
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: Text(""),
        content: Container(
          height: size.height - 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tiêu chí: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                direction: Axis.horizontal,
                runSpacing: 10,
                spacing: 10,
                children: getCriterial(widget.campaign.campaignCriteria!),
              ),
            ],
          ),
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: Text(""),
        content: Container(
          height: size.height - 260,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      check21 = 0;
                      return 'Độ dài tối thiểu là 6';
                    }
                    check21 = 1;
                    check23 = 1;
                    return null;
                  },
                  controller: titleController,
                  // onChanged: (value) {
                  //   titleController..text = value;
                  // },
                  onFieldSubmitted: (value) {
                    titleController..text = value;
                  },
                  decoration: InputDecoration(
                    labelText: "Tiêu đề* ",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      check22 = 0;
                      return 'Độ dài tối thiểu là 6';
                    }

                    check22 = 1;
                    check23 = 1;
                    return null;
                  },
                  controller: contentController,
                  // onChanged: (value) {
                  //   contentController..text = value;
                  // },
                  onFieldSubmitted: (value) {
                    contentController..text = value;
                  },
                  maxLines: 19,
                  decoration: InputDecoration(
                    labelText: "Nội dung* ",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: Text(""),
        content: Container(
          height: size.height - 260,
          child: Column(
            children: [
              // Container(
              //   width: size.width * 0.7,
              //   height: size.height * 0.5,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //         // image: AssetImage("assets/images/anh.png"),
              //         fit: BoxFit.fitWidth),
              //   ),
              // ),
              // ),

              Container(
                  height: 300,
                  width: 300,
                  child: ImagePickerr(
                    callBackFunc: callbackImage,
                  )),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> getCriterial(List<Criteria> criteriaList) {
    final result = <Widget>[];
    for (var i = 0; i < criteriaList.length; i++) {
      result.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // child: ChipCustom(
              //   checked: criteria.any(
              //       (element) => element.values.contains((criteriaList[i].id))),
              //   criteria: criteriaList[i],
              //   callback: this.callback,
              // ),
              child: Text(
                criteriaList[i].name.toString(),
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Rating(
              initStar: (criteria.isEmpty)
                  ? 0
                  : (criteria.any((element) =>
                          element.containsValue(criteriaList[i].id)))
                      ? criteria
                          .where((element) =>
                              element.containsValue(criteriaList[i].id))
                          .first['rating']
                      : 0,
              callback: callback,
              id: criteriaList[i].id.toString(),
            )
          ],
        ),
      );
    }
    return result;
  }
}
