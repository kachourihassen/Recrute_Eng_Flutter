part of 'cvModel.dart';

CvModel _$CvModelFromJson(Map<String, dynamic> json) {
  return CvModel(
    username: json['username'] as String,
    lastname: json['lastname'] as String,
    title: json['title'] as String,
    email: json['email'] as String,
    mobile: json['mobile'] as String,
    adress: json['adress'] as String,
    date: json['date'] as String,
    about: json['about'] as String,
    education: json['education'] as String,
    skills: json['skills'] as String,
    experience: json['experience'] as String,
    intere: json['intere'] as String,
    reference: json['reference'] as String,
  );
}

Map<String, dynamic> _$CvModelToJson(CvModel instance) => <String, dynamic>{
      "username": instance.username,
      "lastname": instance.lastname,
      "title": instance.title,
      "email": instance.email,
      "mobile": instance.mobile,
      "adress": instance.adress,
      "date": instance.date,
      "about": instance.about,
      "education": instance.education,
      "skills": instance.skills,
      "experience": instance.experience,
      "intere": instance.intere,
      "reference": instance.reference,
    };
