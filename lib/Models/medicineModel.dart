import 'dart:convert';

import 'package:flutter/material.dart';

class MedicineModel {
  final String? medicineName;
  final String? medicineType;
  final String? medicineId;
  final String? genericName;
  final String? cimsClass;
  final String? actClassification;
  final String? packing;
  final String? form;
  final String? contents;
  final String? company;
  final int? tabsPerStrip;
  final double? price;
  final DateTime? mfgDate;
  final DateTime? expDate;
  final DateTime? addedOn;
  final DateTime? updatedOn;
  final String? addedBy;
  final String? updatedBy;
  final String? medicineImageURL;
  final String? description;
  final Widget? edit;
  final Widget? delete;

  MedicineModel({
    this.medicineName,
    this.medicineType,
    this.medicineId,
    this.genericName,
    this.cimsClass,
    this.actClassification,
    this.packing,
    this.form,
    this.contents,
    this.company,
    this.tabsPerStrip,
    this.price,
    this.mfgDate,
    this.expDate,
    this.addedOn,
    this.updatedOn,
    this.addedBy,
    this.updatedBy,
    this.medicineImageURL,
    this.description,
    this.edit,
    this.delete,
  });

  MedicineModel copyWith({
    String? medicineName,
    String? medicineType,
    String? medicineId,
    String? genericName,
    String? cimsClass,
    String? actClassification,
    String? packing,
    String? form,
    String? contents,
    String? company,
    int? tabsPerStrip,
    double? price,
    DateTime? mfgDate,
    DateTime? expDate,
    DateTime? addedOn,
    DateTime? updatedOn,
    String? addedBy,
    String? updatedBy,
    String? medicineImageURL,
    String? description,
    Widget? edit,
    Widget? delete,
  }) {
    return MedicineModel(
      medicineName: medicineName ?? this.medicineName,
      medicineType: medicineType ?? this.medicineType,
      medicineId: medicineId ?? this.medicineId,
      genericName: genericName ?? this.genericName,
      cimsClass: cimsClass ?? this.cimsClass,
      actClassification: actClassification ?? this.actClassification,
      packing: packing ?? this.packing,
      form: form ?? this.form,
      contents: contents ?? this.contents,
      company: company ?? this.company,
      tabsPerStrip: tabsPerStrip ?? this.tabsPerStrip,
      price: price ?? this.price,
      mfgDate: mfgDate ?? this.mfgDate,
      expDate: expDate ?? this.expDate,
      addedOn: addedOn ?? this.addedOn,
      updatedOn: updatedOn ?? this.updatedOn,
      addedBy: addedBy ?? this.addedBy,
      updatedBy: updatedBy ?? this.updatedBy,
      medicineImageURL: medicineImageURL ?? this.medicineImageURL,
      description: description ?? this.description,
      edit: edit ?? this.edit,
      delete: delete ?? this.delete,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'medicineName': medicineName,
      'medicineType': medicineType,
      'medicineId': medicineId,
      'genericName': genericName,
      'cimsClass': cimsClass,
      'actClassification': actClassification,
      'packing': packing,
      'form': form,
      'contents': contents,
      'company': company,
      'tabsPerStrip': tabsPerStrip,
      'price': price,
      'mfgDate': mfgDate?.millisecondsSinceEpoch,
      'expDate': expDate?.millisecondsSinceEpoch,
      'addedOn': addedOn?.millisecondsSinceEpoch,
      'updatedOn': updatedOn?.millisecondsSinceEpoch,
      'addedBy': addedBy,
      'updatedBy': updatedBy,
      'medicineImageURL': medicineImageURL,
      'description': description,
      'edit': edit,
      'delete': delete,
    };
  }

  factory MedicineModel.fromMap(Map<String, dynamic> map) {
    return MedicineModel(
      medicineName: map['medicineName'],
      medicineType: map['medicineType'],
      medicineId: map['medicineId'],
      genericName: map['genericName'],
      cimsClass: map['cimsClass'],
      actClassification: map['actClassification'],
      packing: map['packing'],
      form: map['form'],
      contents: map['contents'],
      company: map['company'],
      tabsPerStrip: map['tabsPerStrip']?.toInt(),
      price: map['price']?.toDouble(),
      mfgDate: map['mfgDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['mfgDate'])
          : DateTime.tryParse(''),
      expDate: map['expDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expDate'])
          : DateTime.tryParse(''),
      addedOn: map['addedOn'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['addedOn'])
          : null,
      updatedOn: map['updatedOn'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedOn'])
          : null,
      addedBy: map['addedBy'],
      updatedBy: map['updatedBy'],
      medicineImageURL: map['medicineImageURL'],
      description: map['description'],
      edit: map['edit'],
      delete: map['delete'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MedicineModel.fromJson(String source) =>
      MedicineModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MedicineModel(medicineName: $medicineName, medicineType: $medicineType, medicineId: $medicineId, genericName: $genericName, cimsClass: $cimsClass, actClassification: $actClassification, packing: $packing, form: $form, contents: $contents, company: $company, tabsPerStrip: $tabsPerStrip, price: $price, mfgDate: $mfgDate, expDate: $expDate, addedOn: $addedOn, updatedOn: $updatedOn, addedBy: $addedBy, updatedBy: $updatedBy, medicineImageURL: $medicineImageURL, description: $description, edit: $edit, delete: $delete)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MedicineModel &&
        other.medicineName == medicineName &&
        other.medicineType == medicineType &&
        other.medicineId == medicineId &&
        other.genericName == genericName &&
        other.cimsClass == cimsClass &&
        other.actClassification == actClassification &&
        other.packing == packing &&
        other.form == form &&
        other.contents == contents &&
        other.company == company &&
        other.tabsPerStrip == tabsPerStrip &&
        other.price == price &&
        other.mfgDate == mfgDate &&
        other.expDate == expDate &&
        other.addedOn == addedOn &&
        other.updatedOn == updatedOn &&
        other.addedBy == addedBy &&
        other.updatedBy == updatedBy &&
        other.medicineImageURL == medicineImageURL &&
        other.description == description &&
        other.edit == edit &&
        other.delete == delete;
  }

  @override
  int get hashCode {
    return medicineName.hashCode ^
        medicineType.hashCode ^
        medicineId.hashCode ^
        genericName.hashCode ^
        cimsClass.hashCode ^
        actClassification.hashCode ^
        packing.hashCode ^
        form.hashCode ^
        contents.hashCode ^
        company.hashCode ^
        tabsPerStrip.hashCode ^
        price.hashCode ^
        mfgDate.hashCode ^
        expDate.hashCode ^
        addedOn.hashCode ^
        updatedOn.hashCode ^
        addedBy.hashCode ^
        updatedBy.hashCode ^
        medicineImageURL.hashCode ^
        description.hashCode ^
        edit.hashCode ^
        delete.hashCode;
  }
}
