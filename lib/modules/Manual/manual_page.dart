import 'package:native_video_view/native_video_view.dart';
import 'package:easy_home/modules/Dev_data/dev_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_home/theme/AppColors.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../menu_layout.dart';

class ManualPage extends StatelessWidget {
  const ManualPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuDashboardPage(),
      appBar: AppBar(
        title: const Text('Manual do Usuário'),
        backgroundColor: AppColors.background,
      ),
      backgroundColor: AppColors.background,
      body: Container(
        child: NativeVideoView(
          keepAspectRatio: true,
          showMediaController: true,
          onCreated: (controller) {
            controller.setVideoSource(
              'https://www.youtube.com/watch?v=U9uJRKcAlUk',
              sourceType: VideoSourceType.network,
            );
          },
          onPrepared: (controller, info) {
            controller.play();
          },
          onError: (controller, what, extra, message) {
            print('Player Error ($what | $extra | $message)');
          },
          onCompletion: (controller) {
            print('Video completed');
          },
          onProgress: (progress, duration) {
            print('$progress | $duration');
          },
        ),
      ),
    );
  }

}
