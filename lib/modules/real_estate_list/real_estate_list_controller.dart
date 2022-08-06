import 'package:easy_home/data/repository/real_estate_repository.dart';
import 'package:get/get.dart';

class RealEstateListController extends GetxController {
  final RealEstateRepository injectedRealEstateRepository;

  RealEstateListController({required this.injectedRealEstateRepository});
}
