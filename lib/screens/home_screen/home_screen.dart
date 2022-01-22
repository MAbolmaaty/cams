import 'package:cams/bloc/feed_bloc.dart';
import 'package:cams/elements/error_element.dart';
import 'package:cams/elements/loader_element.dart';
import 'package:cams/model/feed_model.dart';
import 'package:cams/model/feed_response.dart';
import 'package:cams/widgets/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    feedBloc.getFeeds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FeedResponse>(
        stream: feedBloc.Subject.stream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.error != '' && snapshot.data!.error.isNotEmpty) {
              return buildErrorWidget(snapshot.data!.error);
            }
            return _buildFeedWidget(snapshot.data);
          } else if (snapshot.hasError) {
            return buildErrorWidget("error");
          } else {
            return buildLoadingWidget();
          }
        },
      ),
    );
  }

  Widget _buildFeedWidget(FeedResponse data) {
    List<FeedModel> feeds = data.feeds;
    return PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: feeds.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                VideoWidget(url: feeds[index].videos[0].link),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withOpacity(0.15)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0, 0, 0.6, 1])),
                ),
                Positioned(
                    left: 12.0,
                    bottom: 32.0,
                    child: SafeArea(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.0, color: Colors.white),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(feeds[index].image))),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              feeds[index].user.name,
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Text(
                          feeds[index].user.url,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ))),
                Positioned(
                    right: 12.0,
                    bottom: 50,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Ionicons.heart_outline,
                              color: Colors.white,
                              size: 35.0,
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Ionicons.chatbubble_outline,
                              color: Colors.white,
                              size: 30.0,
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Ionicons.paper_plane_outline,
                              color: Colors.white,
                              size: 30.0,
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ))
              ],
            ),
          );
        });
  }
}
