class PaymentModel {
  Map<String, List<int>> courses = {};
  Map<String, List<int>> package = {};
  Map<String, Map<String,int>> packageShow = {};
  Map<String, Map<String,int>> coursesShow = {};

  PaymentModel(this.courses,this.package,this.coursesShow,this.packageShow);

  Map<String, dynamic> toJson() {
    return {'courses': courses, 'package': package};
  }
}


