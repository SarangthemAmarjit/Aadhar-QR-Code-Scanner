class XmltoObject {
  XmltoObject({
    this.printLetterBarcodeData,
  });

  PrintLetterBarcodeData? printLetterBarcodeData;
}

class PrintLetterBarcodeData {
  PrintLetterBarcodeData({
    this.uid,
    this.name,
    this.gender,
    this.yob,
    this.co,
    this.loc,
    this.vtc,
    this.po,
    this.dist,
    this.subdist,
    this.state,
    this.pc,
    this.dob,
  });

  String? uid;
  String? name;
  String? gender;
  String? yob;
  String? co;
  String? loc;
  String? vtc;
  String? po;
  String? dist;
  String? subdist;
  String? state;
  String? pc;
  String? dob;

  factory PrintLetterBarcodeData.fromJson(Map<String?, dynamic> json) =>
      PrintLetterBarcodeData(
          uid: json['uid'],
          name: json['name'],
          gender: json['gender'],
          yob: json['yob'],
          co: json['co'],
          loc: json['loc'],
          vtc: json['vtc'],
          po: json['po'],
          dist: json['dist'],
          subdist: json['subdist'],
          state: json['state'],
          pc: json['pc'],
          dob: json['dob']);

  Map<String?, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "gender": gender,
        'yob': yob,
        "co": co,
        "loc": loc,
        "vtc": vtc,
        "po": po,
        "dist": dist,
        "subdist": subdist,
        "state": state,
        "pc": pc,
        "dob": dob
      };
}
