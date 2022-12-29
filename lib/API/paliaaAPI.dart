import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sdp/Models/vaktaModel.dart';

enum SearchBy { name, company }

class PaliaAPI {
  SearchBy? searchBy;
  //Add Palia
  addUser(VaktaModel addvakta) async {
    final CollectionReference userCollection =
        FirebaseFirestore.instance.collection('paliaList');
    await userCollection.doc(addvakta.docId).set(addvakta.toMap());
  }

//FetchUser
  Future<List<VaktaModel>> fetchAllPalias() async {
    try {
      return FirebaseFirestore.instance.collection('paliaList').get().then(
        (querysnapshot) {
          //print('********${querysnapshot.docs.length}');
          List<VaktaModel> lstPalias = [];
          for (var element in querysnapshot.docs) {
            final PaliaData = element.data() as Map<String, dynamic>;
            final devoteModel = VaktaModel.fromMap(PaliaData);
            print('Medicine model in API $devoteModel');
            lstPalias.add(devoteModel);
          }
          lstPalias.sort(
            (a, b) {
              return b.createdOn.toString().compareTo(a.createdOn.toString());
            },
          );
          return lstPalias;
        },
      );
      // return lstPalia;
    } catch (e) {
      print(e);
    }
    return [];
  }

// search user
  Future<List<VaktaModel>?> searchSDP(
      String? searchBy, String searchedItem, String? searchsanghaname) async {
    final CollectionReference PaliaCollection =
        FirebaseFirestore.instance.collection('paliaList');
    return PaliaCollection.get().then((querysnapshot) {
      List<VaktaModel> result = [];
      for (var element in querysnapshot.docs) {
        final Palia = element.data() as Map<String, dynamic>;
        final vaktaDetails = VaktaModel.fromMap(Palia);
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
        } else if (searchBy == 'Pali Date') {
          if (vaktaDetails.paaliDate?.contains(searchedItem) ?? false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'Sammilani Number') {
          if (vaktaDetails.sammilaniData?.sammilaniNumber
                  ?.contains(searchedItem) ??
              false) {
            if (searchsanghaname != null && searchsanghaname != '') {
              if ((vaktaDetails.sammilaniData?.sammilaniNumber
                          ?.contains(searchedItem) ??
                      false) &&
                  (vaktaDetails.sangha?.contains(searchsanghaname) ?? false)) {
                result.add(vaktaDetails);
                print('*******$result');
              }
            } else {
              result.add(vaktaDetails);
            }
          }
        } else if (searchBy == 'Sammilani Year') {
          if (vaktaDetails.sammilaniData?.sammilaniYear
                  ?.contains(searchedItem) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'Sammilani Place') {
          if (vaktaDetails.sammilaniData?.sammilaniPlace
                  ?.contains(searchedItem) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'Receipt Date') {
          if (vaktaDetails.receiptDate?.contains(searchedItem) ?? false) {
            result.add(vaktaDetails);
          }
        } else if (searchBy == 'Receipt Number') {
          if (vaktaDetails.receiptNo?.contains(searchedItem) ?? false) {
            result.add(vaktaDetails);
          }
        }
      }
      return result;
    });
  }

  Future editPaliaDetails(VaktaModel paliaDetails) async {
    var medicineCollection = FirebaseFirestore.instance.collection('paliaList');

    medicineCollection.doc(paliaDetails.docId).update(paliaDetails.toMap());
  }

  removePalia(String? docId) {
    final CollectionReference medicineCollection =
        FirebaseFirestore.instance.collection('paliaList');
    medicineCollection.doc(docId).delete();
  }

  //Multiple Search
  // search user
//   Future<List<VaktaModel>?>? multipleSearchSDP(
//       String? name,
//       String? sangha,
//       String? paliDate,
//       String? sammilaninumber,
//       String? sammilaniyear,
//       String? sammilaniplace,
//       String? receiptDate,
//       String? receitNumber) async {
//     //firebase fetch
//     final CollectionReference PaliaCollection =
//         FirebaseFirestore.instance.collection('paliaList');
//     final searchResult = await PaliaCollection.get().then((querysnapshot) {
//       List<VaktaModel> result = [];
//       for (var element in querysnapshot.docs) {
//         final Palia = element.data() as Map<String, dynamic>;
//         //Getting all Palia in list
//         final vaktaDetails = VaktaModel.fromMap(Palia);
// //condition

//       }
//     });
//   }
}
