import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:motivational_quote_app/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:like_button/like_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDzb7PDPmw54KdsYhT15sVHiBqGVoNBjE0",
      projectId: 'motivational-quote-app',
      messagingSenderId: '377603465409',
      appId: '1:377603465409:android:1800504cc8c11e23373440', // Your apiKey
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndexNumber = 0;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final size = 30.0;

  @override
  Widget build(BuildContext context) {
    String image = '';
    String quote = '';
    int likeCount = 0;
    bool isLoved = true;
    return Scaffold(
      backgroundColor: kBgColor,
      body: SafeArea(
        child: StreamBuilder(
          stream: firestore.collection('maindata').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            likeCount = snapshot.data!.docs[currentIndexNumber]["like"];
            isLoved =
                snapshot.data!.docs[currentIndexNumber]["isLiked"] ?? true;
            if (!snapshot.hasData) return const Text('Loading...');

            return Container(
              padding: EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 10),
              child: Column(children: [
                Swiper(
                  outer: true,
                  onIndexChanged: (value) {
                    setState(() {
                      currentIndexNumber = value;
                    });
                  },
                  curve: Curves.linear,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(kImageBorder),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              snapshot.data!.docs[index]["imageUrl"]),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                  itemWidth: kImageWidth,
                  itemHeight: kImageHeight,
                  layout: SwiperLayout.STACK,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quote of the Day',
                        style: kTitleTextStyle,
                      ),
                      Text(
                        snapshot.data!.docs[currentIndexNumber]["quote"],
                        textAlign: TextAlign.center,
                        style: kSubTitleTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Like button
                          SizedBox(
                            height: 55,
                            width: 120,
                            child: TextButton(
                              style: kButtonStyle,
                              onPressed: () {},
                              child: LikeButton(
                                isLiked: isLoved,
                                likeBuilder: (isLiked) {
                                  return Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border_outlined,
                                    color: isLiked ? Colors.red : Colors.grey,
                                  );
                                },
                                likeCountPadding: EdgeInsets.only(left: 5.0),
                                size: 30,
                                countPostion: CountPostion.left,
                                likeCount: likeCount,
                                onTap: (isLiked) async {
                                  if (isLiked) {
                                    firestore
                                        .collection("maindata")
                                        .doc(snapshot
                                            .data!.docs[currentIndexNumber].id)
                                        .update({
                                      'like': FieldValue.increment(-1),
                                      'isLiked': false
                                    });
                                    setState(() {
                                      likeCount -= 1;
                                      isLoved = false;
                                    });
                                  } else if (!isLiked) {
                                    firestore
                                        .collection("maindata")
                                        .doc(snapshot
                                            .data!.docs[currentIndexNumber].id)
                                        .update({
                                      'like': FieldValue.increment(1),
                                      'isLiked': true
                                    });
                                    setState(() {
                                      likeCount += 1;
                                      isLoved = true;
                                    });
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          //Share button
                          SizedBox(
                            height: 55,
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Stack(alignment: AlignmentDirectional.center
                                  ,children: [
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: <Color>[
                                          Color(0xFFeeaeca),
                                          Color(0xFF94bbe9),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Share.share(snapshot.data!
                                            .docs[currentIndexNumber]["quote"]);
                                      },
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.all(16.0),
                                          textStyle: const TextStyle(fontSize: 20)),
                                      child: Text("Share",),
                                    ),
                                    Icon(Icons.ios_share, color: Colors.white,),
                                  ],
                                ),
                              ]),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ))
              ]),
            );
          },
        ),
      ),
    );
  }
}
// const Text(
// 'Like 👍',
// style: TextStyle(fontWeight: FontWeight.bold),
// )
