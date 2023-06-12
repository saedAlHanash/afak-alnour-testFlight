class TestModel{
  List<Data> data = [];

  TestModel.fromJson(Map<String,dynamic> json){
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}



class Data{
  int? id;
  int? category_id;
 List<Questions> questions = [];
  Data.fromJson(Map<String,dynamic> json){
    id = json['id'];
    category_id = json['category_id'];
    json['questions'].forEach((element){
      questions.add(Questions.fromJson(element));
    });
  }
}

class Questions{
  int? id;
  String? question;
  int? exam_id;
  List<Answers> answers = [];

  Questions.fromJson(Map<String,dynamic> json){
    id = json['id'];
    question = json['question'];
    exam_id = json['exam_id'];
    json['answers'].forEach((element){
      answers.add(Answers.fromJson(element));
    });
  }
}


class Answers{
  int? id;
  String? answer;
  int? question_id;

  Answers.fromJson(Map<String,dynamic> json){
    id = json['id'];
    answer = json['answer'];
    question_id = json['question_id'];
  }
}
