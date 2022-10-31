import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp/Models/medicineModel.dart';


enum SearchBy { name, company }

class MedicineAPI {
  SearchBy? searchBy;
  //Add Medicine
  addMedicine(MedicineModel medicineModel) {
    final CollectionReference medicineCollection =
        FirebaseFirestore.instance.collection('medicines');
    medicineCollection.doc(medicineModel.medicineId).set(medicineModel.toMap());
  }

  Future<List<MedicineModel>> fetchAllMedicines() async {
    final CollectionReference medicineCollection =
        FirebaseFirestore.instance.collection('medicines');
    return medicineCollection.get().then(
      (querysnapshot) {
        //print('********${querysnapshot.docs.length}');
        List<MedicineModel> lstMedicines = [];
        for (var element in querysnapshot.docs) {
          final medicines = element.data() as Map<String, dynamic>;
          final medicineModel = MedicineModel.fromMap(medicines);
          //print('Medicine model in API $medicineModel');
          lstMedicines.add(medicineModel);
        }
        return lstMedicines;
      },
    );
  }

  Future<List<MedicineModel>?> searchMedicine(
      String? searchBy, String searchedItem) async {
    final CollectionReference medicineCollection =
        FirebaseFirestore.instance.collection('medicines');
    return medicineCollection.get().then((querysnapshot) {
      List<MedicineModel> resultMedicines = [];
      for (var element in querysnapshot.docs) {
        final medicines = element.data() as Map<String, dynamic>;
        final medicineModel = MedicineModel.fromMap(medicines);
        if (searchBy == 'Name') {
          if (medicineModel.medicineName
                  ?.toLowerCase()
                  .contains(searchedItem.toLowerCase()) ??
              false) {
            resultMedicines.add(medicineModel);
          }
        } else if (searchBy == 'Company') {
          if (medicineModel.company
                  ?.toLowerCase()
                  .contains(searchedItem.toLowerCase()) ??
              false) {
            resultMedicines.add(medicineModel);
          }
        } else if (searchBy == 'CIMS Class') {
          if (medicineModel.cimsClass
                  ?.toLowerCase()
                  .contains(searchedItem.toLowerCase()) ??
              false) {
            resultMedicines.add(medicineModel);
          }
        } else if (searchBy == 'Description') {
          if (medicineModel.description
                  ?.toLowerCase()
                  .contains(searchedItem.toLowerCase()) ??
              false) {
            resultMedicines.add(medicineModel);
          }
        }
      }
      return resultMedicines;
    });
  }

  Future editMedicine(MedicineModel newMedicineData) async {
    var medicineCollection = FirebaseFirestore.instance.collection('medicines');

    medicineCollection
        .doc(newMedicineData.medicineId)
        .update(newMedicineData.toMap());
  }

  removeMedicine(String? medId) {
    final CollectionReference medicineCollection =
        FirebaseFirestore.instance.collection('medicines');
    medicineCollection.doc(medId).delete();
  }
}
