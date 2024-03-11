import 'package:aijokes/controllers/chat.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class Repository {
  static Repository get instance => Get.find();

  late final ChatController chatController = Get.find();

  Repository();
}
