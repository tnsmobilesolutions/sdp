import 'dart:convert';

import 'package:flutter/material.dart';

class VaktaModel {
  String? userId;
  String? devoteeName;
  String? sangha;
  String? paaliDate;
  String? sammilaniNo;
  String? sammilaniYear;
  String? pranaami;
  String? remark;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  VaktaModel({
    this.userId,
    this.devoteeName,
    this.sangha,
    this.paaliDate,
    this.sammilaniNo,
    this.sammilaniYear,
    this.pranaami,
    this.remark,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  VaktaModel copyWith({
    String? userId,
    String? devoteeName,
    String? sangha,
    String? paaliDate,
    String? sammilaniNo,
    String? sammilaniYear,
    String? pranaami,
    String? remark,
    String? createdBy,
    String? createdOn,
    String? updatedBy,
    String? updatedOn,
  }) {
    return VaktaModel(
      userId: userId ?? this.userId,
      devoteeName: devoteeName ?? this.devoteeName,
      sangha: sangha ?? this.sangha,
      paaliDate: paaliDate ?? this.paaliDate,
      sammilaniNo: sammilaniNo ?? this.sammilaniNo,
      sammilaniYear: sammilaniYear ?? this.sammilaniYear,
      pranaami: pranaami ?? this.pranaami,
      remark: remark ?? this.remark,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedOn: updatedOn ?? this.updatedOn,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (userId != null) {
      result.addAll({'userId': userId});
    }
    if (devoteeName != null) {
      result.addAll({'devoteeName': devoteeName});
    }
    if (sangha != null) {
      result.addAll({'sangha': sangha});
    }
    if (paaliDate != null) {
      result.addAll({'paaliDate': paaliDate});
    }
    if (sammilaniNo != null) {
      result.addAll({'sammilaniNo': sammilaniNo});
    }
    if (sammilaniYear != null) {
      result.addAll({'sammilaniYear': sammilaniYear});
    }
    if (pranaami != null) {
      result.addAll({'pranaami': pranaami});
    }
    if (remark != null) {
      result.addAll({'remark': remark});
    }
    if (createdBy != null) {
      result.addAll({'createdBy': createdBy});
    }
    if (createdOn != null) {
      result.addAll({'createdOn': createdOn});
    }
    if (updatedBy != null) {
      result.addAll({'updatedBy': updatedBy});
    }
    if (updatedOn != null) {
      result.addAll({'updatedOn': updatedOn});
    }

    return result;
  }

  factory VaktaModel.fromMap(Map<String, dynamic> map) {
    return VaktaModel(
      userId: map['userId'],
      devoteeName: map['devoteeName'],
      sangha: map['sangha'],
      paaliDate: map['paaliDate'],
      sammilaniNo: map['sammilaniNo'],
      sammilaniYear: map['sammilaniYear'],
      pranaami: map['pranaami'],
      remark: map['remark'],
      createdBy: map['createdBy'],
      createdOn: map['createdOn'],
      updatedBy: map['updatedBy'],
      updatedOn: map['updatedOn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VaktaModel.fromJson(String source) =>
      VaktaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MedicineModel(userId: $userId, devoteeName: $devoteeName, sangha: $sangha, paaliDate: $paaliDate, sammilaniNo: $sammilaniNo, sammilaniYear: $sammilaniYear, pranaami: $pranaami, remark: $remark, createdBy: $createdBy, createdOn: $createdOn, updatedBy: $updatedBy, updatedOn: $updatedOn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VaktaModel &&
        other.userId == userId &&
        other.devoteeName == devoteeName &&
        other.sangha == sangha &&
        other.paaliDate == paaliDate &&
        other.sammilaniNo == sammilaniNo &&
        other.sammilaniYear == sammilaniYear &&
        other.pranaami == pranaami &&
        other.remark == remark &&
        other.createdBy == createdBy &&
        other.createdOn == createdOn &&
        other.updatedBy == updatedBy &&
        other.updatedOn == updatedOn;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        devoteeName.hashCode ^
        sangha.hashCode ^
        paaliDate.hashCode ^
        sammilaniNo.hashCode ^
        sammilaniYear.hashCode ^
        pranaami.hashCode ^
        remark.hashCode ^
        createdBy.hashCode ^
        createdOn.hashCode ^
        updatedBy.hashCode ^
        updatedOn.hashCode;
  }
}