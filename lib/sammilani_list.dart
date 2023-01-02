import 'package:sdp/Models/sammilaniModel.dart';

class SammilaniUtility {
  static List<SammilaniModel> getAllSammilaniName() {
    var f = allSammilaniList.map((s) => s);
    return f.toList();
  }
}

// class SammilaniList {
//   SammilaniList(
//       {this.sammilaniNumber, this.sammilaniYear, this.sammilaniPlace});
//   int? sammilaniYear;
//   String? sammilaniPlace;
//   int? sammilaniNumber;
// }

final allSammilaniList = [
  SammilaniModel(
      sammilaniNumber: '1',
      sammilaniYear: '1947',
      sammilaniPlace: 'Ankoli, Berhampur'),
  SammilaniModel(
      sammilaniNumber: '2',
      sammilaniYear: '1948',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '3',
      sammilaniYear: '1949',
      sammilaniPlace: 'Banahara,Gopa, Puri'),
  SammilaniModel(
      sammilaniNumber: '4',
      sammilaniYear: '1950',
      sammilaniPlace: 'Digapahandi, Ganjam'),
  SammilaniModel(
      sammilaniNumber: '5',
      sammilaniYear: '1951',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '6',
      sammilaniYear: '1952',
      sammilaniPlace: 'Erabanga,Gopa, Puri'),
  SammilaniModel(
      sammilaniNumber: '7',
      sammilaniYear: '1953',
      sammilaniPlace: 'Padmapura,Sheragarh,Ganjam'),
  SammilaniModel(
      sammilaniNumber: '8',
      sammilaniYear: '1954',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '9',
      sammilaniYear: '1955',
      sammilaniPlace: 'Biratunga, Puri'),
  SammilaniModel(
      sammilaniNumber: '10',
      sammilaniYear: '1956',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '11',
      sammilaniYear: '1958',
      sammilaniPlace: 'Biratunga, Puri'),
  SammilaniModel(
      sammilaniNumber: '12',
      sammilaniYear: '1959',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '13',
      sammilaniYear: '1960',
      sammilaniPlace: 'Kendupatana,Cuttack'),
  SammilaniModel(
      sammilaniNumber: '14',
      sammilaniYear: '1962',
      sammilaniPlace: 'Chatara,Jagatsinghpur'),
  SammilaniModel(
      sammilaniNumber: '15',
      sammilaniYear: '1963',
      sammilaniPlace: 'Biratunga,Puri(Formality)'),
  SammilaniModel(
      sammilaniNumber: '17',
      sammilaniYear: '1964',
      sammilaniPlace: 'Jobra, Cuttack'),
  SammilaniModel(
      sammilaniNumber: '18', sammilaniYear: '1965', sammilaniPlace: 'BBSR'),
];
