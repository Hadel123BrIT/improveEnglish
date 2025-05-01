import 'package:cloud_firestore/cloud_firestore.dart';

class WordModel {
  final String id;
  final String term;
  final String meaning;
  final String? example; // مثال اختياري
  final String? pronunciation; // نطق اختياري

  WordModel({
    required this.id,
    required this.term,
    required this.meaning,
    this.example,
    this.pronunciation,
  });

  // تحويل من Map إلى Model
  factory WordModel.fromMap(Map<String, dynamic> map, String id) {
    return WordModel(
      id: id,
      term: map['term'] ?? '',
      meaning: map['meaning'] ?? '',
      example: map['example'],
      pronunciation: map['pronunciation'],
    );
  }

  // تحويل من Model إلى Map
  Map<String, dynamic> toMap() {
    return {
      'term': term,
      'meaning': meaning,
      if (example != null) 'example': example,
      if (pronunciation != null) 'pronunciation': pronunciation,
    };
  }
}