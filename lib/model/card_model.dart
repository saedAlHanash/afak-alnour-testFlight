class CardModel {
  int? childId;
  int? subjectId;
  int? classId;
  int? price;
  String? childName;
  String? subjectName;
  String? className;
  bool? isPackage;

  CardModel(this.childId, this.childName, this.classId, this.className,
      this.price, this.subjectId, this.subjectName,this.isPackage);

  CardModel.fromJson(Map<String, dynamic> json) {
    childId = json['childId'];
    subjectId = json['subjectId'];
    classId = json['classId'];
    price = json['price'];
    childName = json['childName'];
    subjectName = json['subjectName'];
    className = json['className'];
    isPackage = json ['isPackage'];
  }

  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'childName': childName,
      'subjectName': subjectName,
      'isPackage' : isPackage,
      'childId' : childId,
      'subjectId' : subjectId,
      'classId' : classId,
      'className' : className,
    };
  }
}
