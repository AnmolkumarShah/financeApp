import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

class Loader {
  static Widget circular = const Center(
    child: CircularProgressIndicator(),
  );

  static Widget linear = const Center(
    child: LinearProgressIndicator(),
  );

  static Widget shimmer = const Center(
    child: MyShimmer(),
  );
}

class MyShimmer extends StatelessWidget {
  const MyShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "ListTileShimmer ( onlyWithProfilePicture:true )",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          children: const [
            ListTileShimmer(
              bgColor: Colors.yellow,
              onlyShowProfilePicture: true,
              // isRectBox: true,
              height: 20,
              // isPurplishMode: true,
            ),
          ],
        ),
        const Divider(),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "ListTileShimmer",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const ListTileShimmer(
          bgColor: Colors.pink,

          height: 20,
          // isPurplishMode: true,
        ),
        const Divider(),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "YoutubeShimmer",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const YoutubeShimmer(
            // isPurplishMode: true,
            // isDarkMode: true,
            ),
        const Divider(),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "VideoShimmer",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const VideoShimmer(
            // isPurplishMode: true,
            // isDarkMode: true,
            ),
        const Divider(),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "ProfileShimmer",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const ProfileShimmer(
          // isPurplishMode: true,
          // isDarkMode: true,
          hasCustomColors: true,
          colors: [Color(0xFF651fff), Color(0xFF834bff), Color(0xFF4615b2)],
        ),
        const Divider(),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "YoutubeShimmer(With Bottom Lines)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const ProfileShimmer(
          // isPurplishMode: true,
          hasBottomLines: true,
          // isDarkMode: true,
        ),
        const Divider(),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "ProfilePageShimmer",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const ProfilePageShimmer(),
        const Divider(),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "ProfilePageShimmer(With Bottom Box)",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const ProfilePageShimmer(
          // isPurplishMode: true,
          hasBottomBox: true,
          // isDarkMode: true,
        ),
      ],
    );
  }
}
