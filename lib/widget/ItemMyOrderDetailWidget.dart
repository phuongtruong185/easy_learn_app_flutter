import 'package:easy_learn_app/views/myOrderPage/myCourseDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:easy_learn_app/net/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class ItemMyOrderDetailWidget extends StatefulWidget {
  final String courseId;

  const ItemMyOrderDetailWidget({Key? key, required this.courseId})
      : super(key: key);

  @override
  _ItemMyOrderDetailWidgetState createState() =>
      _ItemMyOrderDetailWidgetState();
}

class _ItemMyOrderDetailWidgetState extends State<ItemMyOrderDetailWidget> {
  List<dynamic> listVideo = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String access_token = prefs.getString('access_token')!;
      access_token = access_token.replaceAll('"', '');
      var response =
          await API.get('/videoCourse/course/${widget.courseId}', headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $access_token'
      });
      setState(() {
        listVideo = response['data'];
        isLoading = false;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    } else if (listVideo.isNotEmpty) {
      return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                listVideo[index]['isExpanded'] = !isExpanded;
              });
            },
            children: listVideo
                .map<ExpansionPanel>((dynamic video) => ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        print(video['video']['link']);

                        return ListTile(
                          title: Text(video['name'] + ' : ' + video['title']),
                        );
                      },
                      body: Column(
                        children: [
                          SizedBox(
                            height: 250,
                            child: VideoPlayerWidget(
                                videoUrl: video['video']['link'] ?? ''),
                          ),
                          ListTile(
                            title: Text(video['description']),
                          ),
                        ],
                      ),
                      isExpanded: video['isExpanded'] ?? false,
                    ))
                .toList(),
          ));
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: const [
          Image(
            image: AssetImage('lib/assets/images/empty.png'),
            height: 200,
            width: 200,
          ),
          SizedBox(height: 30),
          Text('Chưa có khóa học nào',
              style: TextStyle(
                  color: Color(0xFF4C53A5),
                  fontSize: 20,
                  fontWeight: FontWeight.bold))
        ],
      );
    }
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          VideoPlayer(_controller),
          VideoProgressIndicator(_controller, allowScrubbing: true),
          Positioned(
            bottom: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
