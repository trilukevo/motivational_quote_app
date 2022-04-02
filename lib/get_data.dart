import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GetData {
  final String? imageUrl;
  final String? quote;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  GetData(
      {this.imageUrl, this.quote});
}
