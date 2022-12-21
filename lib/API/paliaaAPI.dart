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
      String? searchBy, String searchedItem) async {
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
            result.add(vaktaDetails);
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

  Future editPaliaDetails(VaktaModel Palia) async {
    var medicineCollection = FirebaseFirestore.instance.collection('paliaList');

    medicineCollection.doc(Palia.docId).update(Palia.toMap());
  }

  removePalia(String? docId) {
    final CollectionReference medicineCollection =
        FirebaseFirestore.instance.collection('paliaList');
    medicineCollection.doc(docId).delete();
  }

  //Multiple Search
  // search user
  Future<List<VaktaModel>?>? multipleSearchSDP(
      String? name,
      String? sangha,
      String? paliDate,
      String? sammilaninumber,
      String? sammilaniyear,
      String? sammilaniplace,
      String? receiptDate,
      String? receitNumber) async {
    //firebase fetch
    final CollectionReference PaliaCollection =
        FirebaseFirestore.instance.collection('paliaList');
    final searchResult = await PaliaCollection.get().then((querysnapshot) {
      List<VaktaModel> result = [];
      for (var element in querysnapshot.docs) {
        final Palia = element.data() as Map<String, dynamic>;
        //Getting all Palia in list
        final vaktaDetails = VaktaModel.fromMap(Palia);
//condition
//Name
        if (name != "" && name != null) {
          if (vaktaDetails.name?.toLowerCase().contains(name.toLowerCase()) ??
              false) {
            // Name & Sangha
            if (sangha != null && sangha != "") {
              if ((vaktaDetails.sangha
                          ?.toLowerCase()
                          .contains(sangha.toLowerCase()) ??
                      false) &&
                  (vaktaDetails.name
                          ?.toLowerCase()
                          .contains(name.toLowerCase()) ??
                      false)) {
                // Name & Sangha & Palia Date
                if (paliDate != null && paliDate != "") {
                  if ((vaktaDetails.name
                              ?.toLowerCase()
                              .contains(name.toLowerCase()) ??
                          false) &&
                      (vaktaDetails.sangha
                              ?.toLowerCase()
                              .contains(sangha.toLowerCase()) ??
                          false) &&
                      (vaktaDetails.paaliDate
                              ?.toLowerCase()
                              .contains(paliDate.toLowerCase()) ??
                          false)) {
                    // Name & Sangha & Palia Date & sammilani number
                    if (sammilaninumber != null && sammilaninumber != "") {
                      if ((vaktaDetails.name
                                  ?.toLowerCase()
                                  .contains(name.toLowerCase()) ??
                              false) &&
                          (vaktaDetails.sangha
                                  ?.toLowerCase()
                                  .contains(sangha.toLowerCase()) ??
                              false) &&
                          (vaktaDetails.paaliDate
                                  ?.toLowerCase()
                                  .contains(paliDate.toLowerCase()) ??
                              false) &&
                          (vaktaDetails.sammilaniData?.sammilaniNumber
                                  ?.toLowerCase()
                                  .contains(sammilaninumber.toLowerCase()) ??
                              false)) {
                        // Name & Sangha & Palia Date & sammilani number & Sammilani year
                        if (sammilaniyear != null && sammilaniyear != "") {
                          if ((vaktaDetails.name
                                      ?.toLowerCase()
                                      .contains(name.toLowerCase()) ??
                                  false) &&
                              (vaktaDetails.sangha
                                      ?.toLowerCase()
                                      .contains(sangha.toLowerCase()) ??
                                  false) &&
                              (vaktaDetails.paaliDate
                                      ?.toLowerCase()
                                      .contains(paliDate.toLowerCase()) ??
                                  false) &&
                              (vaktaDetails.sammilaniData?.sammilaniNumber
                                      ?.toLowerCase()
                                      .contains(
                                          sammilaninumber.toLowerCase()) ??
                                  false) &&
                              (vaktaDetails.sammilaniData?.sammilaniYear
                                      ?.toLowerCase()
                                      .contains(sammilaniyear.toLowerCase()) ??
                                  false)) {
                            if (sammilaniplace != null &&
                                sammilaniplace != "") {
                              if ((vaktaDetails.name
                                          ?.toLowerCase()
                                          .contains(name.toLowerCase()) ??
                                      false) &&
                                  (vaktaDetails.sangha
                                          ?.toLowerCase()
                                          .contains(sangha.toLowerCase()) ??
                                      false) &&
                                  (vaktaDetails.paaliDate
                                          ?.toLowerCase()
                                          .contains(paliDate.toLowerCase()) ??
                                      false) &&
                                  (vaktaDetails.sammilaniData?.sammilaniNumber
                                          ?.toLowerCase()
                                          .contains(
                                              sammilaninumber.toLowerCase()) ??
                                      false) &&
                                  (vaktaDetails.sammilaniData?.sammilaniYear
                                          ?.toLowerCase()
                                          .contains(
                                              sammilaniyear.toLowerCase()) ??
                                      false) &&
                                  (vaktaDetails.sammilaniData?.sammilaniPlace
                                          ?.toLowerCase()
                                          .contains(
                                              sammilaniplace.toLowerCase()) ??
                                      false)) {
                                if (receiptDate != null && receiptDate != "") {
                                  if ((vaktaDetails.name
                                              ?.toLowerCase()
                                              .contains(name.toLowerCase()) ??
                                          false) &&
                                      (vaktaDetails.sangha
                                              ?.toLowerCase()
                                              .contains(sangha.toLowerCase()) ??
                                          false) &&
                                      (vaktaDetails.paaliDate?.toLowerCase().contains(
                                              paliDate.toLowerCase()) ??
                                          false) &&
                                      (vaktaDetails.sammilaniData?.sammilaniNumber?.toLowerCase().contains(
                                              sammilaninumber.toLowerCase()) ??
                                          false) &&
                                      (vaktaDetails.sammilaniData?.sammilaniYear
                                              ?.toLowerCase()
                                              .contains(sammilaniyear
                                                  .toLowerCase()) ??
                                          false) &&
                                      (vaktaDetails.sammilaniData?.sammilaniPlace
                                              ?.toLowerCase()
                                              .contains(sammilaniplace.toLowerCase()) ??
                                          false) &&
                                      (vaktaDetails.receiptDate?.toLowerCase().contains(receiptDate.toLowerCase()) ?? false)) {
                                    if (receitNumber != null &&
                                        receitNumber != "") {
                                      if ((vaktaDetails.name?.toLowerCase().contains(name.toLowerCase()) ?? false) &&
                                          (vaktaDetails.sangha?.toLowerCase().contains(sangha.toLowerCase()) ??
                                              false) &&
                                          (vaktaDetails.paaliDate
                                                  ?.toLowerCase()
                                                  .contains(
                                                      paliDate.toLowerCase()) ??
                                              false) &&
                                          (vaktaDetails.sammilaniData
                                                  ?.sammilaniNumber
                                                  ?.toLowerCase()
                                                  .contains(sammilaninumber
                                                      .toLowerCase()) ??
                                              false) &&
                                          (vaktaDetails.sammilaniData?.sammilaniYear
                                                  ?.toLowerCase()
                                                  .contains(sammilaniyear
                                                      .toLowerCase()) ??
                                              false) &&
                                          (vaktaDetails.sammilaniData?.sammilaniPlace
                                                  ?.toLowerCase()
                                                  .contains(sammilaniplace.toLowerCase()) ??
                                              false) &&
                                          (vaktaDetails.receiptDate?.toLowerCase().contains(receiptDate.toLowerCase()) ?? false) &&
                                          (vaktaDetails.receiptNo?.toLowerCase().contains(receitNumber.toLowerCase()) ?? false)) {
                                        return result.add(vaktaDetails);
                                      }
                                    }

                                    return result.add(vaktaDetails);
                                  }
                                }

                                return result.add(vaktaDetails);
                              }
                            }

                            return result.add(vaktaDetails);
                          }
                        }

                        return result.add(vaktaDetails);
                      }
                    }

                    return result.add(vaktaDetails);
                  }
                }

                return result.add(vaktaDetails);
              }
            }

            // return result.add(vaktaDetails);
          }
        } else if (sangha != null) {
          if (vaktaDetails.sangha
                  ?.toLowerCase()
                  .contains(sangha.toLowerCase()) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (paliDate != null) {
          if (vaktaDetails.paaliDate?.contains(paliDate) ?? false) {
            result.add(vaktaDetails);
          }
        } else if (sammilaninumber != null) {
          if (vaktaDetails.sammilaniData?.sammilaniNumber
                  ?.contains(sammilaninumber) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (sammilaniyear != null) {
          if (vaktaDetails.sammilaniData?.sammilaniYear
                  ?.contains(sammilaniyear) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (sammilaniplace != null) {
          if (vaktaDetails.sammilaniData?.sammilaniPlace
                  ?.contains(sammilaniplace) ??
              false) {
            result.add(vaktaDetails);
          }
        } else if (receiptDate != null) {
          if (vaktaDetails.receiptDate?.contains(receiptDate) ?? false) {
            result.add(vaktaDetails);
          }
        } else if (receitNumber != null) {
          if (vaktaDetails.receiptNo?.contains(receitNumber) ?? false) {
            result.add(vaktaDetails);
          }
        }
      }
    });
  }
}
