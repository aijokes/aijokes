import 'package:aijokes/app/repository.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/chat.dart';

void injectDependencies (){
  Get.put(ChatController());

  Get.put(Repository(), permanent: true);
}