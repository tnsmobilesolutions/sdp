import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp/Models/vaktaModel.dart';

enum SearchBy { name, company }

class MedicineAPI {
  SearchBy? searchBy;
  //Add Medicine
  addMedicine(VaktaModel vakta) {
    final CollectionReference medicineCollection =
        FirebaseFirestore.instance.collection('medicines');
    medicineCollection.doc(vakta.userId).set(vakta.toMap());
  }

  Future<List<VaktaModel>> fetchAllMedicines() async {
    final CollectionReference medicineCollection =
        FirebaseFirestore.instance.collection('medicines');
    return medicineCollection.get().then(
      (querysnapshot) {
        //print('********${querysnapshot.docs.length}');
        List<VaktaModel> lstMedicines = [];
        for (var element in querysnapshot.docs) {
          final medicines = element.data() as Map<String, dynamic>;
          final medicineModel = VaktaModel.fromMap(medicines);
          //print('Medicine model in API $medicineModel');
          lstMedicines.add(medicineModel);
        }
        return lstMedicines;
      },
    );
  }

  Future<List<VaktaModel>?> searchSDP(
      String? searchBy, String searchedItem) async {
    final CollectionReference medicineCollection =
        FirebaseFirestore.instance.collection('medicines');
    return medicineCollection.get().then((querysnapshot) {
      List<VaktaModel> result = [];
      for (var element in querysnapshot.docs) {
        final medicines = element.data() as Map<String, dynamic>;
        final vaktaDetails = VaktaModel.fromMap(medicines);
        if (searchBy == 'Name') {
          if (vaktaDetails.devoteeName
                  ?.toLowerCase()
                  .contains(searchedItem.toLowerCase()) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'Date') {
          if (vaktaDetails.sangha
                  ?.toLowerCase()
                  .contains(searchedItem.toLowerCase()) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'Sangha') {
          if (vaktaDetails.sangha?.contains(searchedItem.toLowerCase()) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'Devotee') {
          if (vaktaDetails.devoteeName
                  ?.toLowerCase()
                  .contains(searchedItem.toLowerCase()) ??
              false) {
            result.add(vaktaDetails);
          }
        }
      }
      return result;
    });
  }

  Future editMedicine(VaktaModel newMedicineData) async {
    var medicineCollection = FirebaseFirestore.instance.collection('medicines');

    medicineCollection
        .doc(newMedicineData.userId)
        .update(newMedicineData.toMap());
  }

  removeMedicine(String? medId) {
    final CollectionReference medicineCollection =
        FirebaseFirestore.instance.collection('medicines');
    medicineCollection.doc(medId).delete();
  }
}
