import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp/Models/vaktaModel.dart';

enum SearchBy { name, company }

class DevoteeAPI {
  SearchBy? searchBy;
  //Add Devotee
  addUser(VaktaModel addvakta) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('devoteeList');
    await userCollection.doc(addvakta.docId).set(addvakta.toMap());
  }

//FetchUser
  Future<List<VaktaModel>> fetchAllDevotees() async {
    final CollectionReference devoteeCollection =
        FirebaseFirestore.instance.collection('devoteeList');
    final lstdevotee = await devoteeCollection.get().then(
      (querysnapshot) {
        //print('********${querysnapshot.docs.length}');
        List<VaktaModel> lstDevotees = [];
        for (var element in querysnapshot.docs) {
          final devoteeData = element.data() as Map<String, dynamic>;
          final devoteModel = VaktaModel.fromMap(devoteeData);
          print('Medicine model in API $devoteModel');
          lstDevotees.add(devoteModel);
        }
        return lstDevotees;
      },
    );
    return lstdevotee;
  }

// search user
  Future<List<VaktaModel>?> searchSDP(
      String? searchBy, String searchedItem) async {
    final CollectionReference devoteeCollection =
        FirebaseFirestore.instance.collection('devoteeList');
    return devoteeCollection.get().then((querysnapshot) {
      List<VaktaModel> result = [];
      for (var element in querysnapshot.docs) {
        final devotee = element.data() as Map<String, dynamic>;
        final vaktaDetails = VaktaModel.fromMap(devotee);
        if (searchBy == 'Name') {
          if (vaktaDetails.name
                  ?.toLowerCase()
                  .contains(searchedItem.toLowerCase()) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'Sangha') {
          if (vaktaDetails.sangha
                  ?.toLowerCase()
                  .contains(searchedItem.toLowerCase()) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'PaaliDate') {
          if (vaktaDetails.paaliDate?.contains(searchedItem.toLowerCase()) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'Devotee') {
          if (vaktaDetails.name
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

  Future editDevoteeDetails(VaktaModel devotee) async {
    var medicineCollection =
        FirebaseFirestore.instance.collection('devoteeList');

    medicineCollection.doc(devotee.docId).update(devotee.toMap());
  }

  removeDevotee(String? docId) {
    final CollectionReference medicineCollection =
        FirebaseFirestore.instance.collection('devoteeList');
    medicineCollection.doc(docId).delete();
  }
}
