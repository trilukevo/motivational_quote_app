import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class GetData extends StatelessWidget {
  final String? imageUrl;
  final String? quotes;
  final String? documentId;
  final TextStyle? style;
  final TextAlign? textAlign;
  // Create a list
  List<String> maindata = [];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  GetData({this.imageUrl, this.quotes, this.documentId, this.style, this.textAlign});

  @override
  Widget build(BuildContext context) {
    CollectionReference images =
        FirebaseFirestore.instance.collection('maindata');

    return FutureBuilder<DocumentSnapshot>(
      future: images.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("imageUrl: ${data['imageUrl']} and Quote: ${data['quote']}", style: style, textAlign: textAlign,);
        }

        return Text("loading");
      },
    );
  }
}
