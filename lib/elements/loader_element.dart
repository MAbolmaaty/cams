import 'package:flutter/cupertino.dart';

Widget buildLoadingWidget() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CupertinoActivityIndicator(),
        )
      ],
    ),
  );
}
