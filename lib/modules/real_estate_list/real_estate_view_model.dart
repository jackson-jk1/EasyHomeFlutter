import 'package:get/get.dart';
import '../../data/model/polo_model.dart';
import '../../data/repository/real_estate_repository.dart';

class RealEstateViewModel extends GetxController {
  final RealEstateRepository injectedPoloModel;

  RealEstateViewModel({required this.injectedPoloModel});

  Future<List<PoloModel>> takeFromApi() async {
    return injectedPoloModel.getPolos();
  }

}