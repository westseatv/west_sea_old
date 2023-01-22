import 'package:get/get.dart';
import 'package:west_sea/app/bindings/home_binding.dart';
import 'package:west_sea/app/ui/pages/generator_page/generator_page.dart';
import 'package:west_sea/app/ui/pages/home_page/home_page.dart';
import '../bindings/generator_binding.dart';
import 'routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.generator,
      page: () => const GeneratorPage(),
      binding: GeneratorBinding(),
    ),
  ];
}
